module cnt500 (
  output [3:0] q_high,
  output [3:0] q_low,
  output [4:0] q_ph,
  input start,
  input stop,
  input CLK,
  input RSTN
  );

  wire max_low;

  phase phase (
    .q(q_ph),
    .start(start),
    .stop(stop),
    .CLK(CLK),
    .RSTN(RSTN));

  cnt10 cnt10_low (
    .q(q_low),
    .max(max_low),
    .inc(q_ph[4]),
    .CLK(CLK),
    .RSTN(RSTN));


  cnt10 cnt10_high (
    .q(q_high),
    .max(),
    .inc(max_low),
    .CLK(CLK),
    .RSTN(RSTN));

endmodule
