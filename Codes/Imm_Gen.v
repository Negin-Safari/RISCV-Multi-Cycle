module Imm_Gen(inst,Imm_Gen_out);
  input [31:0] inst;
  output [63:0] Imm_Gen_out;
  reg [63:0] Imm_Gen_out;
  wire [9:0] func_op;
  assign func_op={inst[14:12],inst[6:0]};
  always@(inst)begin
    case(func_op)
      10'b0110000011: Imm_Gen_out={{52{inst[31]}},inst[31:20]};  //ld
      10'b0100000011: Imm_Gen_out={{52{inst[31]}},inst[31:20]};  //lw
      10'b1110100011: Imm_Gen_out={{52{inst[31]}},inst[31:25],inst[11:7]};  //sd
      10'b0100100011: Imm_Gen_out={{52{inst[31]}},inst[31:25],inst[11:7]};  //sw
      10'b0000010011: Imm_Gen_out={{52{inst[31]}},inst[31:20]};  //addi
      10'b0100010011: Imm_Gen_out={{52{inst[31]}},inst[31:20]};  //slti
      10'b0001100111: Imm_Gen_out={{52{inst[31]}},inst[31:20]};  //jalr
      10'b0001100011: Imm_Gen_out={{52{inst[31]}},inst[31],inst[7],inst[30:25],inst[11:8]}; //beq
      default: Imm_Gen_out=64'd0;
    endcase
    if(func_op[6:0]==7'b1101111)   //jal
      Imm_Gen_out={{44{inst[31]}},inst[31],inst[19:12],inst[20],inst[30:21]};
    end
  endmodule
