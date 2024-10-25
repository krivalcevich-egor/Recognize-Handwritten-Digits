`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// SOFTMAX activation function
// This code find max element of 10 input elements,
// but don't use exp() and as a result don't use probability. 
// This module just finde max elements whithout any transformations.
//////////////////////////////////////////////////////////////////////////////////

(*use_dsp = "yes"*) 
module softmax#( 
    parameter int BITS = 24, // bit depth
    parameter int HEIGHT = 10 // size of array_weight
)( 
    input logic reset, // reset 
    input logic [BITS - 1 : 0] result_layer [0 : HEIGHT - 1], // input 10 elements from full connected layer
    output logic [0 : BITS - 1] predict_num // predict number
);   
                 
                 
logic [BITS - 1 : 0] probab;      
            
            
always_ff @* begin
    if(!reset) begin
        predict_num <= 15; 
        probab <= 0;
    end else begin
        probab = result_layer[0]; 
        predict_num = 0;
        for(int i = 0; i < HEIGHT; i++) begin
            if(signed'(result_layer[i]) > signed'(probab)) begin // find max of 10 numbers
                predict_num = i;
                probab = result_layer[i];
            end
        end
    end    
end
                 
endmodule