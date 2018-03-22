`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2018 05:53:07 PM
// Design Name: 
// Module Name: prbs
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module prbs(
input wire clk,
output reg dataOut,
input wire loadSeed,
input wire [31:0] seedValue
);

reg [1:32] lfsr;
integer i;

initial
begin
    lfsr = 32'd0;
end

always @(posedge clk)
begin
    if(loadSeed)
        lfsr <= seedValue;
    else
    begin
        lfsr[1] <= ~(lfsr[32]^lfsr[22]^lfsr[2]^lfsr[1]);
        lfsr[2:32] <= lfsr[1:31];
    end
end

always @(posedge clk)
begin
    if(lfsr >= 32'h7FFFFFFF)
        dataOut <= 1'b1;
    else
        dataOut <= 1'b0;
end


endmodule
