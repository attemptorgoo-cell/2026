import my_riscv_pkg::*; 
module WB(
    input logic clk,
    input logic rst,

    input mem_wb_bus_t mem_wb_bus,
    output wb_id_bus_t wb_id_bus,
    
    output wb_ex_bus_t wb_ex_bus    //数据旁路
);

assign wb_id_bus.w_data = mem_wb_bus.w_data;
assign wb_id_bus.we     = mem_wb_bus.we;
assign wb_id_bus.rd     = mem_wb_bus.rd;



//数据旁路

assign wb_ex_bus.rd     = mem_wb_bus.rd;
assign wb_ex_bus.we     = mem_wb_bus.we;
assign wb_ex_bus.w_data = mem_wb_bus.w_data;

endmodule
