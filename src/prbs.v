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


module prbs #(parameter seed = 0, parameter threshold = 2,parameter type = 0) 
(
    input wire clk,
    output reg dataOut
);

reg [1:32] lfsr;
integer i=0,j=0;

initial
begin
    lfsr = seed;
end

always @(posedge clk)
begin
    lfsr[1] <= ~(lfsr[32]^lfsr[22]^lfsr[2]^lfsr[1]);
    lfsr[2:32] <= lfsr[1:31];
end

always @(posedge clk)
begin
    if(!type)
    begin
        if(lfsr >= threshold)
            dataOut <= 1'b1;
        else
            dataOut <= 1'b0;
    end
    else
    begin
        if(lfsr < threshold)
            dataOut <= 1'b1;
        else
            dataOut <= 1'b0;
    end
end


always @(posedge clk)
begin
    j = j+1;
    if(dataOut)
        i = i+1;
end

endmodule
