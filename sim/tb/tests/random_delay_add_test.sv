`ifndef _RANDOM_DELAY_ADD_TETS_SV
`define _RANDOM_DELAY_ADD_TETS_SV

// -- virtual sequence for data
class random_delay_add_sequence extends uvm_sequence;
    `uvm_object_utils(random_delay_add_sequence)
    `uvm_declare_p_sequencer(virtual_sequencer)

    function new(string name = "random_delay_add_sequence");
        super.new(name);
    endfunction

    virtual task body();
        add_base_sequence dut_seq;

        if(starting_phase != null)
            starting_phase.raise_objection(this);
        
        repeat(20) begin
            `uvm_do_on_with(dut_seq, p_sequencer.p_dut_sqr, {ntrans == 1; ndelay == -1; })
        end

        #5000;
        
        if(starting_phase != null)
            starting_phase.drop_objection(this);
    endtask
    
    
endclass


class random_delay_add_test extends base_test;
    `uvm_component_utils(random_delay_add_test)
    function new(string name = "random_delay_add_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        /* 1. use default_sequence */
        uvm_config_db #(uvm_object_wrapper)::set(this, "v_sqr.main_phase", "default_sequence", random_delay_add_sequence::type_id::get());
    
    endfunction

endclass

`endif

