module reg_64b (d_in, sclr, ld, clk, d_out);
  input [63:0] d_in;
  input sclr, ld, clk;
  output [63:0] d_out;
  reg [63:0] d_out;
  
  always @(posedge clk)
  begin
    if (sclr==1'b1)
      d_out = 64'd0;
    else if (ld)
      d_out = d_in;
  end
  
endmodule