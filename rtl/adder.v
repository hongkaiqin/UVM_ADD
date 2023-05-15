
module adder(
        input               clk,
        input               rst_n,
        input       [8:0]   data_in0,
        input       [8:0]   data_in1,
        input               in_valid,
        output reg  [9:0]   data_out,
        output reg          out_valid
    );

    always @(posedge clk) begin
        if(!rst_n) begin
            data_out    <= 9'h0;
            out_valid   <= 1'b0;
        end
        else if(in_valid) begin
            data_out    <= data_in0 + data_in1;
            out_valid   <= 1'b1;
        end
        else begin
            data_out    <= 9'h0;
            out_valid   <= 1'b0;
        end
    end

endmodule
