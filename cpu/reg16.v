module reg16(
  output reg [15:0] q,
  input [15:0] d,
  input load,
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
    end
  end
endmodule
