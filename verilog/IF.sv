import my_riscv_pkg::*; 
module IF(
    input logic clk,
    input logic rst,
    output if_id_bus_t if_id_bus
);
logic [31:0] pc;
logic [31:0] rom [1023:0];

initial begin
    pc = 32'h0;
        // 你可以写一个 hex 文件，里面放你的机器码
    $readmemh("D:/02_uncompleted/CPU_2026/verilog/inst_data.hex", rom);
    $display("DEBUG: ROM[0] = %h, ROM[1] = %h", rom[0], rom[1]);
    //只用正斜杠或者双反斜杠，绝对地址
end

always_ff @(posedge clk or negedge rst)begin
    if(~rst)begin
        pc <= 32'b0;
    end
    else begin
        pc <= pc + 32'd4; 
    end
end

assign if_id_bus.instr = rom[pc[11:2]];

endmodule