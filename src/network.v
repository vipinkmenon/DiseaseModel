module network(
input clk,
output [9:0] states,
input [9:0] initSate,
input loadState
);

wire [9:0] outedges[9:0];
reg  [9:0] inedges[9:0];

agent #(.Nodeaddress(0),.connectivity('b0000000100)) ag0 (
	.clk(clk),
	.neighbourEdges(inedges[0]),
	.outputEdges(outedges[0]),
	.address(),
	.initState(initSate[0]),
	.loadState(loadState),
	.currState(states[0])
);

agent #(.Nodeaddress(1),.connectivity('b0010001000)) ag1 (
	.clk(clk),
	.neighbourEdges(inedges[1]),
	.outputEdges(outedges[1]),
	.address(),
	.initState(initSate[1]),
	.loadState(loadState),
	.currState(states[1])
);

agent #(.Nodeaddress(2),.connectivity('b0100010010)) ag2 (
	.clk(clk),
	.neighbourEdges(inedges[2]),
	.outputEdges(outedges[2]),
	.address(),
	.initState(initSate[2]),
	.loadState(loadState),
	.currState(states[2])
);

agent #(.Nodeaddress(3),.connectivity('b0000000010)) ag3 (
	.clk(clk),
	.neighbourEdges(inedges[3]),
	.outputEdges(outedges[3]),
	.address(),
	.initState(initSate[3]),
	.loadState(loadState),
	.currState(states[3])
);

agent #(.Nodeaddress(4),.connectivity('b0000010110)) ag4 (
	.clk(clk),
	.neighbourEdges(inedges[4]),
	.outputEdges(outedges[4]),
	.address(),
	.initState(initSate[4]),
	.loadState(loadState),
	.currState(states[4])
);

agent #(.Nodeaddress(5),.connectivity('b0010101101)) ag5 (
	.clk(clk),
	.neighbourEdges(inedges[5]),
	.outputEdges(outedges[5]),
	.address(),
	.initState(initSate[5]),
	.loadState(loadState),
	.currState(states[5])
);

agent #(.Nodeaddress(6),.connectivity('b0100010100)) ag6 (
	.clk(clk),
	.neighbourEdges(inedges[6]),
	.outputEdges(outedges[6]),
	.address(),
	.initState(initSate[6]),
	.loadState(loadState),
	.currState(states[6])
);

agent #(.Nodeaddress(7),.connectivity('b1000111001)) ag7 (
	.clk(clk),
	.neighbourEdges(inedges[7]),
	.outputEdges(outedges[7]),
	.address(),
	.initState(initSate[7]),
	.loadState(loadState),
	.currState(states[7])
);

agent #(.Nodeaddress(8),.connectivity('b0011100000)) ag8 (
	.clk(clk),
	.neighbourEdges(inedges[8]),
	.outputEdges(outedges[8]),
	.address(),
	.initState(initSate[8]),
	.loadState(loadState),
	.currState(states[8])
);

agent #(.Nodeaddress(9),.connectivity('b0000010100)) ag9 (
	.clk(clk),
	.neighbourEdges(inedges[9]),
	.outputEdges(outedges[9]),
	.address(),
	.initState(initSate[9]),
	.loadState(loadState),
	.currState(states[9])
);

integer i,j;
always @(*)
begin
	for(i=0;i<10;i=i+1)
		for(j=0;j<10;j=j+1)
			inedges[i][j] = outedges[j][i];
end


endmodule
