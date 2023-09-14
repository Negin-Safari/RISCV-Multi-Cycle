module mux4to1_64b (i0, i1, i2, i3, sel, y);
  input [63:0] i0, i1, i2,i3;
  input [1:0]sel;
  output [63:0] y;
  
  assign y = (sel==2'd3) ? i3 : 
             (sel==2'd2) ? i2 : 
             (sel==2'd1) ? i1 : i0;
  
endmodule


