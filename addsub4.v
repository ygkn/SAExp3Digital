module addsub4(
    output reg [3:0] y,
    input [3:0] a,
    input [3:0] b,
    input sel
  );

  always @*
  begin
    if (sel == 1) y = a + b;
    else y = a - b;
  end
endmodule
