module regFiles(
    input  wire clk,
    input  wire [4:0] rs1,rs2,rd,

//r
    output wire [31:0] rdata1,rdata2,

//w
    input  wire we,
    input  wire [31:0] wdata
);

reg [31:0] regs [0:31];

//read data
assign rdata1 = (rs1 == 0)? 32'd0 : regs[rs1];
assign rdata2 = (rs2 == 0)? 32'd0 : regs[rs2];

//write data
always @(posedge clk) begin
    if(we) begin
    regs[rd] <= wdata;
    end
end
endmodule