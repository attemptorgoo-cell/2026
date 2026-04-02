import my_riscv_pkg::*; 
module MEM(
    input logic clk,
    input  ex_mem_bus_t  ex_mem_bus,
    output mem_wb_bus_t  mem_wb_bus
);
    // 目前只是个“透传”模块
    assign mem_wb_bus.w_data     = ex_mem_bus.w_data;
    assign mem_wb_bus.rd         = ex_mem_bus.rd;
    assign mem_wb_bus.we         = ex_mem_bus.we;
endmodule