`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// MAC CORE
// This code executes the MAC command for 2 input arguments.
// 1st element is current pixel from pixels string.
// 2nd element is current weight from weights string.
//////////////////////////////////////////////////////////////////////////////////

(* use_dsp = "yes" *) 
module mac_core #( 
    parameter int BITS = 24, // bit depth
    parameter int WIDTH = 784 // size of array
)(
    input logic clk, // clock
    input logic reset, // reset
    input logic en,
    input  logic [BITS-1:0] din, // input pixel of image
    input  logic [BITS-1:0] mem_in, // input weight for this pixel
    output logic [BITS-1:0] mac_out  // accumulator
);
logic [BITS-1:0] acc; // previous accumulater for mac_core
logic [BITS-1:0] mul_out;

//assign mul_out = signed'(picture_i) * signed'(weight_i);
MUL_N #(.N(BITS)) mul_inst(.A(din), .B(mem_in), .P(mul_out));

always_ff @(posedge clk) begin
    if (reset) begin
        acc <= 0;
    end else begin
        if (en) begin
            acc <= mul_out + acc; // MAC: A = A + B * C  
        end    
    end
end

assign mac_out = acc;

endmodule
