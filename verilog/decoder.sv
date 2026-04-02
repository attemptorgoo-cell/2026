import my_riscv_pkg::*; 
//导入package

module decoder(
    input logic clk,
    input logic [31:0] instr,
    output decode_out_t decode_out
);

logic [2:0] func3;
logic [6:0] func7;

assign func3 = instr[14:12];
assign func7 = instr[31:25];


always_comb begin
    decode_out = '0; //默认值，防止产生锁存？
    if(instr[6:0] == 7'b0110011)begin

    decode_out.rs1 = instr[19:15];
    decode_out.rs2 = instr[24:20];
    decode_out.rd  = instr[11:7];
    decode_out.we  = 1'b1;
    //确定是R型指令,分为add/sub/and/or/xor/sll/sra
    case({func7,func3})
    10'b0000000_000:
    decode_out.alu_op = 4'b0000;//"ADD"
    10'b0100000_000:
    decode_out.alu_op = 4'b0001;//"SUB"
    10'b0000000_111:
    decode_out.alu_op = 4'b0010;//"AND"
    10'b0000000_110:
    decode_out.alu_op = 4'b0011;//"OR"
    10'b0000000_100:
    decode_out.alu_op = 4'b0100;//"XOR"
    10'b0000000_001:
    decode_out.alu_op = 4'b0101;//"SLL"
    10'b0000000_101:
    decode_out.alu_op = 4'b0110;//"SRL"
    10'b0100000_101:
    decode_out.alu_op = 4'b0111;//"SRA"    
    endcase

    end

    else begin
//    if(inst_alu[6:0] == )其他指令
    end

end

endmodule