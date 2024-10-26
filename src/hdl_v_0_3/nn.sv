`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// TOP MODULE OF NEURAL NETWORK
// This code  connected softmax activation function
// with full connected layer.
//////////////////////////////////////////////////////////////////////////////////

module nn#( parameter int WGHT_INT = 6, // integer part 
            parameter int WGHT_FRC = 16, // fractional part
            parameter int WIDTH = 784, // size of array
            parameter int HEIGHT = 10) // size of array_weight
          ( input logic clk, // clock
            input logic reset, // reset
            input logic en,
            output logic [9:0] CNT_out,         // DFT: read counter
            output logic [31:0] MAC0_out,       // DFT: read MAC
            output logic [WGHT_INT + WGHT_FRC - 1:0] MEM0_out, // DFT: read MEM
            input  logic [WGHT_INT + WGHT_FRC - 1:0] nn_in, // input pixel
            output logic [WGHT_INT + WGHT_FRC - 1:0] nn_out  // predict number
          );
// Internal signals                
logic [WGHT_INT + WGHT_FRC - 1:0] mac_out [0:HEIGHT-1]; // current accumulater for mac_core
logic [WGHT_INT + WGHT_FRC - 1:0] weight_data [0 : HEIGHT - 1]; // current weights for 10 mac cores
logic [9:0] counter = {10{1'b0}};

always @(posedge clk) begin
    if (reset)
        counter <= 0;
    else if (en)
        counter <= counter + 1;
end

ROM_weights_0#(.WGHT_INT(WGHT_INT), .WGHT_FRC(WGHT_FRC)) mem_0 (.clk(clk), .address(counter), .dout(weight_data[0]));
ROM_weights_1#(.WGHT_INT(WGHT_INT), .WGHT_FRC(WGHT_FRC)) mem_1 (.clk(clk), .address(counter), .dout(weight_data[1]));
ROM_weights_2#(.WGHT_INT(WGHT_INT), .WGHT_FRC(WGHT_FRC)) mem_2 (.clk(clk), .address(counter), .dout(weight_data[2]));
ROM_weights_3#(.WGHT_INT(WGHT_INT), .WGHT_FRC(WGHT_FRC)) mem_3 (.clk(clk), .address(counter), .dout(weight_data[3]));
ROM_weights_4#(.WGHT_INT(WGHT_INT), .WGHT_FRC(WGHT_FRC)) mem_4 (.clk(clk), .address(counter), .dout(weight_data[4]));
ROM_weights_5#(.WGHT_INT(WGHT_INT), .WGHT_FRC(WGHT_FRC)) mem_5 (.clk(clk), .address(counter), .dout(weight_data[5]));
ROM_weights_6#(.WGHT_INT(WGHT_INT), .WGHT_FRC(WGHT_FRC)) mem_6 (.clk(clk), .address(counter), .dout(weight_data[6]));
ROM_weights_7#(.WGHT_INT(WGHT_INT), .WGHT_FRC(WGHT_FRC)) mem_7 (.clk(clk), .address(counter), .dout(weight_data[7]));
ROM_weights_8#(.WGHT_INT(WGHT_INT), .WGHT_FRC(WGHT_FRC)) mem_8 (.clk(clk), .address(counter), .dout(weight_data[8]));
ROM_weights_9#(.WGHT_INT(WGHT_INT), .WGHT_FRC(WGHT_FRC)) mem_9 (.clk(clk), .address(counter), .dout(weight_data[9]));

genvar j;
generate // create 10 mac core module for processing image in parallel 
    for(j = 0; j < HEIGHT; j++) begin : mac_core_instances
        mac_core #(
            .WGHT_INT(WGHT_INT), 
            .WGHT_FRC(WGHT_FRC), 
            .WIDTH(WIDTH)
        ) mac_core_inst (
            .clk(clk), .reset(reset), .en(en), 
            .din(nn_in),
            .mem_in(weight_data[j]), 
            .mac_out(mac_out[j]));
    end
endgenerate   
                      
// Design for test
assign MAC0_out = { {(32-WGHT_INT + WGHT_FRC){mac_out[0][WGHT_INT + WGHT_FRC-1]}}, mac_out[0]};                      
assign MEM0_out = weight_data[0];
assign CNT_out = counter;

softmax  #( .BITS(WGHT_INT + WGHT_FRC),
            .HEIGHT(HEIGHT)) 
      sfm ( //.clk(clk),
//            .reset(reset),
            .result_layer(mac_out),
            .predict_num(nn_out));
                                                      
endmodule
