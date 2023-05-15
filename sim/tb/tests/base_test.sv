`ifndef BASE_TEST_SV
`define BASE_TEST_SV

`include "env.sv"
`include "virtual_sqr.sv"

class base_test extends uvm_test;
    my_env env;
    virtual_sequencer v_sqr;

    `uvm_component_utils(base_test)
    function new(string name = "base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
    extern virtual function void report_phase(uvm_phase phase);

endclass

function void base_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = my_env::type_id::create("env", this);
    v_sqr = virtual_sequencer::type_id::create("v_sqr", this);

endfunction

function void base_test::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    v_sqr.p_dut_sqr = env.in_agt.sqr;
    if(get_report_verbosity_level() >= UVM_HIGH ) begin 
        uvm_top.print_topology();
    end
endfunction

function void base_test::report_phase(uvm_phase phase);
    uvm_report_server server;
    integer fid;
    int err_num;
    string testname;
    $value$plusargs("TESTNAME=%s", testname);
    super.report_phase(phase);

    server = get_report_server();
    err_num =  server.get_severity_count(UVM_WARNING) + server.get_severity_count(UVM_ERROR) + server.get_severity_count(UVM_FATAL);

    $system("date +[%F/%T] >> result_sim.log");
    fid = $fopen("result_sim.log","a");
    $display("");

    if( err_num != 0 ) begin
        $display("==================================================");
        $display("%s TestCase Failed !!!", testname);
        $display("It has %0d error(s).", err_num);
        $display("!!!!!!!!!!!!!!!!!!");
        $fwrite( fid, $sformatf("TestCase Failed: %s\n\n", testname) );
    end else begin
        $display("==================================================");
        $display("TestCase Passed: %s", testname);
        $display("==================================================");
        $fwrite( fid, $sformatf("TestCase Passed: %s\n\n", testname) );
    end

endfunction

`endif 


 
