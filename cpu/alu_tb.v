module alu_tb;

  wire [15:0] w_alu;
  reg [15:0] sr1;
  reg [15:0] sr2;
  reg [15:0] pc;
  reg [15:0] ir;
  reg [3:0] ph;
  reg CLK;
  reg RSTN;
  reg [15:0] regfile [0:7];

  // RSTN, $finish
  initial
  begin
    $dumpfile("alu.vcd");
    $dumpvars(0,alu_tb);
    RSTN  = 0;
    #20
    RSTN  = 1;
    #610
    $finish;
  end

  // CLK
  initial
  begin
    CLK = 0;
    while (1)
    begin
      #10
      CLK = ~CLK;
    end
  end

  // ph
  initial
  begin
    ph <= 4'b0000;
    #50
    ph <= 4'b0001;
    while (1)
    begin
      #20
      ph <= {ph[2:0],ph[3]};
    end
  end

  // pc
  initial
  begin
    pc <= 0;
    #50
    while (1)
    begin
      @(posedge CLK)
      if (ph[0])
      begin
        pc <= pc + 1;
      end
      else if (ph[3] && ir[15:14]==2'b10)
      begin
        pc <= w_alu;
      end
    end
  end

  // ir
  initial
  begin
    ir <= 0;
    #50
    while (1)
    begin
      @(posedge CLK)
      if (ph[0])
      begin
        case (pc)
        0: ir <= 16'b0111100011001110; // 000 :     LI  r7, -50
        1: ir <= 16'b0111000001100100; // 001 : L1: LI  r6, 100
        2: ir <= 16'b0011011111000010; // 002 : L2: ADD r6, r7, r6
        3: ir <= 16'b1000111011111110; // 003 :     BNZ r6, L2:
        4: ir <= 16'b1000000011111100; // 004 :     B   L1:
        5: ir <= 16'b0110000001011001; // 005 :     LI  r4, 89
        default: ir <= 16'bx;
        endcase
      end
    end
  end

  // regfile
  initial
  begin
    regfile[0] <= 0; regfile[1] <= 0; regfile[2] <= 0; regfile[3] <= 0;
    regfile[4] <= 0; regfile[5] <= 0; regfile[6] <= 0; regfile[7] <= 0;
    #50
    while (1)
    begin
      @(posedge CLK)
      casex ({ph,ir})
      20'b1xxx_00xxxxxxxxx00010: regfile[ir[13:11]] <= w_alu;
      20'b1xxx_01xxx000xxxxxxxx: regfile[ir[13:11]] <= w_alu;
      endcase
    end
  end

  // sr1, sr2
  initial
  begin
    sr1 <= 0;
    sr2 <= 0;
    #50
    while (1)
    begin
      @(posedge CLK)
      if (ph[1]) begin
        sr1 <= regfile[ir[10:8]];
        sr2 <= regfile[ir[7:5]];
      end
    end
  end

  // ALU
  alu alu (
    .q(w_alu),
    .sr1(sr1),
    .sr2(sr2),
    .pc(pc),
    .ir(ir),
    .ph(ph),
    .CLK(CLK),
    .RSTN(RSTN)
  );

endmodule