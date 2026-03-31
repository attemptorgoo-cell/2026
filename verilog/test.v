module test (
    input clk,
    input rst,
    output reg [31:0] data
);
  always @(posedge clk) begin
    if (rst) data <= 0;
    else data <= data + 1;
  end
endmodule
