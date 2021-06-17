module regfile (
  output reg [15:0] q0,
  output reg [15:0] q1,
  output reg [15:0] q2,
  output reg [15:0] q3,
  output reg [15:0] q4,
  output reg [15:0] q5,
  output reg [15:0] q6,
  output reg [15:0] q7,
  input [15:0] d,
  input load,
  input [2:0] wsel,
  input CLK,
  input RSTN
  );
  always @(posedge CLK or negedge RSTN)
  begin
    if (!RSTN) begin
      {q0,q1,q2,q3,q4,q5,q6,q7} <= 128'b0;
    end
    else if (load) begin
      case (wsel)
      3'b000 : q0 <= d;
      3'b001 : q1 <= d;
      3'b010 : q2 <= d;
      3'b011 : q3 <= d;
      3'b100 : q4 <= d;
      3'b101 : q5 <= d;
      3'b110 : q6 <= d;
      3'b111 : q7 <= d;
      endcase
    end
  end
endmodule
