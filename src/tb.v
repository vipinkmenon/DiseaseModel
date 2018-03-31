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
reg loadState;
reg [99:0] initStates=0;
reg [31:0] nodeStates[9:0];
wire [99:0] nodeState;
integer i;
integer numTicks = 1;
integer logFile;
reg start = 0;


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
    logFile = $fopen("log.txt","w");
    //$fwrite(logFile,"%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n","tickNum","node1","node2","node3","node4","node5","node6","node7","node8","node9","node10");
    for(i=0;i<10;i=i+1)
        nodeStates[i] = 0;
    initStates = 'b1;
    loadState = 0;
    #5000;
    @(posedge clk);
    loadState <= 1;
    @(posedge clk);
    loadState <= 0;
    start <= 1;
    wait(numTicks == 500);
    $fclose(logFile);
    $stop;
end

always@(posedge clk)
begin
    if(start)
    begin
        numTicks <= numTicks + 1;
        /*for(i=0;i<10;i=i+1)
        begin
            if(nodeState[i] == 1)
            begin
                nodeStates[i] = nodeStates[i]+1;
            end
        end*/
        //$fwrite(logFile,"%0d\t%0.2f\t%0.2f\t%0.2f\t%0.2f\t%0.2f\t%0.2f\t%0.2f\t%0.2f\t%0.2f\t%0.2f\n",numTicks,nodeStates[0]*1.0/numTicks,nodeStates[1]*1.0/numTicks,nodeStates[2]*1.0/numTicks,nodeStates[3]*1.0/numTicks,nodeStates[4]*1.0/numTicks,nodeStates[5]*1.0/numTicks,nodeStates[6]*1.0/numTicks,nodeStates[7]*1.0/numTicks,nodeStates[8]*1.0/numTicks,nodeStates[9]*1.0/numTicks);
        //$fwrite(logFile,"%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%0d\n",numTicks,nodeState[0],nodeState[1],nodeState[2],nodeState[3],nodeState[4],nodeState[5],nodeState[6],nodeState[7],nodeState[8],nodeState[9]);
        $fwrite(logFile,"%0d,\t",numTicks);
        for(i=0;i<100;i=i+1)
        begin
            $fwrite(logFile,"%0d,",nodeState[i]);
        end     
        $fwrite(logFile,"\n");
    end
end

/*network dut(
    .clk(clk),
    .states(nodeState),
    .initSate(initStates),
    .loadState(loadState)
);*/


networkLarge dut(
    .clk(clk),
    .states(nodeState),
    .initSate(initStates),
    .loadState(loadState)
);


endmodule