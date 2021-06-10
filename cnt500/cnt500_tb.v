module cnt500_tb;
  wire [3:0] q_high;
  wire [3:0] q_low;
  wire [4:0] q_ph;
  reg start;
  reg stop;
  reg CLK;
  reg RSTN;

  initial begin
    CLK = 0;
    while(1) begin
      #10
      CLK = ~CLK;
    end
  end

  initial begin
    $dumpfile("cnt500.vcd");
    $dumpvars(0,cnt500_tb);
    RSTN = 0;
    start = 0;
    stop = 0;
    #100
    RSTN = 1;
    #100
    start = 1;
    #100
    start = 0;
    #10060
    stop = 1;
    #100
    stop = 0;
    #400
    $finish;
  end

  cnt500 cnt500 (
    .q_high(q_high), .q_low(q_low),
    .q_ph(q_ph),
    .start(start), .stop(stop),
    .CLK(CLK), .RSTN(RSTN));

endmodule
