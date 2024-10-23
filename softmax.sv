`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// SOFTMAX activation function
// This code find max element of 10 input elements,
// but don't use exp() and as a result don't use probability. 
// This module just finde max elements whithout any transformations.
//////////////////////////////////////////////////////////////////////////////////

(*use_dsp = "yes"*) 
module softmax#( 
    parameter int BITS_INT = 4, // bit int depth
    parameter int BITS_FRC = 12,// bit frct depth
    parameter int HEIGHT = 10 // size of array_weight
)( 
    input logic clk, //clock
    input logic reset, // reset 
    input logic [BITS_INT + BITS_FRC - 1 : 0] result_layer [0 : HEIGHT - 1], // input 10 elements from full connected layer
    output logic [0 : BITS_INT + BITS_FRC - 1] predict_num // predict number
);   
                 
                 
logic [BITS_INT + BITS_FRC - 1 : 0] probab;      
     
            
////////////////////////////////////////////////////////////////////////////////
// predict_num
////////////////////////////////////////////////////////////////////////////////            
always_ff @(posedge clk) begin
    if(reset == 0) begin
        predict_num = 15; 
    end else begin
        case(probab)
            result_layer[0] : predict_num = 0;
            result_layer[1] : predict_num = 1;
            result_layer[2] : predict_num = 2;
            result_layer[3] : predict_num = 3;
            result_layer[4] : predict_num = 4;
            result_layer[5] : predict_num = 5;
            result_layer[6] : predict_num = 6;
            result_layer[7] : predict_num = 7;
            result_layer[8] : predict_num = 8;
            result_layer[9] : predict_num = 9;
            default : predict_num = 15;
        endcase
    end    
end

////////////////////////////////////////////////////////////////////////////////
// probability
////////////////////////////////////////////////////////////////////////////////    
always_comb begin
probab = 0;
    for(int i = 0; i < HEIGHT; i++) begin
        if(signed'(result_layer[i]) > signed'(probab)) begin // find max of 10 numbers
            probab = result_layer[i];
        end 
    end
end    

                 
endmodule