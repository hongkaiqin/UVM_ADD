`ifndef __MONITOR_OUT_SV_
`define __MONITOR_OUT_SV_

`include "transaction_out.sv"

class monitor_out extends uvm_monitor;

    virtual interface_out vif;
 
    uvm_analysis_port #(transaction_out)  ap;
    
    `uvm_component_utils(monitor_out)
    function new(string name = "monitor_out", uvm_component parent = null);
       super.new(name, parent);
    endfunction
 
    virtual function void build_phase(uvm_phase phase);
       super.build_phase(phase);
       if(!uvm_config_db#(virtual interface_out)::get(this, "", "vif", vif))
          `uvm_fatal("monitor_out", "virtual interface must be set for vif!!!")
       ap = new("ap", this);
    endfunction
 
    extern task main_phase(uvm_phase phase);
    extern task collect_one_pkt(transaction_out tr);
endclass
 
task monitor_out::main_phase(uvm_phase phase);
    transaction_out tr;
    while(1) begin
       tr = new("tr");
       collect_one_pkt(tr);
       ap.write(tr);
    end
endtask
 
task monitor_out::collect_one_pkt(transaction_out tr);
    
    @(posedge vif.clk iff(vif.valid));
    `uvm_info("monitor_out", "begin to collect one pkt", UVM_HIGH);

    tr.data = vif.data;
    `uvm_info("monitor_out", $sformatf("collect one pkt: \n%s", tr.sprint()), UVM_LOW);

endtask

`endif
