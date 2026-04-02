import my_riscv_pkg::*; 
module WB(
    input logic clk,

    input mem_wb_bus_t mem_wb_bus,
    output wb_id_bus_t wb_id_bus
);

assign wb_id_bus.w_data = mem_wb_bus.w_data;
assign wb_id_bus.we     = mem_wb_bus.we;
endmodule
