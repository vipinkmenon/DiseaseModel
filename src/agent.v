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


<<<<<<< HEAD
module agent #(parameter Nodeaddress =0,parameter connectivity = 'h23) (
input  wire        clk,
input  wire  [9:0] neighbourEdges,
output wire  [9:0] outputEdges,
input  wire  [3:0] address,
input  wire        initState,
input  wire        loadState,
output wire        currState
);

reg state=0;
wire [9:0] connectivityMatrix;
wire [9:0] infectGenerator;
=======
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
>>>>>>> 11c296a2e5ec18766fe6296c156151573a148dbf
wire infect;
wire recover;
wire infectNeighbour;
integer offset=0;

assign infect = |neighbourEdges;
<<<<<<< HEAD
assign connectivityMatrix = connectivity;
assign outputEdges = (state == INF) ? connectivityMatrix & infectGenerator : 10'd0;
=======
assign outputEdges = connectivityReg & {numAgents{infectNeighbour}};
>>>>>>> 11c296a2e5ec18766fe6296c156151573a148dbf

localparam SUS = 0,
           INF = 1;

assign currState = state;

always @(posedge clk)
begin
<<<<<<< HEAD
    if(loadState)// & address== Nodeaddress
=======
    if(loadConnectivity)
    begin
        connectivityReg[offset*32+:32] <= valConnectivity;
        offset <= offset+1;
    end
end

always @(posedge clk)
begin
    if(loadState & address== Nodeaddress)
>>>>>>> 11c296a2e5ec18766fe6296c156151573a148dbf
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

prbs #(.seed(Nodeaddress),.threshold(32'h4CCCCCCC),.type(1))
recovRateGen(
    .clk(clk),
    .dataOut(recover)
);

<<<<<<< HEAD
generate
genvar i;
    for(i=0;i<10;i=i+1)
        begin:instloop
            prbs #(.seed(i),.threshold(32'hCCCCCCCC),.type(1))
            infectRateGen(
            .clk(clk),
            .dataOut(infectGenerator[i])
        );
    end
endgenerate
=======
prbs infectRateGen(
    .clk(clk),
    .dataOut(infectNeighbour),
    .loadSeed(loadSeed & (address== Nodeaddress)),
    .seedValue(seedValue)
);
>>>>>>> 11c296a2e5ec18766fe6296c156151573a148dbf

endmodule
