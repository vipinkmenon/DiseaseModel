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
wire infect;
wire recover;

assign infect = |neighbourEdges;
assign connectivityMatrix = connectivity;
assign outputEdges = (state == INF) ? connectivityMatrix & infectGenerator : 10'd0;

localparam SUS = 0,
           INF = 1;

assign currState = state;

always @(posedge clk)
begin
    if(loadState)// & address== Nodeaddress
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

endmodule
