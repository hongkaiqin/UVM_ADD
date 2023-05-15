`ifndef _SEQUENCER_SV_
`define _SEQUENCER_SV_

class my_sequencer extends uvm_sequencer #(transaction_in);
   
    function new(string name, uvm_component parent);
       super.new(name, parent);
    endfunction 
    
    `uvm_component_utils(my_sequencer)
endclass

`endif
