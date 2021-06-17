module sm(
  output reg [3:0] q,
  input start,
  input stop,
  input CLK,
  input RSTN
  );
  always @(posedge CLK or negedge RSTN)
  begin
    if (!RSTN) begin
      q <= 4'b0000;
    end
    else begin
      casex ({q,start,stop})
      6'b0000_1_x: q <= 4'b0001;
      6'b0001_x_x: q <= 4'b0010;
      6'b0010_x_x: q <= 4'b0100;
      6'b0100_x_x: q <= 4'b1000;
      6'b1000_x_0: q <= 4'b0001;
      6'b1000_x_1: q <= 4'b0000;
      endcase
    end
  end
endmodule
