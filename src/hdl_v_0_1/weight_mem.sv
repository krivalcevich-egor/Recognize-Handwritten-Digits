`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// WEIGHT MEMORY
// This code create bram for 1 of 10 weights strings
// and send element with input address from the string to out.
//////////////////////////////////////////////////////////////////////////////////

(* ram_style = "block" *)
module weight_mem #( 
    parameter int BITS = 24, // bit depth
    parameter int WIDTH = 784, // size of weight string 
    parameter int HEIGHT = 10, // number of weight strings
    parameter int INDEX = 0  // index of string(from 0 to 9)
)(
    input logic clk, // clock
    input logic reset, // reset
    input logic [9:0] address, // address of current element from string
    output logic [BITS-1:0] data // current element from string
);


reg [BITS-1:0] weight_mem [0 : WIDTH - 1];

initial begin
    case (INDEX) // read data from 1 of 10 mem files to weight_mem array
          0: $readmemh("C:/Users/DDCS_Student/SDST/neural_net/neural_net.srcs/sources_1/new/weight_0.mem", weight_mem); 
          1: $readmemh("C:/Users/DDCS_Student/SDST/neural_net/neural_net.srcs/sources_1/new/weight_1.mem", weight_mem); 
          2: $readmemh("C:/Users/DDCS_Student/SDST/neural_net/neural_net.srcs/sources_1/new/weight_2.mem", weight_mem); 
          3: $readmemh("C:/Users/DDCS_Student/SDST/neural_net/neural_net.srcs/sources_1/new/weight_3.mem", weight_mem); 
          4: $readmemh("C:/Users/DDCS_Student/SDST/neural_net/neural_net.srcs/sources_1/new/weight_4.mem", weight_mem); 
          5: $readmemh("C:/Users/DDCS_Student/SDST/neural_net/neural_net.srcs/sources_1/new/weight_5.mem", weight_mem); 
          6: $readmemh("C:/Users/DDCS_Student/SDST/neural_net/neural_net.srcs/sources_1/new/weight_6.mem", weight_mem); 
          7: $readmemh("C:/Users/DDCS_Student/SDST/neural_net/neural_net.srcs/sources_1/new/weight_7.mem", weight_mem); 
          8: $readmemh("C:/Users/DDCS_Student/SDST/neural_net/neural_net.srcs/sources_1/new/weight_8.mem", weight_mem); 
          9: $readmemh("C:/Users/DDCS_Student/SDST/neural_net/neural_net.srcs/sources_1/new/weight_9.mem", weight_mem);  
          default: weight_mem = '{default : 0};
    endcase
end


always_ff @(posedge clk or negedge reset) begin
    if (!reset) begin
        data <= 0;
    end else begin
        data <= weight_mem[address];
    end
end

endmodule
