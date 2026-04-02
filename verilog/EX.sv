import my_riscv_pkg::*; 
module EX(
    input logic clk,
    input id_ex_bus_t id_ex_bus,
    output ex_mem_bus_t ex_mem_bus
);

alu myAlu(
.alu_op(id_ex_bus.alu_op),
.A(id_ex_bus.src1_data),
.B(id_ex_bus.src2_data),
.C(alu_result)
);

assign ex_mem_bus.w_data  = alu_result;
assign ex_mem_bus.we      = id_ex_bus.we;

endmodule