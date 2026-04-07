import my_riscv_pkg::*; 
module EX(
    input logic clk,
    input logic rst,
    input id_ex_bus_t id_ex_bus,    

    input mem_ex_bus_t mem_ex_bus,  //数据旁路
    input wb_ex_bus_t wb_ex_bus,    //数据旁路

    output ex_mem_bus_t ex_mem_bus
);
logic [31:0] alu_result;

logic [31:0] A;
logic [31:0] B;
logic [31:0] C;
//数据旁路
always_comb begin
    A = (mem_ex_bus.rd == id_ex_bus.rs1) ? mem_ex_bus.w_data : 
        (wb_ex_bus.rd  == id_ex_bus.rs1) ? wb_ex_bus.w_data :
        id_ex_bus.src1_data;
    
    B = (mem_ex_bus.rd == id_ex_bus.rs2) ? mem_ex_bus.w_data : 
        (wb_ex_bus.rd  == id_ex_bus.rs2) ? wb_ex_bus.w_data :
        id_ex_bus.src2_data;
end

alu myAlu(
.alu_op(id_ex_bus.alu_op),
.A(A),
.B(B),
.C(alu_result)
);

assign ex_mem_bus.w_data  = alu_result;
assign ex_mem_bus.we      = id_ex_bus.we;
assign ex_mem_bus.rd      = id_ex_bus.rd;

assign ex_mem_bus.rs1     = id_ex_bus.rs1;
assign ex_mem_bus.rs2     = id_ex_bus.rs2;


endmodule