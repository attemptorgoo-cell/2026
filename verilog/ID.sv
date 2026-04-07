import my_riscv_pkg::*; 
module ID(
    input logic clk,
    input logic rst,

    input if_id_bus_t if_id_bus,
    input wb_id_bus_t wb_id_bus,                //接受写回阶段传回来的数据

    output id_ex_bus_t id_ex_bus
);

decode_out_t decode_out;

decoder myDecoder(
.clk(clk),
.instr(if_id_bus.instr),
.decode_out(decode_out)
);

assign id_ex_bus.alu_op = decode_out.alu_op;
assign id_ex_bus.we     = decode_out.we;
assign id_ex_bus.rd     = decode_out.rd;

assign id_ex_bus.rs1    = decode_out.rs1;
assign id_ex_bus.rs2    = decode_out.rs2;


regFiles myRf(
.clk(clk),
.rst(rst),
.rs1(decode_out.rs1),
.rs2(decode_out.rs2),
.rd(wb_id_bus.rd),
.rdata1(id_ex_bus.src1_data),
.rdata2(id_ex_bus.src2_data),
.we(wb_id_bus.we),
//在这里 we被接上了
.wdata(wb_id_bus.w_data)

);

endmodule