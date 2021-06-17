`include "defines.h"

module cpu (
  output [15:0] imem_addr,
  input  [15:0] imem_rdata,
  output [15:0] dmem_addr,
  input  [15:0] dmem_rdata,
  output [15:0] dmem_wdata,
  output reg    dmem_write,
  output [127:0] led_reg,
  output [127:0] led_misc,
  output [3:0]   led_ph,
  input         start,
  input         stop,
  input         CLK,
  input         RSTN
  );

  wire [3:0] ph;
  wire [15:0] w_pc, w_ir, w_sr1, w_sr2, w_alu, w_dr;
  wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7;
  reg [15:0] regfile_wdata;
  reg pc_write, dr_write, regfile_write;

  // imem_addr
  assign imem_addr = w_pc;

  // dmem_addr
  assign dmem_addr = w_sr1;

  // dmem_wdata
  assign dmem_wdata = w_sr2;

  // led_reg, led_misc, led_ph
  assign led_reg  = {r7,r6,r5,r4,r3,r2,r1,r0};
  assign led_misc = {16'd0,16'd0,w_dr,w_alu,w_sr2,w_sr1,w_ir,w_pc};
  assign led_ph   = ph;

  // pc_write
  always @*
  begin
    casex ({ph,w_ir})
    {`PH3,`B}:   pc_write = 1'b1; // B
    {`PH3,`BNZ}: pc_write = 1'b1; // BNZ
    default:     pc_write = 1'b0;
    endcase
  end

  // regfile_write
  always @*
  begin
    casex ({ph,w_ir})
    {`PH3,`LD}:  regfile_write = 1'b1;
    {`PH3,`ADD}: regfile_write = 1'b1;
    {`PH3,`LI}:  regfile_write = 1'b1;
    default:     regfile_write = 1'b0;
    endcase
  end

  // dmem_write
  always @*
  begin
    casex ({ph,w_ir})
    {`PH2,`ST}:  dmem_write = 1'b1;
    default:    dmem_write = 1'b0;
    endcase
  end

  // dr_write
  always @*
  begin
    casex ({ph,w_ir})
    {`PH2,`LD}: dr_write = 1'b1;
    default:    dr_write = 1'b0;
    endcase
  end

  // regfile_wdata
  always @*
  begin
    casex (w_ir)
    `LD:     regfile_wdata = w_dr;
    default: regfile_wdata = w_alu;
    endcase
  end

  sm sm (
    .q(ph),
    .start(start),
    .stop(stop),
    .CLK(CLK),
    .RSTN(RSTN)
  );

  count16rle pc (
    .q(w_pc),
    .load(pc_write),
    .inc(ph[0]),
    .d(w_alu),
    .CLK(CLK),
    .RSTN(RSTN)
  );

  reg16 ir (
    .q(w_ir),
    .load(ph[0]),
    .d(imem_rdata),
    .CLK(CLK),
    .RSTN(RSTN)
  );

  regfile regfile (
    .q0(r0),
    .q1(r1),
    .q2(r2),
    .q3(r3),
    .q4(r4),
    .q5(r5),
    .q6(r6),
    .q7(r7),
    .load(regfile_write),
    .wsel(w_ir[13:11]),
    .d(regfile_wdata),
    .CLK(CLK),
    .RSTN(RSTN)
  );

  muxreg16 sr1 (
    .q(w_sr1),
    .load(ph[1]),
    .d0(r0),
    .d1(r1),
    .d2(r2),
    .d3(r3),
    .d4(r4),
    .d5(r5),
    .d6(r6),
    .d7(r7),
    .sel(w_ir[10:8]),
    .CLK(CLK),
    .RSTN(RSTN)
  );

  muxreg16 sr2 (
    .q(w_sr2),
    .load(ph[1]),
    .d0(r0),
    .d1(r1),
    .d2(r2),
    .d3(r3),
    .d4(r4),
    .d5(r5),
    .d6(r6),
    .d7(r7),
    .sel(w_ir[7:5]),
    .CLK(CLK),
    .RSTN(RSTN)
  );

  alu alu (
    .q(w_alu),
    .sr1(w_sr1),
    .sr2(w_sr2),
    .pc(w_pc),
    .ir(w_ir),
    .ph(ph),
    .CLK(CLK),
    .RSTN(RSTN)
  );

  reg16 dr (
    .q(w_dr),
    .load(dr_write),
    .d(dmem_rdata),
    .CLK(CLK),
    .RSTN(RSTN)
  );

endmodule
