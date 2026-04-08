//暂时无复位，没有处理内部冲突
module regFiles(
    input  logic clk,
    input  logic rst,
    input  logic [4:0] rs1,rs2,rd,

//r
    output logic [31:0] rdata1,rdata2,

//w
    input  logic we,
    input  logic [31:0] wdata
);

logic [31:0] regs [0:31];
//寄存器本体

//read data
assign rdata1 = (rs1 == 0)? 32'd0 : regs[rs1];
assign rdata2 = (rs2 == 0)? 32'd0 : regs[rs2];

//write data
always_ff @(posedge clk) begin
    if(~rst) begin
    for (int i = 0 ; i < 32; i++) regs[i] = 0;
    // regs[1] = 32'd1; // 给 x1 塞个 10
    // regs[2] = 32'd2; // 给 x2 塞个 20
    end else 
    if(we) begin
    regs[rd] <= (rd == 0)? 32'd0 : wdata;
    end
end

endmodule