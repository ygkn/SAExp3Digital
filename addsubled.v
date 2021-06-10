module addsubled (
  output [7:0] SEG_A,
  output [3:0] SEG_SELA,
  input [3:0] DIPSW_A,
  input [3:0] DIPSW_B,
  input PSW_D0
  );
  wire [3:0] y;
  assign SEG_SELA = 4'b1110;
  addsub4 addsub4 (
    .y(y),
    .a(DIPSW_A),
    .b(DIPSW_B),
    .sel(PSW_D0));
  bintoled bintoled (
    .led(SEG_A),
    .bin(y));
endmodule
