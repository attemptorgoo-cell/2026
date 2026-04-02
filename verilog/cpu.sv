import my_riscv_pkg::*; 
module cpu(
    input logic clk,
    input logic rst
);
if_id_bus_t if_id_bus,if_id_bus_reg;
id_ex_bus_t id_ex_bus,id_ex_bus_reg;
ex_mem_bus_t ex_mem_bus,ex_mem_bus_reg;
mem_wb_bus_t mem_wb_bus,mem_wb_bus_reg; 
wb_id_bus_t wb_id_bus;
//reg表示打一拍的数据,wb写回不需要打拍

IF myIF(
.clk(clk),
.if_id_bus(if_id_bus)
);

ID myID(
.clk(clk),
.if_id_bus(if_id_bus_reg),
.wb_id_bus(wb_id_bus),
.id_ex_bus(id_ex_bus)
);


EX myEX(
.clk(clk),
.id_ex_bus(id_ex_bus_reg),
.ex_mem_bus(ex_mem_bus)
);
MEM myMEM(
.clk(clk),
.ex_mem_bus(ex_mem_bus_reg),
.mem_wb_bus(mem_wb_bus)
);

WB myWB(
.clk(clk),
.mem_wb_bus(mem_wb_bus_reg),
.wb_id_bus(wb_id_bus)
//减少长路径
);

always_ff @(posedge clk or negedge rst)begin
    if(~rst)begin
        if_id_bus_reg <= '0;
        id_ex_bus_reg <= '0;
        ex_mem_bus_reg <= '0;
        mem_wb_bus_reg <= '0;
    end
    else begin
        if_id_bus_reg <= if_id_bus;
        id_ex_bus_reg <= id_ex_bus;
        ex_mem_bus_reg <= ex_mem_bus;
        mem_wb_bus_reg <= mem_wb_bus;

    end
end
endmodule