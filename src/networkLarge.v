`define X 2
`define Y 2

module networkLarge(
input clk,
output [`X*`Y-1:0] states,
input [`X*`Y-1:0] initSate,
input loadState
);

wire [`X*`Y-1:0] leftConnect;
wire [`X*`Y-1:0] rightConnect;
wire [`X*`Y-1:0] topConnect;
wire [`X*`Y-1:0] bottomConnect;
wire [`X*`Y-1:0] topLeftConnect;
wire [`X*`Y-1:0] bottomLeftConnect;
wire [`X*`Y-1:0] topRightConnect;
wire [`X*`Y-1:0] bottomRightConnect;


generate
genvar i,j;
    for(i=0;i<`Y;i=i+1)
    begin:rowLoop
        for(j=0;j<`X;j=j+1)
        begin:columnLoop
            if(i==0 && j==0)
            begin:topleftcorner
                agent #(.Nodeaddress(i*`X+j))ag (
                .clk(clk),
                .inLeft(1'b0),
                .inRight(leftConnect[i*`X+j+1]),
                .inTop(1'b0),
                .inBottom(topConnect[(i+1)*`X+j]),
                .inBottomLeft(1'b0),
                .inBottomRight(topLeftConnect[(i+1)*`X+j+1]),
                .inTopLeft(1'b0),
                .inTopRight(1'b0),
                .outputLeft(),
                .outputRight(rightConnect[i*`X+j]),
                .outputTop(),
                .outputBottom(bottomConnect[i*`X+j]),
                .outputBottomLeft(),
                .outputBottomRight(bottomRightConnect[i*`X+j]),
                .outputTopLeft(),
                .outputTopRight(),
                .initState(initSate[i*`X+j]),
                .loadState(loadState),
                .currState(states[i*`X+j])
                );
            end
            
            else if(i==0 && j==`X-1)
            begin:toprightcorner
                agent #(.Nodeaddress(i*`X+j))ag (
                .clk(clk),
                .inLeft(rightConnect[i*X+j-1]),
                .inRight(1'b0),
                .inTop(1'b0),
                .inBottom(topConnect[(i+1)*`X+j]),
                .inBottomLeft(topRightConnect[(i+1)*`X+j-1]),
                .inBottomRight(1'b0),
                .inTopLeft(1'b0),
                .inTopRight(1'b0),
                .outputLeft(leftConnect[i*`X+j]),
                .outputRight(),
                .outputTop(),
                .outputBottom(bottomConnect[i*`X+j]),
                .outputBottomLeft(bottomLeftConnect[i*`X+j]),
                .outputBottomRight(),
                .outputTopLeft(),
                .outputTopRight(),
                .initState(initSate[i*`X+j]),
                .loadState(loadState),
                .currState(states[i*`X+j])
                );
            end
            
            else if(i == `Y-1 && j == 0)
            begin:bottomLeft
                agent #(.Nodeaddress(i*`X+j))ag (
                .clk(clk),
                .inLeft(),
                .inRight(leftConnect[i*`X+j+1]),
                .inTop(bottomConnect[(i-1)*`X+j]),
                .inBottom(),
                .inBottomLeft(1'b0),
                .inBottomRight(1'b0),
                .inTopLeft(),
                .inTopRight(bottomLeftConnect[(i-1)*`X+j+1]),
                .outputLeft(),
                .outputRight(rightConnect[i*`X+j]),
                .outputTop(topConnect[i*`X+j]),
                .outputBottom(),
                .outputBottomLeft(),
                .outputBottomRight(),
                .outputTopLeft(),
                .outputTopRight(topRightConnect[i*`X+j]),
                .initState(initSate[i*`X+j]),
                .loadState(loadState),
                .currState(states[i*`X+j])
                );
            end
            else if(i == `Y-1 && j == `X-1)
            begin:bottomRight
                agent #(.Nodeaddress(i*`X+j))ag (
                .clk(clk),
                .inLeft(rightConnect[i*`X+j-1]),
                .inRight(),
                .inTop(bottomConnect[(i-1)*`X+j]),
                .inBottom(),
                .inBottomLeft(1'b0),
                .inBottomRight(1'b0),
                .inTopLeft(bottomRightConnect[(i-1)*`X+j-1]),
                .inTopRight(),
                .outputLeft(leftConnect[i*`X+j]),
                .outputRight(),
                .outputTop(topConnect[i*`X+j]),
                .outputBottom(),
                .outputBottomLeft(),
                .outputBottomRight(),
                .outputTopLeft(topLeftConnect[i*`X+j]),
                .outputTopRight(),
                .initState(initSate[i*`X+j]),
                .loadState(loadState),
                .currState(states[i*`X+j])
                );
            end            
            
            else if(i==0)
            begin:firstRow
                agent #(.Nodeaddress(i*`X+j))ag (
                .clk(clk),
                .inLeft(rightConnect[i*`X+j-1]),
                .inRight(leftConnect[i*`X+j+1]),
                .inTop(1'b0),
                .inBottom(topConnect[(i+1)*`X+j]),
                .inBottomLeft(topRightConnect[(i+1)*`X+j-1]),
                .inBottomRight(topLeftConnect[(i+1)*`X+j+1]),
                .inTopLeft(1'b0),
                .inTopRight(1'b0),
                .outputLeft(leftConnect[i*`X+j]),
                .outputRight(rightConnect[i*`X+j]),
                .outputTop(),
                .outputBottom(bottomConnect[i*`X+j]),
                .outputBottomLeft(bottomLeftConnect[i*`X+j]),
                .outputBottomRight(bottomRightConnect[i*`X+j]),
                .outputTopLeft(),
                .outputTopRight(),
                .initState(initSate[i*`X+j]),
                .loadState(loadState),
                .currState(states[i*`X+j])
                );
            end
            else if(j == 0)
            begin:firstcolumn
                agent #(.Nodeaddress(i*`X+j))ag (
                .clk(clk),
                .inLeft(1'b0),
                .inRight(leftConnect[i*`X+j+1]),
                .inTop(bottomConnect[(i-1)*`X+j]),
                .inBottom(topConnect[(i+1)*`X+j]),
                .inBottomLeft(1'b0),
                .inBottomRight(topLeftConnect[(i+1)*`X+j+1]),
                .inTopLeft(1'b0),
                .inTopRight(bottomLeftConnect[(i-1)*`X+j+1]),
                .outputLeft(),
                .outputRight(rightConnect[i*`X+j]),
                .outputTop(topConnect[i*`X+j]),
                .outputBottom(bottomConnect[i*`X+j]),
                .outputBottomLeft(),
                .outputBottomRight(bottomRightConnect[i*`X+j]),
                .outputTopLeft(),
                .outputTopRight(topRightConnect[i*`X+j]),
                .initState(initSate[i*`X+j]),
                .loadState(loadState),
                .currState(states[i*`X+j])
                );
            end
            
            else if(i == `Y-1)
            begin:lastRow
                agent #(.Nodeaddress(i*`X+j))ag (
                .clk(clk),
                .inLeft(rightConnect[i*`X+j-1]),
                .inRight(leftConnect[i*`X+j+1]),
                .inTop(bottomConnect[(i-1)*`X+j]),
                .inBottom(1'b0),
                .inBottomLeft(1'b0),
                .inBottomRight(1'b0),
                .inTopLeft(bottomRightConnect[(i-1)*`X+j-1]),
                .inTopRight(bottomLeftConnect[(i-1)*`X+j+1]),
                .outputLeft(leftConnect[i*`X+j]),
                .outputRight(rightConnect[i*`X+j]),
                .outputTop(topConnect[i*`X+j]),
                .outputBottom(),
                .outputBottomLeft(),
                .outputBottomRight(),
                .outputTopLeft(topLeftConnect[i*`X+j]),
                .outputTopRight(topRightConnect[i*`X+j]),
                .initState(initSate[i*`X+j]),
                .loadState(loadState),
                .currState(states[i*`X+j])
                );
            end
            
            else if(j == `X-1)
            begin:lastColumn
                agent #(.Nodeaddress(i*`X+j))ag (
                .clk(clk),
                .inLeft(rightConnect[i*`X+j-1]),
                .inRight(1'b0),
                .inTop(bottomConnect[(i-1)*`X+j]),
                .inBottom(topConnect[(i+1)*`X+j]),
                .inBottomLeft(topRightConnect[(i+1)*`X+j-1]),
                .inBottomRight(1'b0),
                .inTopLeft(bottomRightConnect[(i-1)*`X+j-1]),
                .inTopRight(1'b0),
                .outputLeft(leftConnect[i*`X+j]),
                .outputRight(),
                .outputTop(topConnect[i*`X+j]),
                .outputBottom(bottomConnect[i*`X+j]),
                .outputBottomLeft(bottomLeftConnect[i*`X+j]),
                .outputBottomRight(),
                .outputTopLeft(topLeftConnect[i*`X+j]),
                .outputTopRight(),
                .initState(initSate[i*`X+j]),
                .loadState(loadState),
                .currState(states[i*`X+j])
                );
            end       
            else
            begin:everythingBetween
                agent #(.Nodeaddress(i*`X+j))ag (
                .clk(clk),
                .inLeft(rightConnect[i*`X+j-1]),
                .inRight(leftConnect[i*`X+j+1]),
                .inTop(bottomConnect[(i-1)*`X+j]),
                .inBottom(topConnect[(i+1)*`X+j]),
                .inBottomLeft(topRightConnect[(i+1)*`X+j-1]),
                .inBottomRight(topLeftConnect[(i+1)*`X+j+1]),
                .inTopLeft(bottomRightConnect[(i-1)*`X+j-1]),
                .inTopRight(bottomLeftConnect[(i-1)*`X+j+1]),
                .outputLeft(leftConnect[i*`X+j]),
                .outputRight(rightConnect[i*`X+j]),
                .outputTop(topConnect[i*`X+j]),
                .outputBottom(bottomConnect[i*`X+j]),
                .outputBottomLeft(bottomLeftConnect[i*`X+j]),
                .outputBottomRight(bottomRightConnect[i*`X+j]),
                .outputTopLeft(topLeftConnect[i*`X+j]),
                .outputTopRight(topRightConnect[i*`X+j]),
                .initState(initSate[i*`X+j]),
                .loadState(loadState),
                .currState(states[i*`X+j])
                );            
            end
        end
    end
endgenerate

endmodule