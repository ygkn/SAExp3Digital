module cnt10_tb;
  wire [3:0] q;
  wire max;
  reg inc;
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
    $dumpfile("cnt10.vcd");
    $dumpvars(0,cnt10_tb);
    RSTN = 0;
    inc = 0;
    #20
    RSTN = 1;
    #20
    inc = 1;
    #40
    inc = 0;
    #40
    inc = 1;
    #140
    inc = 0;
    #40
    inc = 1;
    #70
    $finish;
  end

  cnt10 cnt10 (.q(q), .max(max), .inc(inc), .CLK(CLK), .RSTN(RSTN));

endmodule
