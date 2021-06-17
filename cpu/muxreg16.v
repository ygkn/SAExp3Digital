module muxreg16 (
  output reg [15:0] q,
  input [15:0] d0,
  input [15:0] d1,
  input [15:0] d2,
  input [15:0] d3,
  input [15:0] d4,
  input [15:0] d5,
  input [15:0] d6,
  input [15:0] d7,
  input load,
  input [2:0] sel,
  input CLK,
  input RSTN
  );
  always @(posedge CLK or negedge RSTN)
  begin
    if (!RSTN) begin
      q <= 0;
    end
    else if (load) begin
      case (sel)
      3'b000 : q <= d0;
      3'b001 : q <= d1;
      3'b010 : q <= d2;
      3'b011 : q <= d3;
      3'b100 : q <= d4;
      3'b101 : q <= d5;
      3'b110 : q <= d6;
      3'b111 : q <= d7;
      endcase
    end	
  end
endmodule
