`ifndef __TRANSACTION_OUT_SV
`define __TRANSACTION_OUT_SV

class transaction_out extends uvm_sequence_item;
    rand bit[9:0] data;

    `uvm_object_utils_begin(transaction_out)
        `uvm_field_int(data, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "transaction_out");
        super.new(name);
    endfunction

endclass

`endif
