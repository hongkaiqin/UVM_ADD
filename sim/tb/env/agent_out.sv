`ifndef __AGENT_OUT_SV
`define __AGENT_OUT_SV

`include "monitor_out.sv"

class agent_out extends uvm_agent ;
    monitor_out      mon;
    
    uvm_analysis_port #(transaction_out)  ap;
    
    `uvm_component_utils(agent_out)
    function new(string name = "agent_out", uvm_component parent);
       super.new(name, parent);
    endfunction 
    
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
 
 endclass 
 
 
 function void agent_out::build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon = monitor_out::type_id::create("mon", this);
 endfunction 
 
 function void agent_out::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    ap = mon.ap;
 endfunction

 `endif
