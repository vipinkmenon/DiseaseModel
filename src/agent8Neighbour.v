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
input  wire        clk,
input  wire        inLeft,
input  wire        inRight,
input  wire        inTop,
input  wire        inBottom,
input  wire        inBottomLeft,
input  wire        inBottomRight,
input  wire        inTopLeft,
input  wire        inTopRight,
output wire        outputLeft,
output wire        outputRight,
output wire        outputTop,
output wire        outputBottom,
output wire        outputBottomLeft,
output wire        outputBottomRight,
output wire        outputTopLeft,
output wire        outputTopRight,
input  wire        initState,
input  wire        loadState,
output wire        currState
);

reg state=0;
wire [7:0] infectGenerator;
wire infect;
wire recover;

assign infect = inTop|inBottom|inRight|inLeft|inBottomLeft|inBottomRight|inTopLeft|inTopRight;
assign outputLeft = (state == INF) ? infectGenerator[0] : 1'b0;
assign outputRight = (state == INF) ? infectGenerator[1] : 1'b0;
assign outputTop = (state == INF) ? infectGenerator[2] : 1'b0;
assign outputBottom = (state == INF) ? infectGenerator[3] : 1'b0;
assign outputBottomLeft = (state == INF) ? infectGenerator[4] : 1'b0;
assign outputBottomRight = (state == INF) ? infectGenerator[5] : 1'b0;
assign outputTopLeft = (state == INF) ? infectGenerator[6] : 1'b0;
assign outputTopRight = (state == INF) ? infectGenerator[7] : 1'b0;

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
    for(i=0;i<8;i=i+1)
        begin:instloop
            prbs #(.seed(Nodeaddress+i),.threshold(32'hCCCCCCCC),.type(1))
            infectRateGen(
            .clk(clk),
            .dataOut(infectGenerator[i])
        );
    end
endgenerate

endmodule
