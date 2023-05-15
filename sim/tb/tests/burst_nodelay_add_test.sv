`ifndef _BURST_NODELAY_ADD_TETS_SV
`define _BURST_NODELAY_ADD_TETS_SV

// -- virtual sequence for data
class burst_nodelay_add_sequence extends uvm_sequence;
    `uvm_object_utils(burst_nodelay_add_sequence)
    `uvm_declare_p_sequencer(virtual_sequencer)

    function new(string name = "burst_nodelay_add_sequence");
        super.new(name);
    endfunction

    virtual task body();
        add_base_sequence dut_seq;

        if(starting_phase != null)
            starting_phase.raise_objection(this);
        
        `uvm_do_on_with(dut_seq, p_sequencer.p_dut_sqr, {ntrans == 10; ndelay == 0; })

        #800;

        `uvm_do_on_with(dut_seq, p_sequencer.p_dut_sqr, {ntrans == 10; ndelay == 0; })

        #5000;
        
        if(starting_phase != null)
            starting_phase.drop_objection(this);
    endtask
    
    
endclass


class burst_nodelay_add_test extends base_test;
    `uvm_component_utils(burst_nodelay_add_test)
    function new(string name = "burst_nodelay_add_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        /* 1. use default_sequence */
        uvm_config_db #(uvm_object_wrapper)::set(this, "v_sqr.main_phase", "default_sequence", burst_nodelay_add_sequence::type_id::get());
    
    endfunction

endclass

`endif

