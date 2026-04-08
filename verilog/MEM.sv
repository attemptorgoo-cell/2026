import my_riscv_pkg::*; 
module MEM(
    input logic clk,
    input logic rst,
    input  ex_mem_bus_t  ex_mem_bus,
    output mem_wb_bus_t  mem_wb_bus,
    
    output mem_ex_bus_t  mem_ex_bus    //数据旁路

    

    
);

memory_bus_t mem_ram_bus;
memory_bus_t ram_mem_bus;


ram myRam(
.rst(rst),
.mem_ram_bus(mem_ram_bus),
.ram_mem_bus(ram_mem_bus)

);

    // 目前只是个“透传”模块

    // if(ex_mem_bus.memory_re)begin
    //     case(ex_mem_bus.func3)
    //     endcase
    // end
    assign mem_wb_bus.w_data     = ex_mem_bus.w_data;
    assign mem_wb_bus.rd         = ex_mem_bus.rd;
    assign mem_wb_bus.we         = ex_mem_bus.we;

    assign mem_wb_bus.rs1        = ex_mem_bus.rs1;
    assign mem_wb_bus.rs2        = ex_mem_bus.rs2;



    //数据旁路
    assign mem_ex_bus.rd         = ex_mem_bus.rd;
    assign mem_ex_bus.w_data     = ex_mem_bus.w_data;
    assign mem_ex_bus.we         = ex_mem_bus.we;

    assign mem_ram_bus.memory_re = ex_mem_bus.memory_re;
    assign mem_ram_bus.memory_we = ex_mem_bus.memory_we;

    


endmodule