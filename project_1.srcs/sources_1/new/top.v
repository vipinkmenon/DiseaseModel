`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2018 03:33:45 PM
// Design Name: 
// Module Name: top
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


module top #(parameter numAgents = 1000) (
input  wire clk,
input  wire [31:0] seedValue,
input  wire loadSeed,
input  wire [31:0] address,
input  wire initState,
input  wire loadState,
output wire [numAgents-1:0] currState,
input  wire loadConnectivity,
input  wire [31:0] valConnectivity
);

wire [numAgents-1 : 0] connectOutEdge [numAgents-1 : 0];
reg [numAgents-1 : 0] connectInEdge [numAgents-1 : 0];

generate
genvar i;
    for(i=0;i<numAgents;i=i+1)
    begin:agentInst
        agent #(.Nodeaddress(i), .numAgents(numAgents)) ag (
            .clk(clk),
            .neighbourEdges(connectInEdge[i]),
            .outputEdges(connectOutEdge[i]),
            .seedValue(seedValue),
            .loadSeed(loadSeed),
            .address(address),
            .initState(initState),
            .loadState(loadState),
            .currState(currState[i]),
            .loadConnectivity(loadConnectivity),
            .valConnectivity(valConnectivity)               
    );
    end
endgenerate

integer j,k;
always @(*)
begin
    for(j=0;j<numAgents;j=j+1)
    begin:outloop
        for(k=0;k<numAgents;k=k+1)
        begin:inloop
            connectInEdge[j][k] = connectOutEdge[k][j];
        end
    end
end

endmodule