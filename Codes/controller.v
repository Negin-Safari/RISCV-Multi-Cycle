module controller (clk,rst, func_alu,inst,zero,pcen, IorD, MemWrite, MemRead, IRWrite, MemtoReg, RegWrite, ALUSrcA,ALUSrcB, PCSrc,sw,operation);
  input [6:0]inst;
  input zero,clk,rst;
  output pcen, IorD, MemWrite, MemRead, IRWrite, RegWrite, ALUSrcA, PCSrc, sw;
  output [1:0] MemtoReg,ALUSrcB;
  
  reg  IorD, MemWrite, MemRead, IRWrite, RegWrite, ALUSrcA, PCSrc, sw;
  reg [1:0] MemtoReg,ALUSrcB;
  reg [2:0] alu_op;
  
  reg PCWrite,PCWrite_cond;
  input [3:0] func_alu;
  output [3:0] operation;
  
  alu_controller aluCtrl(alu_op, func_alu, operation);
  
  
  reg [3:0]ps,ns;
  always @(posedge clk, posedge rst) begin
    if(rst)
      ps<=4'b0000;
    else
      ps<=ns;
  end 
  
  always @(ps or inst)
  begin
    case (ps)
      4'd0: ns=4'b0001;
      4'd1: begin
                 case (inst)
                   7'b1100011: ns=4'd2; //beq
                   7'b1101111: ns=4'd3; //jal
                   7'b1100111: ns=4'd4; //jalr
                   7'b0110011: ns=4'd5; //R-type
                   7'b0010011: ns=4'd7; //I-type
                   7'b0000011: ns=4'd8; //ld,lw
                   7'b0100011: ns=4'd8; //sd,sw
                 endcase
               end 
     4'd2: ns=4'd0;
     4'd3: ns=4'd0;
     4'd4: ns=4'd0;  
     4'd5: ns=4'd6;
     4'd6: ns=4'd0; 
     4'd7: ns=4'd6;
     4'd8: begin
             if(inst==7'b0000011)
               ns=4'd9;
             else if(inst==7'b0100011)
               if(func_alu[2:0]==3'b010)
                  ns=4'd11;
                else
                  ns=4'd10;
           end  
     4'd9: begin
            if(func_alu[2:0]==3'b011)
              ns=4'd12;
            else
              ns=4'd13;
            end
     4'd10: ns=4'd0;
     4'd11: ns=4'd0;
     4'd12: ns=4'd0;     
     4'd13: ns=4'd0;
    endcase
  end
  
  
  always @(ps)
  begin
    {IorD, MemWrite, MemRead, IRWrite, RegWrite, ALUSrcA, PCSrc,MemtoReg,ALUSrcB,alu_op,PCWrite,PCWrite_cond,sw}=17'd0;
    case (ps)
      4'd0: {MemRead,IRWrite,ALUSrcA,ALUSrcB,IorD,PCSrc,PCWrite,alu_op}=11'b11001001000;  //IF
      4'd1: {ALUSrcA,ALUSrcB,alu_op}=6'b010100; //ID
      4'd2: {ALUSrcA,ALUSrcB,alu_op,PCWrite_cond,PCSrc}=8'b10000111; //beq completion
      4'd3: {MemtoReg,RegWrite,PCWrite,PCSrc}= 5'b10111;  //Jal completion
      4'd4: {ALUSrcA,ALUSrcB,alu_op,MemtoReg,RegWrite,PCWrite,PCSrc}=11'b11110110110; //Jalr completion
      4'd5: {ALUSrcA,ALUSrcB,alu_op}=6'b100010; //RT execution 
      4'd6: {MemtoReg,RegWrite}=3'b001; //IT,RT completion
      4'd7: {ALUSrcA,ALUSrcB,alu_op}=6'b110011; //IT execution
      4'd8: {ALUSrcA,ALUSrcB,alu_op}=6'b110000; //memory address computation 
      4'd9: {IorD, MemRead}=2'b11; //memory access Ld,lw
      4'd10: {IorD,MemWrite,sw}=3'b110; //memory access Sd
      4'd11: {IorD,MemWrite,sw}=3'b111; // memory access sw
      4'd12: {MemtoReg,RegWrite}=3'b011; //memory read completion ld
      4'd13: {MemtoReg,RegWrite}=3'b111; //memory read completion lw
    endcase
  end

  assign pcen= PCWrite|(PCWrite_cond & zero);
  
  
  
  
endmodule
