module bintoled (
  output reg [7:0] led,
  input [3:0] bin
  );
  always @*
  begin
    case (bin)
    4'b0000: led=8'b11111100;
    4'b0001: led=8'b01100000;
    4'b0010: led=8'b11011010;
    4'b0011: led=8'b11110010;
    4'b0100: led=8'b01100110;
    4'b0101: led=8'b10110110;
    4'b0110: led=8'b10111110;
    4'b0111: led=8'b11100000;
    4'b1000: led=8'b11111110;
    4'b1001: led=8'b11110110;
    default: led=8'b00000010;
    endcase
  end
endmodule
