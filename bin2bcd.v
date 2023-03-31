`timescale 1ns / 1ps

module bin2bcd (
    input [23:0] bin,
    output reg [23:0] bcd,
    output reg neg
);
  reg [23:0] foo;
  always @(bin) begin
    if (bin[23]) begin
      foo = 'd16777216 - bin;
      neg = 1;
    end else begin
      foo = bin;
      neg = 0;
    end
    bcd[3:0]   = foo % 'd10;
    bcd[7:4]   = foo / 'd10 % 'd10;
    bcd[11:8]  = foo / 'd100 % 'd10;
    bcd[15:12] = foo / 'd1000 % 'd10;
    bcd[19:16] = foo / 'd10000 % 'd10;
    bcd[23:20] = foo / 'd100000 % 'd10;
  end
endmodule
