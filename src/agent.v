`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2018 06:53:11 PM
// Design Name: 
// Module Name: agent
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


module agent #(parameter Nodeaddress =0,parameter numAgents = 100) (
input  wire clk,
input  wire [numAgents-1:0] neighbourEdges,
output wire [numAgents-1:0] outputEdges,
input  wire [31:0] seedValue,
input  wire loadSeed,
input  wire [31:0] address,
input  wire initState,
input  wire loadState,
output wire currState,
input  wire loadConnectivity,
input  wire [31:0] valConnectivity
);

reg [numAgents-1:0] connectivityReg;
reg state;
wire infect;
wire recover;
wire infectNeighbour;
integer offset=0;

assign infect = |neighbourEdges;
assign outputEdges = connectivityReg & {numAgents{infectNeighbour}};

localparam SUS = 0,
           INF = 1;

assign currState = state;

always @(posedge clk)
begin
    if(loadConnectivity)
    begin
        connectivityReg[offset*32+:32] <= valConnectivity;
        offset <= offset+1;
    end
end

always @(posedge clk)
begin
    if(loadState & address== Nodeaddress)
        state <= initState;
    else
    begin
        case(state)
            SUS:begin
                if(infect)
                    state <= INF;
            end
            INF:begin
                if(recover)
                    state <= SUS;
            end
        endcase
    end
end

prbs recovRateGen(
    .clk(clk),
    .dataOut(recover),
    .loadSeed(loadSeed & (address== Nodeaddress)),
    .seedValue(seedValue)
);

prbs infectRateGen(
    .clk(clk),
    .dataOut(infectNeighbour),
    .loadSeed(loadSeed & (address== Nodeaddress)),
    .seedValue(seedValue)
);

endmodule
