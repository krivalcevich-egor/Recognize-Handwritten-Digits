`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// WEIGHT MEMORY
// This code create bram for 1 of 10 weights strings
// and send element with input address from the string to out.
//////////////////////////////////////////////////////////////////////////////////

module ROM_weights_5 #( 
    parameter int BITS = 24 // bit depth
)(
    input logic clk, // clock
    input logic [9:0] address, // address of current element from string
    output [BITS-1:0] dout // current element from string
);

(* rom_style = "block" *) reg [BITS-1:0] data;

always @(posedge clk)
begin
case(address)
10'b0000000000: data <= 24'hffff72; 
10'b0000000001: data <= 24'hffffec; 
10'b0000000010: data <= 24'hffffec; 
10'b0000000011: data <= 24'hffff41; 
10'b0000000100: data <= 24'hffffa6; 
10'b0000000101: data <= 24'hffff8e; 
10'b0000000110: data <= 24'hffffff; 
10'b0000000111: data <= 24'hffff85; 
10'b0000001000: data <= 24'hffffcd; 
10'b0000001001: data <= 24'h000029; 
10'b0000001010: data <= 24'hffffcd; 
10'b0000001011: data <= 24'hffffc9; 
10'b0000001100: data <= 24'hffff6e; 
10'b0000001101: data <= 24'hfffff7; 
10'b0000001110: data <= 24'hffff3e; 
10'b0000001111: data <= 24'hffff60; 
10'b0000010000: data <= 24'hffff24; 
10'b0000010001: data <= 24'hffff4d; 
10'b0000010010: data <= 24'hffffe6; 
10'b0000010011: data <= 24'hffffcf; 
10'b0000010100: data <= 24'hffff22; 
10'b0000010101: data <= 24'hffffab; 
10'b0000010110: data <= 24'hffffc3; 
10'b0000010111: data <= 24'hffff92; 
10'b0000011000: data <= 24'hffff2e; 
10'b0000011001: data <= 24'hffffb1; 
10'b0000011010: data <= 24'hffffc2; 
10'b0000011011: data <= 24'hffff78; 
10'b0000011100: data <= 24'hfffff3; 
10'b0000011101: data <= 24'hffff17; 
10'b0000011110: data <= 24'hfffffe; 
10'b0000011111: data <= 24'hffff38; 
10'b0000100000: data <= 24'hfffff7; 
10'b0000100001: data <= 24'hffff80; 
10'b0000100010: data <= 24'hffffbe; 
10'b0000100011: data <= 24'hffff7a; 
10'b0000100100: data <= 24'hffff59; 
10'b0000100101: data <= 24'hffffc3; 
10'b0000100110: data <= 24'h000015; 
10'b0000100111: data <= 24'hffff3d; 
10'b0000101000: data <= 24'hffff79; 
10'b0000101001: data <= 24'hffff52; 
10'b0000101010: data <= 24'hffff20; 
10'b0000101011: data <= 24'hffffdb; 
10'b0000101100: data <= 24'hffff68; 
10'b0000101101: data <= 24'hffff4f; 
10'b0000101110: data <= 24'hffff6d; 
10'b0000101111: data <= 24'hffff63; 
10'b0000110000: data <= 24'hffffce; 
10'b0000110001: data <= 24'hffff35; 
10'b0000110010: data <= 24'hfffffd; 
10'b0000110011: data <= 24'hffff43; 
10'b0000110100: data <= 24'h000003; 
10'b0000110101: data <= 24'hfffff1; 
10'b0000110110: data <= 24'hffff4b; 
10'b0000110111: data <= 24'hffff9c; 
10'b0000111000: data <= 24'hffff9e; 
10'b0000111001: data <= 24'hffffd5; 
10'b0000111010: data <= 24'hffff79; 
10'b0000111011: data <= 24'hffff22; 
10'b0000111100: data <= 24'hffff49; 
10'b0000111101: data <= 24'hffffb2; 
10'b0000111110: data <= 24'hfffff8; 
10'b0000111111: data <= 24'hffffc4; 
10'b0001000000: data <= 24'hffff5f; 
10'b0001000001: data <= 24'hffff85; 
10'b0001000010: data <= 24'h00001f; 
10'b0001000011: data <= 24'hffff13; 
10'b0001000100: data <= 24'hfffff5; 
10'b0001000101: data <= 24'hffff59; 
10'b0001000110: data <= 24'hffff27; 
10'b0001000111: data <= 24'hffff4f; 
10'b0001001000: data <= 24'hffff72; 
10'b0001001001: data <= 24'hffffae; 
10'b0001001010: data <= 24'hffff85; 
10'b0001001011: data <= 24'hffff87; 
10'b0001001100: data <= 24'h000036; 
10'b0001001101: data <= 24'h000006; 
10'b0001001110: data <= 24'h000017; 
10'b0001001111: data <= 24'hffff54; 
10'b0001010000: data <= 24'hffff21; 
10'b0001010001: data <= 24'hffff91; 
10'b0001010010: data <= 24'hfffff2; 
10'b0001010011: data <= 24'hffffc3; 
10'b0001010100: data <= 24'hffffd6; 
10'b0001010101: data <= 24'hffffc0; 
10'b0001010110: data <= 24'hffff4b; 
10'b0001010111: data <= 24'hfffff4; 
10'b0001011000: data <= 24'hffff39; 
10'b0001011001: data <= 24'hffff7c; 
10'b0001011010: data <= 24'hffff13; 
10'b0001011011: data <= 24'hffff65; 
10'b0001011100: data <= 24'hffff24; 
10'b0001011101: data <= 24'hffff63; 
10'b0001011110: data <= 24'hfffe81; 
10'b0001011111: data <= 24'hfffe17; 
10'b0001100000: data <= 24'hfffee9; 
10'b0001100001: data <= 24'hfffefa; 
10'b0001100010: data <= 24'hfffebe; 
10'b0001100011: data <= 24'hffff95; 
10'b0001100100: data <= 24'hffffd2; 
10'b0001100101: data <= 24'hffff03; 
10'b0001100110: data <= 24'hffff68; 
10'b0001100111: data <= 24'hffffd0; 
10'b0001101000: data <= 24'hffffde; 
10'b0001101001: data <= 24'hffff97; 
10'b0001101010: data <= 24'hffff00; 
10'b0001101011: data <= 24'hffff54; 
10'b0001101100: data <= 24'hfffecb; 
10'b0001101101: data <= 24'h000024; 
10'b0001101110: data <= 24'h000016; 
10'b0001101111: data <= 24'hffff36; 
10'b0001110000: data <= 24'hffff28; 
10'b0001110001: data <= 24'hffff7a; 
10'b0001110010: data <= 24'h000016; 
10'b0001110011: data <= 24'h00000c; 
10'b0001110100: data <= 24'h00001e; 
10'b0001110101: data <= 24'hffff65; 
10'b0001110110: data <= 24'hffff5a; 
10'b0001110111: data <= 24'hfffea6; 
10'b0001111000: data <= 24'hfffdb9; 
10'b0001111001: data <= 24'hfffcfa; 
10'b0001111010: data <= 24'hfffb95; 
10'b0001111011: data <= 24'hfffd2e; 
10'b0001111100: data <= 24'hfffd28; 
10'b0001111101: data <= 24'hfffc2f; 
10'b0001111110: data <= 24'hfffde6; 
10'b0001111111: data <= 24'hfffffd; 
10'b0010000000: data <= 24'hffffc0; 
10'b0010000001: data <= 24'h0000b6; 
10'b0010000010: data <= 24'hffffc9; 
10'b0010000011: data <= 24'hfffeeb; 
10'b0010000100: data <= 24'hfffe95; 
10'b0010000101: data <= 24'hffff40; 
10'b0010000110: data <= 24'hffff63; 
10'b0010000111: data <= 24'hffff92; 
10'b0010001000: data <= 24'hffff78; 
10'b0010001001: data <= 24'h000033; 
10'b0010001010: data <= 24'h00001d; 
10'b0010001011: data <= 24'hffff9c; 
10'b0010001100: data <= 24'hffffae; 
10'b0010001101: data <= 24'h000033; 
10'b0010001110: data <= 24'hffff51; 
10'b0010001111: data <= 24'hffff37; 
10'b0010010000: data <= 24'hffff6b; 
10'b0010010001: data <= 24'hfffe9f; 
10'b0010010010: data <= 24'hfffdea; 
10'b0010010011: data <= 24'hfffdfc; 
10'b0010010100: data <= 24'hfffeae; 
10'b0010010101: data <= 24'hffffc1; 
10'b0010010110: data <= 24'h000072; 
10'b0010010111: data <= 24'h00007b; 
10'b0010011000: data <= 24'hffff49; 
10'b0010011001: data <= 24'hfffefa; 
10'b0010011010: data <= 24'hffff62; 
10'b0010011011: data <= 24'hffffb6; 
10'b0010011100: data <= 24'h000105; 
10'b0010011101: data <= 24'h00010b; 
10'b0010011110: data <= 24'h0001fb; 
10'b0010011111: data <= 24'h00013c; 
10'b0010100000: data <= 24'h000132; 
10'b0010100001: data <= 24'h000189; 
10'b0010100010: data <= 24'h0002d5; 
10'b0010100011: data <= 24'h000269; 
10'b0010100100: data <= 24'h0001b1; 
10'b0010100101: data <= 24'h0000ef; 
10'b0010100110: data <= 24'h000095; 
10'b0010100111: data <= 24'h000038; 
10'b0010101000: data <= 24'hffff3f; 
10'b0010101001: data <= 24'hffff2e; 
10'b0010101010: data <= 24'h00001b; 
10'b0010101011: data <= 24'hffff36; 
10'b0010101100: data <= 24'hfffefb; 
10'b0010101101: data <= 24'hfffd91; 
10'b0010101110: data <= 24'hfffee8; 
10'b0010101111: data <= 24'hffffdf; 
10'b0010110000: data <= 24'hffffea; 
10'b0010110001: data <= 24'h0000fd; 
10'b0010110010: data <= 24'h00020c; 
10'b0010110011: data <= 24'h0001b4; 
10'b0010110100: data <= 24'h00004a; 
10'b0010110101: data <= 24'h0000a1; 
10'b0010110110: data <= 24'hffffb8; 
10'b0010110111: data <= 24'hffff07; 
10'b0010111000: data <= 24'hffff6a; 
10'b0010111001: data <= 24'hffff81; 
10'b0010111010: data <= 24'h000006; 
10'b0010111011: data <= 24'h0001f2; 
10'b0010111100: data <= 24'h00011d; 
10'b0010111101: data <= 24'h000144; 
10'b0010111110: data <= 24'h0003de; 
10'b0010111111: data <= 24'h0004a6; 
10'b0011000000: data <= 24'h00053a; 
10'b0011000001: data <= 24'h0002c4; 
10'b0011000010: data <= 24'h00015e; 
10'b0011000011: data <= 24'h000055; 
10'b0011000100: data <= 24'hffff93; 
10'b0011000101: data <= 24'hffffc5; 
10'b0011000110: data <= 24'hffffab; 
10'b0011000111: data <= 24'hfffeff; 
10'b0011001000: data <= 24'hfffd2c; 
10'b0011001001: data <= 24'hfffcaf; 
10'b0011001010: data <= 24'hfffdfb; 
10'b0011001011: data <= 24'h000043; 
10'b0011001100: data <= 24'h000153; 
10'b0011001101: data <= 24'h000299; 
10'b0011001110: data <= 24'h000287; 
10'b0011001111: data <= 24'h000235; 
10'b0011010000: data <= 24'h0000a4; 
10'b0011010001: data <= 24'hffffca; 
10'b0011010010: data <= 24'hffff4b; 
10'b0011010011: data <= 24'h00000c; 
10'b0011010100: data <= 24'h000118; 
10'b0011010101: data <= 24'h0000fd; 
10'b0011010110: data <= 24'h000141; 
10'b0011010111: data <= 24'h0002cd; 
10'b0011011000: data <= 24'h00026c; 
10'b0011011001: data <= 24'h0002e5; 
10'b0011011010: data <= 24'h00040c; 
10'b0011011011: data <= 24'h00056e; 
10'b0011011100: data <= 24'h0006a1; 
10'b0011011101: data <= 24'h0004c9; 
10'b0011011110: data <= 24'h0000bd; 
10'b0011011111: data <= 24'hffffe3; 
10'b0011100000: data <= 24'hffffd0; 
10'b0011100001: data <= 24'h00002d; 
10'b0011100010: data <= 24'hfffffc; 
10'b0011100011: data <= 24'hfffea2; 
10'b0011100100: data <= 24'hfffbee; 
10'b0011100101: data <= 24'hfffc85; 
10'b0011100110: data <= 24'hfffd7b; 
10'b0011100111: data <= 24'h000028; 
10'b0011101000: data <= 24'h0001f8; 
10'b0011101001: data <= 24'h000094; 
10'b0011101010: data <= 24'h00010f; 
10'b0011101011: data <= 24'h00020e; 
10'b0011101100: data <= 24'h000141; 
10'b0011101101: data <= 24'hfffe97; 
10'b0011101110: data <= 24'hfffce9; 
10'b0011101111: data <= 24'hfffe21; 
10'b0011110000: data <= 24'hfffeda; 
10'b0011110001: data <= 24'h00001c; 
10'b0011110010: data <= 24'h000051; 
10'b0011110011: data <= 24'h000255; 
10'b0011110100: data <= 24'h000276; 
10'b0011110101: data <= 24'h000382; 
10'b0011110110: data <= 24'h00058c; 
10'b0011110111: data <= 24'h000742; 
10'b0011111000: data <= 24'h0009ae; 
10'b0011111001: data <= 24'h000641; 
10'b0011111010: data <= 24'h000124; 
10'b0011111011: data <= 24'hffffe2; 
10'b0011111100: data <= 24'hffff33; 
10'b0011111101: data <= 24'hffff88; 
10'b0011111110: data <= 24'hffff20; 
10'b0011111111: data <= 24'hfffe19; 
10'b0100000000: data <= 24'hfffdd1; 
10'b0100000001: data <= 24'hfffdfb; 
10'b0100000010: data <= 24'h00003f; 
10'b0100000011: data <= 24'hffffdc; 
10'b0100000100: data <= 24'h0001ae; 
10'b0100000101: data <= 24'h000176; 
10'b0100000110: data <= 24'h000197; 
10'b0100000111: data <= 24'h00043d; 
10'b0100001000: data <= 24'h0002bc; 
10'b0100001001: data <= 24'hfffede; 
10'b0100001010: data <= 24'hfffc47; 
10'b0100001011: data <= 24'hfffaa9; 
10'b0100001100: data <= 24'hfffb03; 
10'b0100001101: data <= 24'hfffd19; 
10'b0100001110: data <= 24'hffff56; 
10'b0100001111: data <= 24'hfffffb; 
10'b0100010000: data <= 24'h000244; 
10'b0100010001: data <= 24'h0004d9; 
10'b0100010010: data <= 24'h000704; 
10'b0100010011: data <= 24'h000999; 
10'b0100010100: data <= 24'h000c0f; 
10'b0100010101: data <= 24'h0007ed; 
10'b0100010110: data <= 24'h00016b; 
10'b0100010111: data <= 24'hffff71; 
10'b0100011000: data <= 24'hffffd4; 
10'b0100011001: data <= 24'hffff72; 
10'b0100011010: data <= 24'hffff41; 
10'b0100011011: data <= 24'hffff66; 
10'b0100011100: data <= 24'hffff5d; 
10'b0100011101: data <= 24'hffff97; 
10'b0100011110: data <= 24'h00015a; 
10'b0100011111: data <= 24'h000285; 
10'b0100100000: data <= 24'h0003ef; 
10'b0100100001: data <= 24'h00045b; 
10'b0100100010: data <= 24'h00042a; 
10'b0100100011: data <= 24'h00050a; 
10'b0100100100: data <= 24'h000430; 
10'b0100100101: data <= 24'h000338; 
10'b0100100110: data <= 24'hffff4f; 
10'b0100100111: data <= 24'hfffd5e; 
10'b0100101000: data <= 24'hfffb9c; 
10'b0100101001: data <= 24'hfffbbf; 
10'b0100101010: data <= 24'hfffb99; 
10'b0100101011: data <= 24'hfffafb; 
10'b0100101100: data <= 24'hfffc90; 
10'b0100101101: data <= 24'hfffeef; 
10'b0100101110: data <= 24'h000095; 
10'b0100101111: data <= 24'h000338; 
10'b0100110000: data <= 24'h00066d; 
10'b0100110001: data <= 24'h0004d5; 
10'b0100110010: data <= 24'h0001a5; 
10'b0100110011: data <= 24'hffff71; 
10'b0100110100: data <= 24'hffff3f; 
10'b0100110101: data <= 24'h000001; 
10'b0100110110: data <= 24'hffff63; 
10'b0100110111: data <= 24'hffff99; 
10'b0100111000: data <= 24'hffff61; 
10'b0100111001: data <= 24'hffffe9; 
10'b0100111010: data <= 24'h000226; 
10'b0100111011: data <= 24'h0002a0; 
10'b0100111100: data <= 24'h0003cb; 
10'b0100111101: data <= 24'h000381; 
10'b0100111110: data <= 24'h000291; 
10'b0100111111: data <= 24'h0002d4; 
10'b0101000000: data <= 24'h0004ad; 
10'b0101000001: data <= 24'h00045e; 
10'b0101000010: data <= 24'h000012; 
10'b0101000011: data <= 24'hfffd47; 
10'b0101000100: data <= 24'hfffca0; 
10'b0101000101: data <= 24'hfffc5e; 
10'b0101000110: data <= 24'hfffb26; 
10'b0101000111: data <= 24'hfff93c; 
10'b0101001000: data <= 24'hfff62d; 
10'b0101001001: data <= 24'hfff6fb; 
10'b0101001010: data <= 24'hfff89c; 
10'b0101001011: data <= 24'hfffa9c; 
10'b0101001100: data <= 24'hfffe15; 
10'b0101001101: data <= 24'h000036; 
10'b0101001110: data <= 24'h00008a; 
10'b0101001111: data <= 24'hffffac; 
10'b0101010000: data <= 24'hffffaa; 
10'b0101010001: data <= 24'hffffb9; 
10'b0101010010: data <= 24'hffff98; 
10'b0101010011: data <= 24'hffff6f; 
10'b0101010100: data <= 24'hffff92; 
10'b0101010101: data <= 24'h000117; 
10'b0101010110: data <= 24'h000278; 
10'b0101010111: data <= 24'h000234; 
10'b0101011000: data <= 24'h00019e; 
10'b0101011001: data <= 24'h0000ed; 
10'b0101011010: data <= 24'h0002bc; 
10'b0101011011: data <= 24'h0005a9; 
10'b0101011100: data <= 24'h000549; 
10'b0101011101: data <= 24'h00056b; 
10'b0101011110: data <= 24'h00008f; 
10'b0101011111: data <= 24'hfffd40; 
10'b0101100000: data <= 24'hfffae4; 
10'b0101100001: data <= 24'hfffbdd; 
10'b0101100010: data <= 24'hfffd31; 
10'b0101100011: data <= 24'hfffbf8; 
10'b0101100100: data <= 24'hfffb68; 
10'b0101100101: data <= 24'hfff861; 
10'b0101100110: data <= 24'hfff74e; 
10'b0101100111: data <= 24'hfff872; 
10'b0101101000: data <= 24'hfffaf3; 
10'b0101101001: data <= 24'hfffe91; 
10'b0101101010: data <= 24'h000013; 
10'b0101101011: data <= 24'hffffff; 
10'b0101101100: data <= 24'hffffb3; 
10'b0101101101: data <= 24'hffff49; 
10'b0101101110: data <= 24'hffff3d; 
10'b0101101111: data <= 24'hffff78; 
10'b0101110000: data <= 24'hffffd7; 
10'b0101110001: data <= 24'h000092; 
10'b0101110010: data <= 24'h0001a7; 
10'b0101110011: data <= 24'h000136; 
10'b0101110100: data <= 24'h000167; 
10'b0101110101: data <= 24'h000128; 
10'b0101110110: data <= 24'h0003ce; 
10'b0101110111: data <= 24'h000441; 
10'b0101111000: data <= 24'h00032a; 
10'b0101111001: data <= 24'h0002f5; 
10'b0101111010: data <= 24'hffff68; 
10'b0101111011: data <= 24'hfffcba; 
10'b0101111100: data <= 24'hfffaad; 
10'b0101111101: data <= 24'hfffd30; 
10'b0101111110: data <= 24'hffff00; 
10'b0101111111: data <= 24'hfffed8; 
10'b0110000000: data <= 24'hffff73; 
10'b0110000001: data <= 24'hfffdd7; 
10'b0110000010: data <= 24'hfffc19; 
10'b0110000011: data <= 24'hfffa4c; 
10'b0110000100: data <= 24'hfffbb4; 
10'b0110000101: data <= 24'hffff41; 
10'b0110000110: data <= 24'hffff30; 
10'b0110000111: data <= 24'hffffe2; 
10'b0110001000: data <= 24'hffffb6; 
10'b0110001001: data <= 24'hffff3a; 
10'b0110001010: data <= 24'hffff9e; 
10'b0110001011: data <= 24'hffff0b; 
10'b0110001100: data <= 24'hffffae; 
10'b0110001101: data <= 24'hffffa7; 
10'b0110001110: data <= 24'hfffffb; 
10'b0110001111: data <= 24'hffffd1; 
10'b0110010000: data <= 24'h0001c0; 
10'b0110010001: data <= 24'h0002c5; 
10'b0110010010: data <= 24'h000352; 
10'b0110010011: data <= 24'h0000a3; 
10'b0110010100: data <= 24'h000120; 
10'b0110010101: data <= 24'hffffcb; 
10'b0110010110: data <= 24'hfffda0; 
10'b0110010111: data <= 24'hfffd44; 
10'b0110011000: data <= 24'hfffc34; 
10'b0110011001: data <= 24'hfffca5; 
10'b0110011010: data <= 24'hfffcdb; 
10'b0110011011: data <= 24'hfffe7c; 
10'b0110011100: data <= 24'hfffeb0; 
10'b0110011101: data <= 24'hfffecf; 
10'b0110011110: data <= 24'hffff47; 
10'b0110011111: data <= 24'hfffcde; 
10'b0110100000: data <= 24'hfffde4; 
10'b0110100001: data <= 24'hfffef1; 
10'b0110100010: data <= 24'hffffa0; 
10'b0110100011: data <= 24'hffff10; 
10'b0110100100: data <= 24'hffff29; 
10'b0110100101: data <= 24'h000021; 
10'b0110100110: data <= 24'hffff19; 
10'b0110100111: data <= 24'hffffa1; 
10'b0110101000: data <= 24'hfffea9; 
10'b0110101001: data <= 24'hfffdfd; 
10'b0110101010: data <= 24'hfffd2f; 
10'b0110101011: data <= 24'hfffe22; 
10'b0110101100: data <= 24'h0000ae; 
10'b0110101101: data <= 24'h00031e; 
10'b0110101110: data <= 24'h00017b; 
10'b0110101111: data <= 24'h00015d; 
10'b0110110000: data <= 24'h00012d; 
10'b0110110001: data <= 24'hfffef0; 
10'b0110110010: data <= 24'hfffc79; 
10'b0110110011: data <= 24'hfffbf2; 
10'b0110110100: data <= 24'hfffc57; 
10'b0110110101: data <= 24'hfffc40; 
10'b0110110110: data <= 24'hfffd5c; 
10'b0110110111: data <= 24'hffffde; 
10'b0110111000: data <= 24'hffff1a; 
10'b0110111001: data <= 24'hffff3e; 
10'b0110111010: data <= 24'hffff18; 
10'b0110111011: data <= 24'hfffef5; 
10'b0110111100: data <= 24'hffff45; 
10'b0110111101: data <= 24'hfffffa; 
10'b0110111110: data <= 24'h000025; 
10'b0110111111: data <= 24'hffff70; 
10'b0111000000: data <= 24'hffff7f; 
10'b0111000001: data <= 24'hffffac; 
10'b0111000010: data <= 24'hffffc8; 
10'b0111000011: data <= 24'hffff19; 
10'b0111000100: data <= 24'hffff7a; 
10'b0111000101: data <= 24'hfffdb6; 
10'b0111000110: data <= 24'hfffb6a; 
10'b0111000111: data <= 24'hfffa93; 
10'b0111001000: data <= 24'hfffc55; 
10'b0111001001: data <= 24'hfffdf8; 
10'b0111001010: data <= 24'hffff32; 
10'b0111001011: data <= 24'hfffed7; 
10'b0111001100: data <= 24'hffff3e; 
10'b0111001101: data <= 24'hfffd80; 
10'b0111001110: data <= 24'hfffb2f; 
10'b0111001111: data <= 24'hfffc17; 
10'b0111010000: data <= 24'hfffd29; 
10'b0111010001: data <= 24'hfffefa; 
10'b0111010010: data <= 24'hffff09; 
10'b0111010011: data <= 24'h000028; 
10'b0111010100: data <= 24'h0000cb; 
10'b0111010101: data <= 24'h000020; 
10'b0111010110: data <= 24'h0000dc; 
10'b0111010111: data <= 24'h000032; 
10'b0111011000: data <= 24'h000022; 
10'b0111011001: data <= 24'h00001f; 
10'b0111011010: data <= 24'hffff76; 
10'b0111011011: data <= 24'hffff81; 
10'b0111011100: data <= 24'hffff67; 
10'b0111011101: data <= 24'hfffff6; 
10'b0111011110: data <= 24'hffffff; 
10'b0111011111: data <= 24'h000011; 
10'b0111100000: data <= 24'hffff6b; 
10'b0111100001: data <= 24'h00002b; 
10'b0111100010: data <= 24'h000056; 
10'b0111100011: data <= 24'hfffc6b; 
10'b0111100100: data <= 24'hfff985; 
10'b0111100101: data <= 24'hfff9ef; 
10'b0111100110: data <= 24'hfffba8; 
10'b0111100111: data <= 24'hfffd63; 
10'b0111101000: data <= 24'hfffbea; 
10'b0111101001: data <= 24'hfffaba; 
10'b0111101010: data <= 24'hfffadf; 
10'b0111101011: data <= 24'hfffdaa; 
10'b0111101100: data <= 24'hfffef9; 
10'b0111101101: data <= 24'h00018d; 
10'b0111101110: data <= 24'h00025f; 
10'b0111101111: data <= 24'h00018c; 
10'b0111110000: data <= 24'h000190; 
10'b0111110001: data <= 24'h000074; 
10'b0111110010: data <= 24'h00000d; 
10'b0111110011: data <= 24'h0000dd; 
10'b0111110100: data <= 24'h0000e0; 
10'b0111110101: data <= 24'hffff43; 
10'b0111110110: data <= 24'hfffff8; 
10'b0111110111: data <= 24'h000005; 
10'b0111111000: data <= 24'h000016; 
10'b0111111001: data <= 24'hffff5f; 
10'b0111111010: data <= 24'hffff9a; 
10'b0111111011: data <= 24'hffff7d; 
10'b0111111100: data <= 24'h000148; 
10'b0111111101: data <= 24'h0001b2; 
10'b0111111110: data <= 24'h000407; 
10'b0111111111: data <= 24'h0000b5; 
10'b1000000000: data <= 24'hfffc20; 
10'b1000000001: data <= 24'hfffa5c; 
10'b1000000010: data <= 24'hfff893; 
10'b1000000011: data <= 24'hfff95f; 
10'b1000000100: data <= 24'hfffb3f; 
10'b1000000101: data <= 24'hfffd49; 
10'b1000000110: data <= 24'hfffea5; 
10'b1000000111: data <= 24'hffff6f; 
10'b1000001000: data <= 24'hffffe6; 
10'b1000001001: data <= 24'h0001d2; 
10'b1000001010: data <= 24'h0000ea; 
10'b1000001011: data <= 24'h0001a0; 
10'b1000001100: data <= 24'h000117; 
10'b1000001101: data <= 24'h000195; 
10'b1000001110: data <= 24'h00014e; 
10'b1000001111: data <= 24'h0001ce; 
10'b1000010000: data <= 24'h0000f0; 
10'b1000010001: data <= 24'h000012; 
10'b1000010010: data <= 24'hffff50; 
10'b1000010011: data <= 24'hffffc8; 
10'b1000010100: data <= 24'h000001; 
10'b1000010101: data <= 24'hffff5e; 
10'b1000010110: data <= 24'hffffa9; 
10'b1000010111: data <= 24'h000023; 
10'b1000011000: data <= 24'h0001f2; 
10'b1000011001: data <= 24'h000353; 
10'b1000011010: data <= 24'h00047a; 
10'b1000011011: data <= 24'h000304; 
10'b1000011100: data <= 24'h0001e9; 
10'b1000011101: data <= 24'h00009f; 
10'b1000011110: data <= 24'hfffe93; 
10'b1000011111: data <= 24'hfffe7a; 
10'b1000100000: data <= 24'h000021; 
10'b1000100001: data <= 24'h0001d3; 
10'b1000100010: data <= 24'h0000af; 
10'b1000100011: data <= 24'h0000f8; 
10'b1000100100: data <= 24'h0000fc; 
10'b1000100101: data <= 24'hffffb1; 
10'b1000100110: data <= 24'h0000b5; 
10'b1000100111: data <= 24'h0000b1; 
10'b1000101000: data <= 24'h000026; 
10'b1000101001: data <= 24'h00012f; 
10'b1000101010: data <= 24'h000208; 
10'b1000101011: data <= 24'h00017c; 
10'b1000101100: data <= 24'h000020; 
10'b1000101101: data <= 24'hfffffa; 
10'b1000101110: data <= 24'hfffffe; 
10'b1000101111: data <= 24'hffff34; 
10'b1000110000: data <= 24'hfffff6; 
10'b1000110001: data <= 24'hffff12; 
10'b1000110010: data <= 24'hffff8e; 
10'b1000110011: data <= 24'hffff4e; 
10'b1000110100: data <= 24'h000043; 
10'b1000110101: data <= 24'h000230; 
10'b1000110110: data <= 24'h00028a; 
10'b1000110111: data <= 24'h000318; 
10'b1000111000: data <= 24'h000456; 
10'b1000111001: data <= 24'h0003a9; 
10'b1000111010: data <= 24'h000338; 
10'b1000111011: data <= 24'h0004b0; 
10'b1000111100: data <= 24'h0002eb; 
10'b1000111101: data <= 24'h000230; 
10'b1000111110: data <= 24'hffff62; 
10'b1000111111: data <= 24'hffff6f; 
10'b1001000000: data <= 24'h00019d; 
10'b1001000001: data <= 24'h0000d3; 
10'b1001000010: data <= 24'h000159; 
10'b1001000011: data <= 24'h0001c9; 
10'b1001000100: data <= 24'h000190; 
10'b1001000101: data <= 24'h00013a; 
10'b1001000110: data <= 24'h0002ef; 
10'b1001000111: data <= 24'h000231; 
10'b1001001000: data <= 24'hffffb7; 
10'b1001001001: data <= 24'hffff16; 
10'b1001001010: data <= 24'hffffae; 
10'b1001001011: data <= 24'hffff6c; 
10'b1001001100: data <= 24'hffff56; 
10'b1001001101: data <= 24'h000005; 
10'b1001001110: data <= 24'hffff08; 
10'b1001001111: data <= 24'hffffa3; 
10'b1001010000: data <= 24'h0000dd; 
10'b1001010001: data <= 24'hffffb9; 
10'b1001010010: data <= 24'h00010c; 
10'b1001010011: data <= 24'h0002d5; 
10'b1001010100: data <= 24'h000416; 
10'b1001010101: data <= 24'h0002ac; 
10'b1001010110: data <= 24'h000244; 
10'b1001010111: data <= 24'h000139; 
10'b1001011000: data <= 24'h000195; 
10'b1001011001: data <= 24'h0000fc; 
10'b1001011010: data <= 24'h000106; 
10'b1001011011: data <= 24'h00013f; 
10'b1001011100: data <= 24'h000053; 
10'b1001011101: data <= 24'h000101; 
10'b1001011110: data <= 24'h000084; 
10'b1001011111: data <= 24'h00019f; 
10'b1001100000: data <= 24'h000197; 
10'b1001100001: data <= 24'h0002ab; 
10'b1001100010: data <= 24'h000348; 
10'b1001100011: data <= 24'h0000b6; 
10'b1001100100: data <= 24'h000007; 
10'b1001100101: data <= 24'hffff38; 
10'b1001100110: data <= 24'hffff6e; 
10'b1001100111: data <= 24'hffff6f; 
10'b1001101000: data <= 24'hffffcf; 
10'b1001101001: data <= 24'hffff1d; 
10'b1001101010: data <= 24'hffff8a; 
10'b1001101011: data <= 24'hffff6e; 
10'b1001101100: data <= 24'h000050; 
10'b1001101101: data <= 24'hffff90; 
10'b1001101110: data <= 24'hffff0b; 
10'b1001101111: data <= 24'hffffd4; 
10'b1001110000: data <= 24'h000197; 
10'b1001110001: data <= 24'h000252; 
10'b1001110010: data <= 24'h000067; 
10'b1001110011: data <= 24'h00020e; 
10'b1001110100: data <= 24'h000353; 
10'b1001110101: data <= 24'h00041b; 
10'b1001110110: data <= 24'h000217; 
10'b1001110111: data <= 24'h000051; 
10'b1001111000: data <= 24'h00003b; 
10'b1001111001: data <= 24'h000083; 
10'b1001111010: data <= 24'h000113; 
10'b1001111011: data <= 24'h000112; 
10'b1001111100: data <= 24'h0001d5; 
10'b1001111101: data <= 24'h0001a8; 
10'b1001111110: data <= 24'h0001bb; 
10'b1001111111: data <= 24'h00009c; 
10'b1010000000: data <= 24'hffffe9; 
10'b1010000001: data <= 24'h000019; 
10'b1010000010: data <= 24'hffffaa; 
10'b1010000011: data <= 24'hffffc7; 
10'b1010000100: data <= 24'hffff45; 
10'b1010000101: data <= 24'hffffa5; 
10'b1010000110: data <= 24'hffffcb; 
10'b1010000111: data <= 24'hffffb7; 
10'b1010001000: data <= 24'hffff4e; 
10'b1010001001: data <= 24'hffff8b; 
10'b1010001010: data <= 24'hfffe9c; 
10'b1010001011: data <= 24'hffff5e; 
10'b1010001100: data <= 24'h000142; 
10'b1010001101: data <= 24'h00013b; 
10'b1010001110: data <= 24'h00013b; 
10'b1010001111: data <= 24'h000231; 
10'b1010010000: data <= 24'h00021a; 
10'b1010010001: data <= 24'h000171; 
10'b1010010010: data <= 24'h0001a8; 
10'b1010010011: data <= 24'h000184; 
10'b1010010100: data <= 24'h00017b; 
10'b1010010101: data <= 24'h0000af; 
10'b1010010110: data <= 24'hffff38; 
10'b1010010111: data <= 24'hffffe4; 
10'b1010011000: data <= 24'h0000ba; 
10'b1010011001: data <= 24'h00004b; 
10'b1010011010: data <= 24'h0000f9; 
10'b1010011011: data <= 24'hffff64; 
10'b1010011100: data <= 24'h00002a; 
10'b1010011101: data <= 24'hffff80; 
10'b1010011110: data <= 24'hffff7e; 
10'b1010011111: data <= 24'h000027; 
10'b1010100000: data <= 24'hffffee; 
10'b1010100001: data <= 24'hffff85; 
10'b1010100010: data <= 24'hffff73; 
10'b1010100011: data <= 24'h00002c; 
10'b1010100100: data <= 24'hffff0c; 
10'b1010100101: data <= 24'hfffefd; 
10'b1010100110: data <= 24'hffffa3; 
10'b1010100111: data <= 24'hffffd1; 
10'b1010101000: data <= 24'hfffff1; 
10'b1010101001: data <= 24'h0001a1; 
10'b1010101010: data <= 24'h00021d; 
10'b1010101011: data <= 24'h0001a0; 
10'b1010101100: data <= 24'h00010e; 
10'b1010101101: data <= 24'h000178; 
10'b1010101110: data <= 24'h0002b6; 
10'b1010101111: data <= 24'h00023e; 
10'b1010110000: data <= 24'h000157; 
10'b1010110001: data <= 24'h0000a7; 
10'b1010110010: data <= 24'h00013e; 
10'b1010110011: data <= 24'h0000ce; 
10'b1010110100: data <= 24'hfffff4; 
10'b1010110101: data <= 24'hffffe2; 
10'b1010110110: data <= 24'hffffb5; 
10'b1010110111: data <= 24'h00000d; 
10'b1010111000: data <= 24'hffff58; 
10'b1010111001: data <= 24'hffffc4; 
10'b1010111010: data <= 24'h000019; 
10'b1010111011: data <= 24'hffff33; 
10'b1010111100: data <= 24'hffffa4; 
10'b1010111101: data <= 24'h000009; 
10'b1010111110: data <= 24'h000018; 
10'b1010111111: data <= 24'hffff29; 
10'b1011000000: data <= 24'hfffffe; 
10'b1011000001: data <= 24'hffffbd; 
10'b1011000010: data <= 24'hffff00; 
10'b1011000011: data <= 24'hffffa2; 
10'b1011000100: data <= 24'hffff1b; 
10'b1011000101: data <= 24'h000087; 
10'b1011000110: data <= 24'h000065; 
10'b1011000111: data <= 24'h00011a; 
10'b1011001000: data <= 24'h000118; 
10'b1011001001: data <= 24'h0001eb; 
10'b1011001010: data <= 24'h00001b; 
10'b1011001011: data <= 24'h000092; 
10'b1011001100: data <= 24'h00007c; 
10'b1011001101: data <= 24'h0000f1; 
10'b1011001110: data <= 24'hffff5f; 
10'b1011001111: data <= 24'hfffff9; 
10'b1011010000: data <= 24'hfffef4; 
10'b1011010001: data <= 24'h000017; 
10'b1011010010: data <= 24'hffff9c; 
10'b1011010011: data <= 24'hffff4c; 
10'b1011010100: data <= 24'hffffeb; 
10'b1011010101: data <= 24'h00000c; 
10'b1011010110: data <= 24'hffff1b; 
10'b1011010111: data <= 24'hffff87; 
10'b1011011000: data <= 24'hffffb8; 
10'b1011011001: data <= 24'hffffb1; 
10'b1011011010: data <= 24'hffff58; 
10'b1011011011: data <= 24'hffff81; 
10'b1011011100: data <= 24'hffff72; 
10'b1011011101: data <= 24'hffff8c; 
10'b1011011110: data <= 24'hffffd6; 
10'b1011011111: data <= 24'hffff59; 
10'b1011100000: data <= 24'hffff24; 
10'b1011100001: data <= 24'hffff8e; 
10'b1011100010: data <= 24'hffff6a; 
10'b1011100011: data <= 24'hffffe4; 
10'b1011100100: data <= 24'h000004; 
10'b1011100101: data <= 24'hffffc6; 
10'b1011100110: data <= 24'hffff60; 
10'b1011100111: data <= 24'hffffae; 
10'b1011101000: data <= 24'hffffdb; 
10'b1011101001: data <= 24'hffff58; 
10'b1011101010: data <= 24'hfffebd; 
10'b1011101011: data <= 24'hfffefa; 
10'b1011101100: data <= 24'hffffc9; 
10'b1011101101: data <= 24'hffffc7; 
10'b1011101110: data <= 24'hffff6c; 
10'b1011101111: data <= 24'hffffd5; 
10'b1011110000: data <= 24'hffff92; 
10'b1011110001: data <= 24'hffffb5; 
10'b1011110010: data <= 24'hffff78; 
10'b1011110011: data <= 24'hffff1b; 
10'b1011110100: data <= 24'hffffce; 
10'b1011110101: data <= 24'hffffe1; 
10'b1011110110: data <= 24'hffffea; 
10'b1011110111: data <= 24'hffffc0; 
10'b1011111000: data <= 24'hffff3d; 
10'b1011111001: data <= 24'hfffff4; 
10'b1011111010: data <= 24'hffff7c; 
10'b1011111011: data <= 24'hffff70; 
10'b1011111100: data <= 24'h00002f; 
10'b1011111101: data <= 24'hffff76; 
10'b1011111110: data <= 24'hffff63; 
10'b1011111111: data <= 24'hffffed; 
10'b1100000000: data <= 24'hffffac; 
10'b1100000001: data <= 24'hffff10; 
10'b1100000010: data <= 24'h000005; 
10'b1100000011: data <= 24'hffffb6; 
10'b1100000100: data <= 24'hffff26; 
10'b1100000101: data <= 24'hffff0f; 
10'b1100000110: data <= 24'hffff4c; 
10'b1100000111: data <= 24'hffff0b; 
10'b1100001000: data <= 24'hfffffc; 
10'b1100001001: data <= 24'hffff79; 
10'b1100001010: data <= 24'h00002d; 
10'b1100001011: data <= 24'hffff30; 
10'b1100001100: data <= 24'hffffc1; 
10'b1100001101: data <= 24'hffff97; 
10'b1100001110: data <= 24'hffff3f; 
10'b1100001111: data <= 24'hffffe2; 
endcase
end

assign dout = data;

endmodule