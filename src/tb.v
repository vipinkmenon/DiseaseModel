`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2018 07:02:45 PM
// Design Name: 
// Module Name: tb
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


module tb();


reg clk;
reg loadseed;
reg initState;
reg loadState;
reg [3:0] randomNeighbours;

initial
begin
    clk = 0;
    forever
    begin
        clk = ~clk;
        #5;
    end
end

initial
begin
    loadseed = 0;
    initState = 0;
    loadState = 0;
    #5;
    @(posedge clk);
    loadState = 1;
    @(posedge clk);
    loadState = 0;
end

agent ag (
    .clk(clk),
    .neighbourEdges(randomNeighbours),
    .outputEdges(),
    .seedValue(0),
    .loadSeed(loadseed),
    .address(0),
    .initState(initState),
    .loadState(loadState),
    .currState()
);

always @(posedge clk)
begin
randomNeighbours[0] = $urandom()%2;
randomNeighbours[1] = $urandom()%2;
randomNeighbours[2] = 0;//$urandom()%2;
randomNeighbours[3] = 0;//$urandom()%2;
end

endmodule