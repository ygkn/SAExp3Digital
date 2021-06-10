module bintoled_tb;

  wire [7:0] led;
  reg [3:0] bin;
  
  initial
  begin
    $dumpfile("bintoled.vcd");
    $dumpvars(0,bintoled_tb);
    bin = 0;
    while (1)
    begin
      #10
      bin = bin + 1;
      if (bin==0) $finish;
    end
  end

  bintoled bintoled (.led(led), .bin(bin));
	
endmodule
