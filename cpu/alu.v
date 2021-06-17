`include "defines.h"

module alu (
  output reg [15:0] q,
  input [15:0] sr1,
  input [15:0] sr2,
  input [15:0] pc,
  input [15:0] ir,
  input [3:0] ph,
  input CLK,
  input RSTN
  );
  
  wire [15:0] imm8 = {{8{ir[7]}},ir[7:0]};
  
  always @(posedge CLK or negedge RSTN)
  begin
    if (!RSTN)
    begin
      q <= 0;
    end
    else
    begin
      casex ({ph,ir})
      {`PH2,`ADD}: q <= 
      {`PH2,`LI}:  q <= 
      {`PH2,`B}:   q <= pc + imm8;
      {`PH2,`BNZ}: 
      endcase
    end
  end
endmodule
