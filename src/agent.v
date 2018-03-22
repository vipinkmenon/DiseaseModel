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


module agent #(parameter Nodeaddress =0) (
input wire clk,
input wire [3:0] neighbourEdges,
output wire [3:0] outputEdges,
input wire [31:0] seedValue,
input wire loadSeed,
input wire [1:0] address,
input wire initState,
input wire loadState,
output wire currState
);


reg state;
wire infect;
wire recover;

assign infect = |neighbourEdges;

localparam SUS = 0,
           INF = 1;

assign currState = state;

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

endmodule
