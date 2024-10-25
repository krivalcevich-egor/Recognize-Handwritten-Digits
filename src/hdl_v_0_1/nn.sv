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
            input logic [9 : 0] pixel_counter, // counter for correct filling input array 
            input  logic [BITS - 1 : 0] input_pixel, // input pixel
            output logic [0 : BITS - 1] predict_num  // predict number
          );
          
          
logic [BITS - 1 : 0] output_layer [HEIGHT - 1 : 0];  // output from full connected layer
logic full_connected_layer_done; // flag if full connected layer done then softmax start work       
        
full_connected_layer #( .BITS(BITS), .WIDTH(WIDTH), .HEIGHT(HEIGHT))
                  dut ( .clk(clk),
                        .reset(reset),
                        .input_pixel(input_pixel),
                        .counter(pixel_counter),
                        .full_connected_layer_done(full_connected_layer_done),
                        .output_layer(output_layer) 
                      );          
 
softmax  #( .BITS(BITS),
            .HEIGHT(HEIGHT)) 
      sfm ( .reset(full_connected_layer_done),
            .result_layer(output_layer),
            .predict_num(predict_num));
                                                      
endmodule
