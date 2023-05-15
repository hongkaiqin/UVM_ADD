`ifndef _INTERFACE_SV
`define _INTERFACE_SV

interface interface_in(input clk, input rst_n);
    logic [8:0] data0;
    logic [8:0] data1;
    logic       valid;
        
    clocking drv_ck @(posedge clk);
        default input #1ns output #1ns;
        output data0, data1, valid;
    endclocking
        
    clocking mon_ck @(posedge clk);
        default input #1ns output #1ns;
        input data0, data1, valid;
    endclocking

endinterface

interface interface_out(input clk, input rst_n);
    logic [9:0] data;
    logic       valid;
    
    clocking drv_ck @(posedge clk);
        default input #1ns output #1ns;
        input data, valid;
    endclocking
    
    clocking mon_ck @(posedge clk);
        default input #1ns output #1ns;
        input data, valid;
    endclocking
endinterface  
 
`endif


