`ifndef _VIRTUAL_SEQUENCER_SV
`define _VIRTUAL_SEQUENCER_SV

class virtual_sequencer extends uvm_sequencer;
    my_sequencer p_dut_sqr;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	`uvm_component_utils(virtual_sequencer)
endclass

`endif
