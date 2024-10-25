`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// FULL CONNECTED LAYER 
// This code create 10 memory modules and 10 mac core
// modules. It's parallel processing each pixels in
// different mac core with required weights.
//////////////////////////////////////////////////////////////////////////////////

module full_connected_layer#( 
    parameter int BITS = 24,  // bit depth
    parameter int WIDTH = 784, // size of array
    parameter int HEIGHT = 10  // size of array_weight
)(
    input logic clk, // clock
    input logic reset, // reset
    input logic [9 : 0] counter, // counter for correct filling input array 
    input  logic [BITS - 1 : 0] input_pixel, // input pixel
    output logic full_connected_layer_done, // flag if this module finished
    output logic [BITS - 1 : 0] output_layer [HEIGHT - 1 : 0] // 10 output elements
);


logic [2 * BITS - 1 : 0] sum_out [HEIGHT - 1 : 0]; // previous accumulater for mac_core
logic [2 * BITS - 1 : 0] out [HEIGHT - 1 : 0]; // current accumulater for mac_core
logic [BITS - 1 : 0] pixels [WIDTH - 1 : 0] = '{default : 4096}; // array for input pixels
logic [BITS - 1 : 0] weight_data [0 : HEIGHT - 1]; // current weights for 10 mac cores
logic [BITS - 1 : 0] current_pixel; // current pixel for 10 mac core
logic picture_ready = 0; // flag if we read picture
logic [9:0] pixel_counter = 0; // counter for processing image

genvar j;
generate // create 10 memory module for 10 strings of weights
    for(j = 0; j < HEIGHT; j++) begin : weight_mem_instances
        weight_mem#( 
            .BITS(BITS), 
            .WIDTH(WIDTH), 
            .HEIGHT(HEIGHT), 
            .INDEX(j)  
        ) weight_mem_inst (
            .clk(clk), 
            .reset(reset), 
            .address(pixel_counter), 
            .data(weight_data[j]));
    end    
endgenerate

generate // create 10 mac core module for processing image in parallel 
    for(j = 0; j < HEIGHT; j++) begin : mac_core_instances
        mac_core #(
            .BITS(BITS), 
            .WIDTH(WIDTH)
        ) mac_core_inst (
            .clk(clk), 
            .reset(reset), 
            .picture_i(current_pixel),
            .weight_i(weight_data[j]), 
            .acc_prev(sum_out[j]), 
            .acc(out[j]));
    end
endgenerate
            
                                                
always_ff @(posedge clk or negedge reset) begin
    if (!reset) begin
        for (integer i = 0; i < HEIGHT; i++) begin
            output_layer[i] <= 0;
        end
        picture_ready <= 0;
        pixel_counter <= 0;
        full_connected_layer_done <= 0;
    end else begin
        if (!picture_ready) begin // read picture
                pixels[counter - 1] = input_pixel;
                if (counter == WIDTH) begin
                    picture_ready <= 1; // if read picture is done
                end    
        end else begin             
                if (pixel_counter < WIDTH - 1) begin
                    current_pixel <= pixels[pixel_counter]; // send to mac core current pixel
                    pixel_counter <= pixel_counter + 1; // inc counter
                    for (integer i = 0; i < HEIGHT; i++) begin
                        sum_out[i] <= (pixel_counter == 0) ? 0 : out[i]; // save mac core out
                    end
                end else if (pixel_counter + 1 == WIDTH) begin
                    full_connected_layer_done <= 1; // if processing is finish
                    pixel_counter <= 0;
                    for (integer i = 0; i < HEIGHT; i++) begin
                        output_layer[i] <= out[HEIGHT - i - 1][35:12]; // save output of mac_core
                    end
                end  
        end  
    end
end

endmodule