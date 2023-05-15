`ifndef _ADD_BASE_SEQUENCE_SV
`define _ADD_BASE_SEQUENCE_SV

class add_base_sequence extends uvm_sequence #(transaction_in);
    randc int data0 = -1;
    randc int data1 = -1; 
    randc int ndelay = -1;
    randc int ntrans = 10;

    `uvm_object_utils(add_base_sequence)
    function new(string name = "add_base_sequence");
        super.new(name);
    endfunction

    constraint data_cstr{
        soft data0 == -1;
        soft data1 == -1;
        soft ndelay == 1;
        soft ntrans inside {[5:50]};
    }

    virtual task body();
        `uvm_info("add_base_sequence",  $sformatf("send %0d transaction to sequencer", ntrans), UVM_LOW)
        repeat(ntrans) begin	    
            `uvm_do_with(req, { local::data0 >= 0 -> data0 == local::data0;
                                local::data1 >= 0 -> data1 == local::data1;
                                local::ndelay >= 0 -> ndelay == local::ndelay; } )
        end
    endtask

endclass

`endif
