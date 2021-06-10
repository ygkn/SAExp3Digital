module addsub4_tb;

  wire [3:0] y;
  reg [3:0] a;
  reg [3:0] b;
  reg sel;

  initial
  begin
    $dumpfile("addsub4.vcd");
    $dumpvars(0, addsub4_tb);
    a = 0;
    b = 0;
    sel = 0;
    while (1)
    begin
      #10
      a = $random;
      b = $random;
      sel = $random;
    end
  end

  initial
  begin
    #100
    $finish;
  end

  addsub4 addsub4 (.y(y), .a(a), .b(b), .sel(sel));

endmodule
