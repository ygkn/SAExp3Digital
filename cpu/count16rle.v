module count16rle(
  output reg [15:0] q,
  input [15:0] d,
  input load,
  input inc,
  input CLK,
  input RSTN
  );
  always @(posedge CLK or negedge RSTN)
  begin
    if (!RSTN) begin
      q <= 0;
    end
    else begin
      if (load) begin
        q <= d;
      end
      else if (inc) begin
        q <= q+1;
      end
    end
  end
endmodule
