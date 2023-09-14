module alu (a, b, ctrl, y, zero);
  input [63:0] a, b;
  input [3:0] ctrl;
  output [63:0] y;
  output zero;
  
  wire [63:0]sub;
  assign sub = a-b;
  
  assign y =  (ctrl == 4'b0000) ? (a & b) :
              (ctrl == 4'b0001) ? (a | b) : 
              (ctrl == 4'b0010) ? (a + b) :
              (ctrl == 4'b0011) ? (a << b) :
              (ctrl == 4'b0100) ? (a >> b) :
              (ctrl == 4'b0110) ? (a - b) : 
              (ctrl == 4'b1000) ? (a + (2*b) - 4):
              (ctrl == 4'b1001) ? (b + (2*a)) : ((sub[63]) ? 64'd1: 64'd0);
  
  assign zero = (y == 64'd0) ? 1'b1 : 1'b0;
  
endmodule
