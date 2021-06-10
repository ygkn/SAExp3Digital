module phase_tb;
  wire [4:0] q;
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
    $dumpfile("phase.vcd");
    $dumpvars(0,phase_tb);
    RSTN = 0;
    start = 0;
    stop = 0;
    #40
    RSTN = 1;
    #40
    start = 1;
    #80
    start = 0;
    #80
    stop = 1;
    #100
    stop = 0;
    #30
    $finish;
  end

  phase phase (.q(q), .start(start), .stop(stop), .CLK(CLK), .RSTN(RSTN));

endmodule
