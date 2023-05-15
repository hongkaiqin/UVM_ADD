`timescale 1ns/1ps

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "interface.sv"

`include "test_top.sv"

module tb_top;

    logic clk;
    logic rst_n;

    interface_in    input_if(clk, rst_n);
    interface_out   output_if(clk, rst_n);

    adder dut_top(
        .clk            ( input_if.clk      ),
        .rst_n          ( input_if.rst_n    ),
        .in_valid       ( input_if.valid    ),
        .data_in0       ( input_if.data0    ),
        .data_in1       ( input_if.data1    ),
        .out_valid      ( output_if.valid   ),
        .data_out       ( output_if.data    )
    );

    initial begin
        clk = 0;
        forever begin
            #100 clk <= ~clk;        // 5MHz
        end
    end

    initial begin
        rst_n <= 1'b0;
        #1000;
        rst_n <= 1'b1;
    end

    initial begin
        // set the format for time display
        $timeformat(-9, 2, "ns", 10);      
        // do interface configuration from tb_top (HW) to verification env (SW)
        uvm_config_db # (virtual interface_in )::set(null, "uvm_test_top.env.in_agt.drv",  "vif", input_if);
        uvm_config_db # (virtual interface_in )::set(null, "uvm_test_top.env.in_agt.mon",  "vif", input_if);
        uvm_config_db # (virtual interface_out)::set(null, "uvm_test_top.env.out_agt.mon", "vif", output_if);
        run_test();
    end

    initial begin 
        string testname;
        if($value$plusargs("TESTNAME=%s", testname)) begin
            $fsdbDumpfile({testname, "_sim_dir/", testname, ".fsdb"});
        end else begin
            $fsdbDumpfile("tb.fsdb");
        end
        $fsdbDumpvars(0, tb_top);
    end

endmodule
