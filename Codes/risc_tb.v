module risc_tb;
  
  reg clk, rst;
  wire [63:0] dataOUT,inst_adr;
  wire [31:0] inst;
  wire [63:0] dataIN;
  wire  MemWrite, MemRead;
  wire [63:0] DATA;
  
  RISCV_multi_cycle  RISC(rst, clk,dataIN,dataOUT,inst_adr,inst, MemWrite, MemRead,DATA);
  
  
  mem MEM(clk,dataOUT,MemRead,MemWrite,DATA,dataIN);
  
  
  
  initial
  begin
    rst = 1'b1;
    clk = 1'b0;
    #20 rst = 1'b0;
    #15000 $stop;
  end
  
  always
  begin
    #8 clk = ~clk;
  end
  
endmodule
