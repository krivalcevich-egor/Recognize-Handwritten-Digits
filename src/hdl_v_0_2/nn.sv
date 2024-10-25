`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// TOP MODULE OF NEURAL NETWORK
// This code  connected softmax activation function
// with full connected layer.
//////////////////////////////////////////////////////////////////////////////////

module nn#( parameter int BITS = 24, // bit depth
            parameter int WIDTH = 784, // size of array
            parameter int HEIGHT = 10) // size of array_weight
          ( input logic clk, // clock
            input logic reset, // reset
            input logic en,
            output logic [9:0] CNT_out,         // DFT: read counter
            output logic [31:0] MAC0_out,       // DFT: read MAC
            output logic [BITS - 1:0] MEM0_out, // DFT: read MEM
            input  logic [BITS - 1:0] nn_in, // input pixel
            output logic [BITS - 1:0] nn_out  // predict number
          );
// Internal signals                
logic [BITS-1:0] mac_out [0:HEIGHT-1]; // current accumulater for mac_core
logic [BITS-1:0] weight_data [0 : HEIGHT - 1]; // current weights for 10 mac cores
logic [9:0] counter = {10{1'b0}};

always @(posedge clk) begin
    if (reset)
        counter <= 0;
    else if (en)
        counter <= counter + 1;
end

ROM_weights_0#(.BITS(24)) mem_0 (.clk(clk), .address(counter), .dout(weight_data[0]));
ROM_weights_1#(.BITS(24)) mem_1 (.clk(clk), .address(counter), .dout(weight_data[1]));
ROM_weights_2#(.BITS(24)) mem_2 (.clk(clk), .address(counter), .dout(weight_data[2]));
ROM_weights_3#(.BITS(24)) mem_3 (.clk(clk), .address(counter), .dout(weight_data[3]));
ROM_weights_4#(.BITS(24)) mem_4 (.clk(clk), .address(counter), .dout(weight_data[4]));
ROM_weights_5#(.BITS(24)) mem_5 (.clk(clk), .address(counter), .dout(weight_data[5]));
ROM_weights_6#(.BITS(24)) mem_6 (.clk(clk), .address(counter), .dout(weight_data[6]));
ROM_weights_7#(.BITS(24)) mem_7 (.clk(clk), .address(counter), .dout(weight_data[7]));
ROM_weights_8#(.BITS(24)) mem_8 (.clk(clk), .address(counter), .dout(weight_data[8]));
ROM_weights_9#(.BITS(24)) mem_9 (.clk(clk), .address(counter), .dout(weight_data[9]));

genvar j;
generate // create 10 mac core module for processing image in parallel 
    for(j = 0; j < HEIGHT; j++) begin : mac_core_instances
        mac_core #(
            .BITS(BITS), 
            .WIDTH(WIDTH)
        ) mac_core_inst (
            .clk(clk), .reset(reset), .en(en), 
            .din(nn_in),
            .mem_in(weight_data[j]), 
            .mac_out(mac_out[j]));
    end
endgenerate   
                      
// Design for test
assign MAC0_out = mac_out[0];                      
assign MEM0_out = weight_data[0];
assign CNT_out = counter;

softmax  #( .BITS(BITS),
            .HEIGHT(HEIGHT)) 
      sfm ( //.clk(clk),
//            .reset(reset),
            .result_layer(mac_out),
            .predict_num(nn_out));
                                                      
endmodule
