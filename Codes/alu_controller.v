module alu_controller (alu_op, func_alu, operation);
  input [2:0] alu_op;
  input [3:0] func_alu;
  output [3:0] operation;
  reg [3:0] operation;
  ////////////////////
  always @(alu_op, func_alu)
  begin
    operation = 4'b0000;
    if (alu_op == 3'b000)        // ld or sd  
      operation = 4'b0010;
    else if (alu_op == 3'b001)   // beq
      operation = 4'b0110;
    else if(alu_op ==3'b010)
      begin
        case (func_alu)
          4'b0000: operation = 4'b0010;  // add
          4'b1000: operation = 4'b0110;  // sub
          4'b0111: operation = 4'b0000;  // and
          4'b0110: operation = 4'b0001;  // or
          4'b0010: operation = 4'b0111;  // slt 
          4'b0001: operation = 4'b0011; //sll
          4'b0101: operation = 4'b0100; //srl
          default:   operation = 4'b0000;
        endcase
      end
      
    else if(alu_op==3'b100) operation = 4'b1000;   //2*IM+PCout-4 
    else if(alu_op==3'b101) operation = 4'b1001;   //alures+2*rs1
      
    else  // i type
     begin
       case (func_alu[2:0])
       3'b010:   operation =4'b0111; //slti
       3'b000:   operation =4'b0010; //addi
     endcase
     end
      
     
  end
  
endmodule
