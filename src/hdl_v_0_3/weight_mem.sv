`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// WEIGHT MEMORY
// This code create bram for 1 of 10 weights strings
// and send element with input address from the string to out.
//////////////////////////////////////////////////////////////////////////////////

module weight_mem #( 
    parameter int BITS = 24, // bit depth
    parameter int WIDTH = 784, // size of weight string 
    parameter int HEIGHT = 10, // number of weight strings
    parameter int INDEX = 0,  // index of string(from 0 to 9)
    parameter string  INIT_FILE  = "c:\Users\m.vashkevich\xilinx\ip_repo\KE_fc_nn_1_0\src\weight_0.mem"
)(
    input logic clk, // clock
//    input logic reset, // reset
    input logic [9:0] address, // address of current element from string
    output logic [BITS-1:0] data // current element from string
);

(* rom_style = "block" *) reg [BITS-1:0] weight_mem [0 : WIDTH - 1];

initial begin
    if (INIT_FILE != "") begin
        $display("loading rom");
        $readmemh(INIT_FILE, weight_mem);
    end else begin
        $error("init file is needed");
    end
end

//initial begin
//    case (INDEX) // read data from 1 of 10 mem files to weight_mem array
//          0: $readmemh("0.mem", weight_mem); 
//          1: $readmemh("c:\Users\m.vashkevich\xilinx\ip_repo\KE_fc_nn_1_0\src\weight_1.mem", weight_mem); 
//          2: $readmemh("c:\Users\m.vashkevich\xilinx\ip_repo\KE_fc_nn_1_0\src\weight_2.mem", weight_mem); 
//          3: $readmemh("c:\Users\m.vashkevich\xilinx\ip_repo\KE_fc_nn_1_0\src\weight_3.mem", weight_mem); 
//          4: $readmemh("c:\Users\m.vashkevich\xilinx\ip_repo\KE_fc_nn_1_0\src\weight_4.mem", weight_mem); 
//          5: $readmemh("c:\Users\m.vashkevich\xilinx\ip_repo\KE_fc_nn_1_0\src\weight_5.mem", weight_mem); 
//          6: $readmemh("c:\Users\m.vashkevich\xilinx\ip_repo\KE_fc_nn_1_0\src\weight_6.mem", weight_mem); 
//          7: $readmemh("c:\Users\m.vashkevich\xilinx\ip_repo\KE_fc_nn_1_0\src\weight_7.mem", weight_mem); 
//          8: $readmemh("c:\Users\m.vashkevich\xilinx\ip_repo\KE_fc_nn_1_0\src\weight_8.mem", weight_mem); 
//          9: $readmemh("c:\Users\m.vashkevich\xilinx\ip_repo\KE_fc_nn_1_0\src\weight_9.mem", weight_mem);  
//          default: weight_mem = '{default : 1};
//    endcase
//end

always_ff @(posedge clk) begin
   data <= weight_mem[address];
end

endmodule
