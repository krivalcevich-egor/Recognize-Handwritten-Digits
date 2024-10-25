
`timescale 1 ns / 1 ps

	module KE_fc_nn_v1_0 #
	(
		// Users to add parameters here
        parameter integer ID = 0,
		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface s_axi
		parameter integer C_s_axi_DATA_WIDTH	= 32,
		parameter integer C_s_axi_ADDR_WIDTH	= 16
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface s_axi
		input wire  s_axi_aclk,
		input wire  s_axi_aresetn,
		input wire [C_s_axi_ADDR_WIDTH-1 : 0] s_axi_awaddr,
		input wire [2 : 0] s_axi_awprot,
		input wire  s_axi_awvalid,
		output wire  s_axi_awready,
		input wire [C_s_axi_DATA_WIDTH-1 : 0] s_axi_wdata,
		input wire [(C_s_axi_DATA_WIDTH/8)-1 : 0] s_axi_wstrb,
		input wire  s_axi_wvalid,
		output wire  s_axi_wready,
		output wire [1 : 0] s_axi_bresp,
		output wire  s_axi_bvalid,
		input wire  s_axi_bready,
		input wire [C_s_axi_ADDR_WIDTH-1 : 0] s_axi_araddr,
		input wire [2 : 0] s_axi_arprot,
		input wire  s_axi_arvalid,
		output wire  s_axi_arready,
		output wire [C_s_axi_DATA_WIDTH-1 : 0] s_axi_rdata,
		output wire [1 : 0] s_axi_rresp,
		output wire  s_axi_rvalid,
		input wire  s_axi_rready
	);
//local parameters
localparam [31:0] CORE_VERSION            = {16'h0000,     /* MAJOR */
                                              8'h01,       /* MINOR */
                                              8'h03};      /* PATCH */ // 0.1.3
localparam [31:0] CORE_MAGIC              = 32'h47465550;    // PUFG


reg           up_wack = 'd0;
reg   [31:0]  up_rdata = 'd0;
reg           up_rack = 'd0;
reg           up_resetetn = 1'b0;

wire          up_clk;
wire          up_rreq_s;
wire  [7:0]   up_raddr_s;
wire          up_wreq_s;
wire  [7:0]   up_waddr_s;
wire  [31:0]  up_wdata_s;

wire  [23:0]  nn_data_in, MAC0_out, MEM0_out;
wire  [9:0]   CNT_out;
wire  [23:0]  prediction;
wire  reset_in;

reg   [31:0]  up_data_in = 'd0;
reg   [31:0]  up_nn_out  = 'h0;
reg   [31:0]  up_reset = 'h0;

reg new_data;
(* ASYNC_REG = "TRUE"*) reg [2:0] sync;
wire nn_en;

assign up_clk = s_axi_aclk;
assign nn_data_in = up_data_in[23:0];
assign reset_in = up_reset[0];

// Enable for NN (toggle synchronizer)
always @(posedge up_clk) begin
    sync[2] <= sync[1];
    sync[1] <= sync[0];
    sync[0] <= new_data;
end

assign nn_en = ((~sync[2]) & sync[1]);

nn #(   .BITS(24)
       ,.WIDTH(784)
       ,.HEIGHT(10)
) dut ( .clk(up_clk)
       ,.reset(reset_in)
       ,.en(nn_en)
       ,.CNT_out(CNT_out)
       ,.nn_in(nn_data_in)
       ,.nn_out(prediction) 
       ,.MAC0_out(MAC0_out)     // DFT: read MAC
       ,.MEM0_out(MEM0_out)     // DFT: read MEM
); 

always @(posedge up_clk) up_nn_out[23:0] <= prediction;

up_axi #(
  .AXI_ADDRESS_WIDTH(10))
i_up_axi (
  .up_rstn (s_axi_aresetn),
  .up_clk (up_clk),
  .up_axi_awvalid (s_axi_awvalid),
  .up_axi_awaddr (s_axi_awaddr),
  .up_axi_awready (s_axi_awready),
  .up_axi_wvalid (s_axi_wvalid),
  .up_axi_wdata (s_axi_wdata),
  .up_axi_wstrb (s_axi_wstrb),
  .up_axi_wready (s_axi_wready),
  .up_axi_bvalid (s_axi_bvalid),
  .up_axi_bresp (s_axi_bresp),
  .up_axi_bready (s_axi_bready),
  .up_axi_arvalid (s_axi_arvalid),
  .up_axi_araddr (s_axi_araddr),
  .up_axi_arready (s_axi_arready),
  .up_axi_rvalid (s_axi_rvalid),
  .up_axi_rresp (s_axi_rresp),
  .up_axi_rdata (s_axi_rdata),
  .up_axi_rready (s_axi_rready),
  .up_wreq (up_wreq_s),
  .up_waddr (up_waddr_s),
  .up_wdata (up_wdata_s),
  .up_wack (up_wack),
  .up_rreq (up_rreq_s),
  .up_raddr (up_raddr_s),
  .up_rdata (up_rdata),
  .up_rack (up_rack));

//axi registers write
always @(posedge up_clk) begin
    new_data<='d0;
    if (up_resetetn == 1'b0) begin
       up_data_in <= 'd0;
	   up_reset <= 'd0;
    end else begin
  
    // WRITE DATA_IN
    if ((up_wreq_s == 1'b1) && (up_waddr_s == 8'h04)) begin
      up_data_in <= up_wdata_s;
      new_data<='d1;
    end

    // WRITE RESET
    if ((up_wreq_s == 1'b1) && (up_waddr_s == 8'h03)) begin
      up_reset <= up_wdata_s;
    end
  end
end

//writing reset
always @(posedge up_clk) begin
  if (s_axi_aresetn == 1'b0) begin
    up_wack <= 'd0;
    up_resetetn <= 1'd0;
  end else begin
    up_wack <= up_wreq_s;
    if ((up_wreq_s == 1'b1) && (up_waddr_s == 8'h20)) begin
      up_resetetn <= up_wdata_s[0];
    end else begin
      up_resetetn <= 1'd1;
    end
  end
end

//axi registers read
always @(posedge up_clk) begin
  if (s_axi_aresetn == 1'b0) begin
    up_rack <= 'd0;
    up_rdata <= 'd0;
  end else begin
    up_rack <= up_rreq_s;
    if (up_rreq_s == 1'b1) begin
      case (up_raddr_s)
        8'h00: up_rdata <= CORE_VERSION;
        8'h01: up_rdata <= ID;
        8'h02: up_rdata <= CORE_MAGIC;
        8'h03: up_rdata <= up_reset;
        8'h04: up_rdata <= up_data_in;
		8'h05: up_rdata <= up_nn_out;
		// Design for test
		8'h06: up_rdata <= CNT_out;
		8'h07: up_rdata <= MAC0_out;
		8'h08: up_rdata <= {8'h00, MEM0_out};
        default: up_rdata <= 0;
      endcase
    end else begin
      up_rdata <= 32'd0;
    end
  end
end

	endmodule
