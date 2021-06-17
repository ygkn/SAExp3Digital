`define IMEMSIZE 256
`define DMEMSIZE 256

`ifndef IMEMFILE
`define IMEMFILE "bin.txt"
`endif

module cpu_tb;

  wire [15:0] imem_addr;
  wire [15:0] imem_rdata;
  wire [15:0] dmem_addr;
  wire [15:0] dmem_rdata;
  wire [15:0] dmem_wdata;
  wire        dmem_write;
  reg         start;
  reg         stop;
  reg         CLK;
  reg         RSTN;
  reg  [15:0] imem [0:`IMEMSIZE-1];
  reg  [15:0] dmem [0:`DMEMSIZE-1];

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

  // RSTN, start, stop, $finish
  initial
  begin
    RSTN  = 0;
    start = 0;
    stop  = 0;
    #20
    RSTN  = 1;
    #20
    start = 1;
    #20
    start = 0;
    #140000
    $finish;
  end

  // imem
  assign imem_rdata = (imem_addr < `IMEMSIZE) ? imem[imem_addr] : 16'hxxxx;
  initial
  begin
    $readmemb(`IMEMFILE,imem);
  end

  // dmem
  assign dmem_rdata = (dmem_addr < `DMEMSIZE) ? dmem[dmem_addr] : 16'hxxxx;
  always @(posedge CLK)
  begin
    if (dmem_write) begin
      if (dmem_addr < `DMEMSIZE) begin
        dmem[dmem_addr] <= dmem_wdata;
      end
      else
		begin
        $display("dmem_addr: Out of range (%h >= %h).",dmem_addr,`DMEMSIZE);
      end
    end
  end

  // cpu
  cpu cpu (
	.imem_addr(imem_addr),
	.imem_rdata(imem_rdata),
	.dmem_addr(dmem_addr),
	.dmem_rdata(dmem_rdata),
	.dmem_wdata(dmem_wdata),
	.dmem_write(dmem_write),
  .start(start),
  .stop(stop),
	.CLK(CLK), 
	.RSTN(RSTN)
	);

  // Generate VCD file
  initial begin
    $dumpfile("cpu.vcd");
    $dumpvars(0,cpu_tb,
cpu_tb.dmem[000],cpu_tb.dmem[001],cpu_tb.dmem[002],cpu_tb.dmem[003],cpu_tb.dmem[004],cpu_tb.dmem[005],cpu_tb.dmem[006],cpu_tb.dmem[007],cpu_tb.dmem[008],cpu_tb.dmem[009],
cpu_tb.dmem[010],cpu_tb.dmem[011],cpu_tb.dmem[012],cpu_tb.dmem[013],cpu_tb.dmem[014],cpu_tb.dmem[015],cpu_tb.dmem[016],cpu_tb.dmem[017],cpu_tb.dmem[018],cpu_tb.dmem[019],
cpu_tb.dmem[020],cpu_tb.dmem[021],cpu_tb.dmem[022],cpu_tb.dmem[023],cpu_tb.dmem[024],cpu_tb.dmem[025],cpu_tb.dmem[026],cpu_tb.dmem[027],cpu_tb.dmem[028],cpu_tb.dmem[029],
cpu_tb.dmem[030],cpu_tb.dmem[031],cpu_tb.dmem[032],cpu_tb.dmem[033],cpu_tb.dmem[034],cpu_tb.dmem[035],cpu_tb.dmem[036],cpu_tb.dmem[037],cpu_tb.dmem[038],cpu_tb.dmem[039],
cpu_tb.dmem[040],cpu_tb.dmem[041],cpu_tb.dmem[042],cpu_tb.dmem[043],cpu_tb.dmem[044],cpu_tb.dmem[045],cpu_tb.dmem[046],cpu_tb.dmem[047],cpu_tb.dmem[048],cpu_tb.dmem[049],
cpu_tb.dmem[050],cpu_tb.dmem[051],cpu_tb.dmem[052],cpu_tb.dmem[053],cpu_tb.dmem[054],cpu_tb.dmem[055],cpu_tb.dmem[056],cpu_tb.dmem[057],cpu_tb.dmem[058],cpu_tb.dmem[059],
cpu_tb.dmem[060],cpu_tb.dmem[061],cpu_tb.dmem[062],cpu_tb.dmem[063],cpu_tb.dmem[064],cpu_tb.dmem[065],cpu_tb.dmem[066],cpu_tb.dmem[067],cpu_tb.dmem[068],cpu_tb.dmem[069],
cpu_tb.dmem[070],cpu_tb.dmem[071],cpu_tb.dmem[072],cpu_tb.dmem[073],cpu_tb.dmem[074],cpu_tb.dmem[075],cpu_tb.dmem[076],cpu_tb.dmem[077],cpu_tb.dmem[078],cpu_tb.dmem[079],
cpu_tb.dmem[080],cpu_tb.dmem[081],cpu_tb.dmem[082],cpu_tb.dmem[083],cpu_tb.dmem[084],cpu_tb.dmem[085],cpu_tb.dmem[086],cpu_tb.dmem[087],cpu_tb.dmem[088],cpu_tb.dmem[089],
cpu_tb.dmem[090],cpu_tb.dmem[091],cpu_tb.dmem[092],cpu_tb.dmem[093],cpu_tb.dmem[094],cpu_tb.dmem[095],cpu_tb.dmem[096],cpu_tb.dmem[097],cpu_tb.dmem[098],cpu_tb.dmem[099],
cpu_tb.dmem[100],cpu_tb.dmem[101],cpu_tb.dmem[102],cpu_tb.dmem[103],cpu_tb.dmem[104],cpu_tb.dmem[105],cpu_tb.dmem[106],cpu_tb.dmem[107],cpu_tb.dmem[108],cpu_tb.dmem[109],
cpu_tb.dmem[110],cpu_tb.dmem[111],cpu_tb.dmem[112],cpu_tb.dmem[113],cpu_tb.dmem[114],cpu_tb.dmem[115],cpu_tb.dmem[116],cpu_tb.dmem[117],cpu_tb.dmem[118],cpu_tb.dmem[119],
cpu_tb.dmem[120],cpu_tb.dmem[121],cpu_tb.dmem[122],cpu_tb.dmem[123],cpu_tb.dmem[124],cpu_tb.dmem[125],cpu_tb.dmem[126],cpu_tb.dmem[127],cpu_tb.dmem[128],cpu_tb.dmem[129],
cpu_tb.dmem[130],cpu_tb.dmem[131],cpu_tb.dmem[132],cpu_tb.dmem[133],cpu_tb.dmem[134],cpu_tb.dmem[135],cpu_tb.dmem[136],cpu_tb.dmem[137],cpu_tb.dmem[138],cpu_tb.dmem[139],
cpu_tb.dmem[140],cpu_tb.dmem[141],cpu_tb.dmem[142],cpu_tb.dmem[143],cpu_tb.dmem[144],cpu_tb.dmem[145],cpu_tb.dmem[146],cpu_tb.dmem[147],cpu_tb.dmem[148],cpu_tb.dmem[149],
cpu_tb.dmem[150],cpu_tb.dmem[151],cpu_tb.dmem[152],cpu_tb.dmem[153],cpu_tb.dmem[154],cpu_tb.dmem[155],cpu_tb.dmem[156],cpu_tb.dmem[157],cpu_tb.dmem[158],cpu_tb.dmem[159],
cpu_tb.dmem[160],cpu_tb.dmem[161],cpu_tb.dmem[162],cpu_tb.dmem[163],cpu_tb.dmem[164],cpu_tb.dmem[165],cpu_tb.dmem[166],cpu_tb.dmem[167],cpu_tb.dmem[168],cpu_tb.dmem[169],
cpu_tb.dmem[170],cpu_tb.dmem[171],cpu_tb.dmem[172],cpu_tb.dmem[173],cpu_tb.dmem[174],cpu_tb.dmem[175],cpu_tb.dmem[176],cpu_tb.dmem[177],cpu_tb.dmem[178],cpu_tb.dmem[179],
cpu_tb.dmem[180],cpu_tb.dmem[181],cpu_tb.dmem[182],cpu_tb.dmem[183],cpu_tb.dmem[184],cpu_tb.dmem[185],cpu_tb.dmem[186],cpu_tb.dmem[187],cpu_tb.dmem[188],cpu_tb.dmem[189],
cpu_tb.dmem[190],cpu_tb.dmem[191],cpu_tb.dmem[192],cpu_tb.dmem[193],cpu_tb.dmem[194],cpu_tb.dmem[195],cpu_tb.dmem[196],cpu_tb.dmem[197],cpu_tb.dmem[198],cpu_tb.dmem[199],
cpu_tb.dmem[200],cpu_tb.dmem[201],cpu_tb.dmem[202],cpu_tb.dmem[203],cpu_tb.dmem[204],cpu_tb.dmem[205],cpu_tb.dmem[206],cpu_tb.dmem[207],cpu_tb.dmem[208],cpu_tb.dmem[209],
cpu_tb.dmem[210],cpu_tb.dmem[211],cpu_tb.dmem[212],cpu_tb.dmem[213],cpu_tb.dmem[214],cpu_tb.dmem[215],cpu_tb.dmem[216],cpu_tb.dmem[217],cpu_tb.dmem[218],cpu_tb.dmem[219],
cpu_tb.dmem[220],cpu_tb.dmem[221],cpu_tb.dmem[222],cpu_tb.dmem[223],cpu_tb.dmem[224],cpu_tb.dmem[225],cpu_tb.dmem[226],cpu_tb.dmem[227],cpu_tb.dmem[228],cpu_tb.dmem[229],
cpu_tb.dmem[230],cpu_tb.dmem[231],cpu_tb.dmem[232],cpu_tb.dmem[233],cpu_tb.dmem[234],cpu_tb.dmem[235],cpu_tb.dmem[236],cpu_tb.dmem[237],cpu_tb.dmem[238],cpu_tb.dmem[239],
cpu_tb.dmem[240],cpu_tb.dmem[241],cpu_tb.dmem[242],cpu_tb.dmem[243],cpu_tb.dmem[244],cpu_tb.dmem[245],cpu_tb.dmem[246],cpu_tb.dmem[247],cpu_tb.dmem[248],cpu_tb.dmem[249],
cpu_tb.dmem[250],cpu_tb.dmem[251],cpu_tb.dmem[252],cpu_tb.dmem[253],cpu_tb.dmem[254],cpu_tb.dmem[255]
);
  end

endmodule
