`ifndef __MONITOR_IN_SV_
`define __MONITOR_IN_SV_

class monitor_in extends uvm_monitor;

    virtual interface_in vif;
 
    uvm_analysis_port #(transaction_in)  ap;
    
    `uvm_component_utils(monitor_in)
    function new(string name = "monitor_in", uvm_component parent = null);
       super.new(name, parent);
    endfunction
 
    virtual function void build_phase(uvm_phase phase);
       super.build_phase(phase);
       if(!uvm_config_db#(virtual interface_in)::get(this, "", "vif", vif))
          `uvm_fatal("monitor_in", "virtual interface must be set for vif!!!")
       ap = new("ap", this);
    endfunction
 
    extern task main_phase(uvm_phase phase);
    extern task collect_one_pkt(transaction_in tr);
endclass
 
task monitor_in::main_phase(uvm_phase phase);
    transaction_in tr;
    while(1) begin
       tr = new("tr");
       collect_one_pkt(tr);
       ap.write(tr);
    end
endtask
 
task monitor_in::collect_one_pkt(transaction_in tr);
    
    @(posedge vif.clk iff(vif.valid));
    `uvm_info("monitor_in", "begin to collect one pkt", UVM_HIGH);

    tr.data0 = vif.data0;
    tr.data1 = vif.data1;
    `uvm_info("monitor_in", $sformatf("collect one pkt: \n%s", tr.sprint()), UVM_LOW);

endtask

`endif
