`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// FULL CONNECTED LAYER 
// This code create 10 memory modules and 10 mac core
// modules. It's parallel processing each pixels in
// different mac core with required weights.
//////////////////////////////////////////////////////////////////////////////////

module full_connected_layer#( 
    parameter int BITS_INT = 4, // bit int depth
    parameter int BITS_FRC = 12,// bit frct depth
    parameter int WGHT_INT = 6, // weight int depth
    parameter int WGHT_FRC = 10,// weight frct depth
    parameter int WIDTH = 784, // size of array
    parameter int HEIGHT = 10  // size of array_weight
)(
    input logic clk, // clock
    input logic reset, // reset
    input logic [9 : 0] counter, // counter for correct filling input array 
    input  logic [BITS_INT + BITS_FRC - 1 : 0] input_pixel, // input pixel
    output logic full_connected_layer_done, // flag if this module finished
    output logic [BITS_INT + BITS_FRC - 1 : 0] output_layer [HEIGHT - 1 : 0] // 10 output elements
);


logic [(BITS_INT + WGHT_INT) + (BITS_FRC + WGHT_FRC) - 1 : 0] out [HEIGHT - 1 : 0]; // current accumulater for mac_core
logic [BITS_INT + BITS_FRC - 1 : 0] pixels [WIDTH - 1 : 0] = '{default : 4096}; // array for input pixels
logic [WGHT_INT + WGHT_FRC - 1 : 0] weight_data [0 : HEIGHT - 1]; // current weights for 10 mac cores
logic [BITS_INT + BITS_FRC - 1 : 0] current_pixel; // current pixel for 10 mac core
logic picture_ready = 0; // flag if we read picture
logic [9:0] pixel_counter = 0; // counter for processing image


ROM_weights_0 #(
            .WGHT_INT(WGHT_INT), 
            .WGHT_FRC(WGHT_FRC)  
        ) ROM_weights_0_inst (
            .clk(clk), 
            .address(pixel_counter),
            .dout(weight_data[0]));

ROM_weights_1 #(
            .WGHT_INT(WGHT_INT), 
            .WGHT_FRC(WGHT_FRC) 
        ) ROM_weights_1_inst (
            .clk(clk), 
            .address(pixel_counter),
            .dout(weight_data[1]));

ROM_weights_2 #(
            .WGHT_INT(WGHT_INT), 
            .WGHT_FRC(WGHT_FRC)  
        ) ROM_weights_2_inst (
            .clk(clk), 
            .address(pixel_counter),
            .dout(weight_data[2]));

ROM_weights_3 #(
            .WGHT_INT(WGHT_INT), 
            .WGHT_FRC(WGHT_FRC) 
        ) ROM_weights_3_inst (
            .clk(clk), 
            .address(pixel_counter),
            .dout(weight_data[3]));
            
ROM_weights_4 #(
            .WGHT_INT(WGHT_INT), 
            .WGHT_FRC(WGHT_FRC) 
        ) ROM_weights_4_inst (
            .clk(clk), 
            .address(pixel_counter),
            .dout(weight_data[4]));

ROM_weights_5 #(
            .WGHT_INT(WGHT_INT), 
            .WGHT_FRC(WGHT_FRC)  
        ) ROM_weights_5_inst (
            .clk(clk), 
            .address(pixel_counter),
            .dout(weight_data[5]));
            
ROM_weights_6 #(
            .WGHT_INT(WGHT_INT), 
            .WGHT_FRC(WGHT_FRC) 
        ) ROM_weights_6_inst (
            .clk(clk), 
            .address(pixel_counter),
            .dout(weight_data[6]));
           
ROM_weights_7 #(
            .WGHT_INT(WGHT_INT), 
            .WGHT_FRC(WGHT_FRC) 
        ) ROM_weights_7_inst (
            .clk(clk), 
            .address(pixel_counter),
            .dout(weight_data[7]));

ROM_weights_8 #(
            .WGHT_INT(WGHT_INT), 
            .WGHT_FRC(WGHT_FRC) 
        ) ROM_weights_8_inst (
            .clk(clk), 
            .address(pixel_counter),
            .dout(weight_data[8]));
            
ROM_weights_9 #(
            .WGHT_INT(WGHT_INT), 
            .WGHT_FRC(WGHT_FRC) 
        ) ROM_weights_9_inst (
            .clk(clk), 
            .address(pixel_counter),
            .dout(weight_data[9]));

////////////////////////////////////////////////////////////////////////////////
// Create 10 mac core module for processing image in parallel 
////////////////////////////////////////////////////////////////////////////////                                                                                                                                                  
genvar j;
generate
    for(j = 0; j < HEIGHT; j++) begin : mac_core_instances
        mac_core #(
            .BITS_INT(BITS_INT), 
            .BITS_FRC(BITS_FRC), 
            .WGHT_INT(WGHT_INT), 
            .WGHT_FRC(WGHT_FRC),  
            .WIDTH(WIDTH)
        ) mac_core_inst (
            .clk(clk), 
            .reset(reset), 
            .picture_i(current_pixel),
            .weight_i(weight_data[j]), 

            .acc(out[j]));
    end
endgenerate
            
                                               
////////////////////////////////////////////////////////////////////////////////
// Full_connected_layer_done flag
////////////////////////////////////////////////////////////////////////////////
always_ff @(posedge clk) begin
    if (reset == 0) begin
        full_connected_layer_done <= 0;
    end else begin
        if (pixel_counter == WIDTH) begin
            full_connected_layer_done <= 1;
        end else begin
            full_connected_layer_done <= 0;
        end    
    end    
end

////////////////////////////////////////////////////////////////////////////////
// pixel counter
////////////////////////////////////////////////////////////////////////////////
always_ff @(posedge clk) begin
    if (reset == 0) begin
        pixel_counter <= 0;
    end else begin
        if (picture_ready == 1) begin
            if (pixel_counter < WIDTH) begin
                pixel_counter <= pixel_counter + 1;
            end else begin
                pixel_counter <= WIDTH;
            end
        end else begin
            pixel_counter <= 0;
        end    
    end    
end

////////////////////////////////////////////////////////////////////////////////
// pixels ROM
////////////////////////////////////////////////////////////////////////////////
always_ff @(posedge clk) begin
    if (reset == 0) begin
        pixels <= '{default : 0};
    end else begin
        pixels[counter - 1] = input_pixel;  
    end    
end

////////////////////////////////////////////////////////////////////////////////
// pixels flag
////////////////////////////////////////////////////////////////////////////////
always_ff @(posedge clk) begin
    if (reset == 0) begin
        picture_ready <= 0;
    end else begin
        if (counter == WIDTH) begin
            picture_ready <= 1; 
        end else begin
            picture_ready <= 0;
        end   
    end    
end

////////////////////////////////////////////////////////////////////////////////
// Send pixel to MAC
////////////////////////////////////////////////////////////////////////////////                                                
always_ff @(posedge clk) begin
    if (reset == 0) begin
        current_pixel <= 0;
    end else begin
        if (picture_ready == 1) begin // read picture          
           current_pixel <= pixels[pixel_counter]; // send to mac core current pixel
        end else begin
            current_pixel <= 0; // send to mac core current pixel
        end 
    end
end

////////////////////////////////////////////////////////////////////////////////
// Output of full connected layer
////////////////////////////////////////////////////////////////////////////////
always_ff @(posedge clk) begin
    if (reset == 0) begin
        for (integer i = 0; i < HEIGHT; i++) begin
            output_layer[i] <= 0;
        end
    end else begin
        if (pixel_counter == WIDTH) begin
            for (integer i = 0; i < HEIGHT; i++) begin
                output_layer[i] <= out[HEIGHT - i - 1][BITS_INT + WGHT_FRC + BITS_FRC - 1:WGHT_FRC];  // save output of mac_core
            end
        end else begin
            for (integer i = 0; i < HEIGHT; i++) begin
                output_layer[i] <= 0;
            end
        end 
    end    
end

//assign predict_num = full_connected_layer_done;

endmodule