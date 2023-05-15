`ifndef _ORDER_DATA_ADD_TETS_SV
`define _ORDER_DATA_ADD_TETS_SV

`include "add_base_sequence.sv"

// -- virtual sequence for data
class order_data_add_sequence extends uvm_sequence;
    `uvm_object_utils(order_data_add_sequence)
    `uvm_declare_p_sequencer(virtual_sequencer)

    function new(string name = "order_data_add_sequence");
        super.new(name);
    endfunction

    virtual task body();
        add_base_sequence dut_seq;

        if(starting_phase != null)
            starting_phase.raise_objection(this);
        
        for(int add0=10; add0<30; add0++) begin
            for(int add1=0; add1<50; add1++) begin
                `uvm_do_on_with(dut_seq, p_sequencer.p_dut_sqr, {data0 == add0; data1 == add1; ntrans == 1; })
            end 
            #500;
        end 

        #1000;
        
        if(starting_phase != null)
            starting_phase.drop_objection(this);
    endtask
    
    
endclass


class order_data_add_test extends base_test;
    `uvm_component_utils(order_data_add_test)
    function new(string name = "order_data_add_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        /* 1. use default_sequence */
        uvm_config_db #(uvm_object_wrapper)::set(this, "v_sqr.main_phase", "default_sequence", order_data_add_sequence::type_id::get());
    
    endfunction

endclass

`endif

