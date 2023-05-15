`ifndef __AGENT_IN_SV
`define __AGENT_IN_SV

`include "driver_in.sv"
`include "monitor_in.sv"
`include "sequencer.sv"

class agent_in extends uvm_agent ;
    my_sequencer    sqr;
    driver_in       drv;
    monitor_in      mon;
    
    uvm_analysis_port #(transaction_in)  ap;
    
    function new(string name, uvm_component parent);
       super.new(name, parent);
    endfunction 
    
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
 
    `uvm_component_utils(agent_in)
 endclass 
 
 
 function void agent_in::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (is_active == UVM_ACTIVE) begin
       sqr = my_sequencer::type_id::create("sqr", this);
       drv = driver_in::type_id::create("drv", this);
    end
    mon = monitor_in::type_id::create("mon", this);
 endfunction 
 
 function void agent_in::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if (is_active == UVM_ACTIVE) begin
       drv.seq_item_port.connect(sqr.seq_item_export);
    end
    ap = mon.ap;
 endfunction

 `endif
