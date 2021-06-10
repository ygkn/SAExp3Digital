module phase(
  output reg [4:0] q,
  input start,
  input stop,
  input CLK,
  input RSTN
  );
  always @(posedge CLK or negedge RSTN)
  begin
    if (!RSTN) begin
      q <= 0;
    end
    else begin
      casex ({q,start,stop})
      7'b00000_1_x: q <= 5'b00001;
      7'b00001_x_x: q <= 5'b00010;
      7'b00010_x_x: q <= 5'b00100;
      7'b00100_x_x: q <= 5'b01000;
      7'b01000_x_x: q <= 5'b10000;
      7'b10000_x_0: q <= 5'b00001;
      7'b10000_x_1: q <= 5'b00000;
      endcase
    end
  end
endmodule
