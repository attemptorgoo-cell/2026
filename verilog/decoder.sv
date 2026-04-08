import my_riscv_pkg::*; 
//导入package

module decoder(
    input logic clk,
    input logic [31:0] instr,
    output decode_out_t decode_out
);

logic [2:0] func3;
logic [6:0] func7;
logic [31:0] imm;
assign func3 = instr[14:12];
assign func7 = instr[31:25];
assign imm   = {{20{instr[31]}}, instr[31:20]};
//立即数位宽拓展到32，保留符号

always_comb begin
    decode_out = '0; //默认值，防止产生锁存？




case(instr[6:0])
    7'b0000011:begin
//-------------------------------------------------------------------------------------------
//确定是I-l型指令,分为lw,lb,lh,lbu,lhu

        decode_out.rs1 = instr[19:15];
        decode_out.rd  = instr[11:7];
        decode_out.we  = 1'b1;

        decode_out.imm_we     = 1'b1;
        decode_out.imm        = imm;
        
        decode_out.alu_op     = 4'b0000;
        decode_out.memory_re  = 1;
        decode_out.func3      = func3;




    end
    7'b0010011:begin
//-------------------------------------------------------------------------------------------
//确定是I-imm型指令,分为ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI 
        decode_out.rs1 = instr[19:15];
        decode_out.rd  = instr[11:7];
        decode_out.we  = 1'b1;


        decode_out.imm_we = 1'b1;
        decode_out.imm    = imm;
    case(func3) 
        3'b000:
            decode_out.alu_op = 4'b0000;   //"ADDI"
        3'b111:
            decode_out.alu_op = 4'b0010;   //"ANDI"
        3'b110:
            decode_out.alu_op = 4'b0011;   //"ORI"
        3'b100:
            decode_out.alu_op = 4'b0100;   //"XORI"
        3'b001:
            decode_out.alu_op = 4'b0101;   //"SLLI"

        3'b101:
        begin
            if(instr[30] == 0)
            decode_out.alu_op = 4'b0110;   //"SRLI"
            else
            decode_out.alu_op = 4'b0111;   //"SRAI"   
        end
        3'b010:
            decode_out.alu_op = 4'b1000;   //"SLTI"
        3'b011:
            decode_out.alu_op = 4'b1001;   //"sltiu"
    endcase
    end
    

//------------------------------------------------------------------------------------------
//确定是R型指令,分为add/sub/and/or/xor/sll/sra
    7'b0110011:begin

    decode_out.rs1 = instr[19:15];
    decode_out.rs2 = instr[24:20];
    decode_out.rd  = instr[11:7];
    decode_out.we  = 1'b1;
    
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
        10'b0000000_010:
            decode_out.alu_op = 4'b1000;//"SLT"
        10'b0000000_011:
            decode_out.alu_op = 4'b1001;//"SLTU"
 
    endcase
    end
  
endcase

end

endmodule