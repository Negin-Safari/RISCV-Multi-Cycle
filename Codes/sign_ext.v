module sign_ext (d_in, d_out);
  input [31:0] d_in;
  output [63:0] d_out;
  
  assign d_out = {{32{d_in[31]}}, d_in};
  
endmodule