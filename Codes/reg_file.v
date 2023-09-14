module reg_file (wr_data, rd_reg1, rd_reg2, wr_reg, reg_write, rst, clk, rd_data1, rd_data2);
  input [63:0] wr_data;
  input [4:0] rd_reg1, rd_reg2, wr_reg;
  input reg_write, rst, clk;
  output [63:0] rd_data1, rd_data2;
  
  reg [63:0] register_file [0:63];
  integer i;
  
  assign rd_data1 = (rd_reg1 == 5'b0) ? 64'd0 : register_file[rd_reg1];
  assign rd_data2 = (rd_reg2 == 5'b0) ? 64'd0 : register_file[rd_reg2];
  
  always @(posedge clk)
    if (rst == 1'b1)
      for (i=0; i<64 ; i=i+1 )
        register_file[i] <=64'd0;
    else if (reg_write == 1'b1)
      if(wr_reg != 5'd0)
        register_file[wr_reg] <= wr_data;
      
endmodule