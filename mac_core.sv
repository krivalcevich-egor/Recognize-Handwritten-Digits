`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// MAC CORE
// This code executes the MAC command for 3 input arguments.
// 1th element is previos state of accumulator
// 2nd element is current pixel from pixels string.
// 3rd element is current weight from weights string.
//////////////////////////////////////////////////////////////////////////////////

(* use_dsp = "yes" *) 
module mac_core #( 
    parameter int BITS = 24, // bit depth
    parameter int WIDTH = 784 // size of array
)(
    input logic clk, // clock
    input logic reset, // reset
    input  logic [BITS-1:0] picture_i, // input pixel of image
    input  logic [BITS-1:0] weight_i, // input weight for this pixel
    input  logic [2 * BITS-1:0] acc_prev, // input previos accumulator
    output logic [2 * BITS-1:0] acc  // accumulator
);


always_ff @(posedge clk or negedge reset) begin
    if (!reset) begin
        acc <= 0;
    end else begin
        acc = signed'(acc_prev) + signed'(picture_i) * signed'(weight_i); // MAC: A = A + B * C
    end
end

endmodule
