module cnt10(
  output reg [3:0] q,
  output max,
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
      if (inc) begin
        if (q == 9) begin
          q <= 0;
        end
        else begin
          q <= q+1;
        end
      end
    end
  end
  assign max = (inc == 1 && q == 9) ? 1 : 0;
endmodule
