`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// MAC CORE
// This code executes the MAC command for 2 input arguments.
// 1nd element is current pixel from pixels string.
// 2rd element is current weight from weights string.
//////////////////////////////////////////////////////////////////////////////////

(* use_dsp = "yes" *) 
module mac_core #( 
    parameter int BITS_INT = 4, // bit int depth
    parameter int BITS_FRC = 12,// bit frct depth
    parameter int WGHT_INT = 6, // weight int depth
    parameter int WGHT_FRC = 10,// weight frct depth
    parameter int WIDTH = 784 // size of array
)(
    input logic clk, // clock
    input logic reset, // reset
    input  logic [BITS_INT + BITS_FRC-1:0] picture_i, // input pixel of image
    input  logic [WGHT_INT + WGHT_FRC-1:0] weight_i, // input weight for this pixel
    output logic [(BITS_INT + WGHT_INT) + (BITS_FRC + WGHT_FRC)-1:0] acc  // accumulator
);

logic [(BITS_INT + WGHT_INT) + (BITS_FRC + WGHT_FRC)-1:0] acc_prev;

always_ff @(posedge clk) begin
    if (reset == 0) begin
        acc_prev <= 0;
    end else begin
        acc_prev <= signed'(acc_prev) + signed'(picture_i) * signed'(weight_i); // MAC: A = A + B * C
    end
end

assign acc = acc_prev;

endmodule