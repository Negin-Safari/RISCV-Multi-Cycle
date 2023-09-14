module mem (clk,adr,MemRead,MemWrite,mem_data_in,mem_data_out);
  input clk;
  input MemRead, MemWrite;
  input [63:0] mem_data_in;
  output [63:0] mem_data_out;
  input [63:0] adr;
  wire[63:0] min;
  wire [63:0] index;
  reg [7:0] mem[0:65535];
  
  always @(posedge clk)
    if (MemWrite==1'b1)
      {mem[adr+7], mem[adr+6], mem[adr+5], mem[adr+4],mem[adr+3], mem[adr+2], mem[adr+1], mem[adr]} = mem_data_in;
  
  assign mem_data_out = (MemRead==1'b1) ? {mem[adr+7], mem[adr+6], mem[adr+5], mem[adr+4],mem[adr+3], mem[adr+2], mem[adr+1], mem[adr]} : 64'd0;
  assign min={mem[2007], mem[2006], mem[2005], mem[2004],mem[2003], mem[2002], mem[2001], mem[2000]};
  assign index={mem[2015], mem[2014], mem[2013], mem[2012],mem[2011], mem[2010], mem[2009], mem[2008]};
  
  initial
  begin
    //         add    R8, R0, R0 0
    //         addi   R10,  R0, 20 4
    //         ld     R2, 1000(R8) 8
    //         add    R3, R0, R8    12
    // Loop:   beq    R8,  R10, END_LOOP 16   
    //         add    R13, R8, R8      20     /////
    //         add    R13, R13, R13     24    ////
    //         add    R13, R13, R13     28
    //         ld     R7, 1000(R13)     32      ///
    //         slt    R11, R7, R2       36 
    //         beq    R0, R11, END_IF   40    ////////////////
    //    	    add    R2, R0, R7        44  //////
    //         add    R3, R0, R8        48
    // END_IF: addi   R8, R8, 1         52
    //         J      LOOP              56   ////(beq)
    // END_LOOP: sd, R2, 2000(R0)       60
    //           sd, R3, 2004(R0)       64
    ///////////////// // 
    //            jal  X1, TEST         68
    //  RETURTN:  sll R17,R3,R2         72
    //            srl R18,R3,R2         76
    //            lw R20, 1500(R0)      80
    //            ld R21, 1500(R0)      84
    //            sw R21, 1504(R0)      88
    //  TEST:     sub R9,R3,R2          120
    //            or R12,R3,R2          124
    //            and R14,R3,R2         128
    //            slti R15,R2,20        132
    //            jalr R16 RETURN(R2)   136

    
//  {mem[3], mem[2], mem[1], mem[0]}     = {7'd0, 5'd0, 5'd0,3'd0, 5'd8,7'b0110011};   
//   {mem[7], mem[6], mem[5], mem[4]}     = {12'd20, 5'd0,3'd0, 5'd10, 7'b0010011};               
//   {mem[11], mem[10], mem[9], mem[8]}   = {12'd1000, 5'd8, 3'd3,5'd2,7'b0000011};                
//   {mem[15], mem[14], mem[13], mem[12]} = {7'd0, 5'd8, 5'd0, 3'd0, 5'd3,7'b0110011};           
//   {mem[19], mem[18], mem[17], mem[16]} = {1'd0,6'd1,5'd10,5'd8,3'd0,4'd6,1'd0,7'b1100011};  ////
//   {mem[23], mem[22], mem[21], mem[20]} = {7'd0, 5'd8, 5'd8,3'd0,5'd13,7'b0110011};              
//   {mem[27], mem[26], mem[25], mem[24]} = {7'd0, 5'd13, 5'd13,3'd0,5'd13,7'b0110011}; 
//   {mem[31], mem[30], mem[29], mem[28]} = {7'd0, 5'd13, 5'd13,3'd0,5'd13,7'b0110011}; 
//              
//   {mem[35], mem[34], mem[33], mem[32]} = {12'd1000, 5'd13, 3'd3,5'd7,7'b0000011};
//   {mem[39], mem[38], mem[37], mem[36]} = {7'd0, 5'd2, 5'd7, 3'd2, 5'd11, 7'b0110011}; 
//   {mem[43], mem[42], mem[41], mem[40]} = {1'd0, 6'd0, 5'd11, 5'd0, 3'd0, 4'd6, 1'd0,7'b1100011}; 
//   {mem[47], mem[46], mem[45], mem[44]} = {7'd0, 5'd7, 5'd0,3'd0, 5'd2,7'b0110011};
//   {mem[51], mem[50], mem[49], mem[48]} = {7'd0, 5'd8, 5'd0,3'd0, 5'd3,7'b0110011};
//   {mem[55], mem[54], mem[53], mem[52]} = {12'd1, 5'd8,3'd0, 5'd8, 7'b0010011}; 
//   {mem[59], mem[58], mem[57], mem[56]} = {1'd1, 6'd62,5'd0,5'd0,3'd0,4'd12,1'd1,7'b1100011}; ////
//   {mem[63], mem[62], mem[61], mem[60]} = {7'd62, 5'd2, 5'd0, 3'd7, 5'd16, 7'b0100011};
//   {mem[67], mem[66], mem[65], mem[64]} = {7'd62, 5'd3, 5'd0, 3'd7, 5'd24, 7'b0100011}; 
     $readmemb( "memory.mem", mem ); 
//// srl,sll,jal,jalr,slti,lw,sw
      {mem[71], mem[70], mem[69], mem[68]} = {1'd0,10'd26,1'd0,8'd0,5'd1,7'b1101111};	 //dorost shoo
      {mem[75], mem[74], mem[73], mem[72]} = {7'd0,5'd2,5'd3,3'd1,5'd17,7'b0110011};
      {mem[79], mem[78], mem[77], mem[76]} = {7'd0,5'd2,5'd3,3'd5,5'd18,7'b0110011};
      {mem[83], mem[82], mem[81], mem[80]} = {12'd1500,5'd0,3'd2,5'd20,7'b0000011}; //lw
      {mem[87], mem[86], mem[85], mem[84]} = {12'd1500,5'd0,3'd3,5'd21,7'b0000011}; //ld
      {mem[91], mem[90], mem[89], mem[88]} = {7'd47,5'd21,5'd0,3'd2,5'd4,7'b0100011}; //sw
      {mem[123], mem[122], mem[121], mem[120]} = {7'd32,5'd2,5'd3,3'd0,5'd9,7'b0110011};
      {mem[127], mem[126], mem[125], mem[124]} = {7'd0,5'd2,5'd3,3'd6,5'd12,7'b0110011};
      {mem[131], mem[130], mem[129], mem[128]} = {7'd0,5'd2,5'd3,3'd7,5'd14,7'b0110011};
      {mem[135], mem[134], mem[133], mem[132]} = {12'd20,5'd2,3'd2,5'd15,7'b0010011};
      {mem[139], mem[138], mem[137], mem[136]} = {-12'd35,5'd2,3'd0,5'd16,7'b1100111};
//
//
   // {mem[1007], mem[1006], mem[1005], mem[1004],mem[1003], mem[1002], mem[1001], mem[1000]} = 64'd8;    //0
//    {mem[1015], mem[1014], mem[1013], mem[1012],mem[1011], mem[1010], mem[1009], mem[1008]} = 64'd111;  //1
//    {mem[1023], mem[1022], mem[1021], mem[1020],mem[1019], mem[1018], mem[1017], mem[1016]} = 64'd11;   //2
//    {mem[1031], mem[1030], mem[1029], mem[1028],mem[1027], mem[1026], mem[1025], mem[1024]} = 64'd5;    //3
//    {mem[1039], mem[1038], mem[1037], mem[1036],mem[1035], mem[1034], mem[1033], mem[1032]} = 64'd4;    //4
//    {mem[1047], mem[1046], mem[1045], mem[1044],mem[1043], mem[1042], mem[1041], mem[1040]} = 64'd5;    //5
//    {mem[1055], mem[1054], mem[1053], mem[1052],mem[1051], mem[1050], mem[1049], mem[1048]} = 64'd6;    //6
//    {mem[1063], mem[1062], mem[1061], mem[1060],mem[1059], mem[1058], mem[1057], mem[1056]} = 64'd7;    //7
//    {mem[1071], mem[1070], mem[1069], mem[1068],mem[1067], mem[1066], mem[1065], mem[1064]} = 64'd7;    //8
//    {mem[1079], mem[1078], mem[1077], mem[1076],mem[1075], mem[1074], mem[1073], mem[1072]} = 64'd3;    //9
//    {mem[1087], mem[1086], mem[1085], mem[1084],mem[1083], mem[1082], mem[1081], mem[1080]} = 64'd101;   //10
//    {mem[1095], mem[1094], mem[1093], mem[1092],mem[1091], mem[1090], mem[1089], mem[1088]} = 64'd11;   //11
//    {mem[1103], mem[1102], mem[1101], mem[1100],mem[1099], mem[1098], mem[1097], mem[1096]} = 64'd12;   //12
//    {mem[1111], mem[1110], mem[1109], mem[1108],mem[1107], mem[1106], mem[1105], mem[1104]} = 64'd13;   //13
//    {mem[1119], mem[1118], mem[1117], mem[1116],mem[1115], mem[1114], mem[1113], mem[1112]} = 64'd5;   //14
//    {mem[1127], mem[1126], mem[1125], mem[1124],mem[1123], mem[1122], mem[1121], mem[1120]} = 64'd14;   //15
//    {mem[1135], mem[1134], mem[1133], mem[1132],mem[1131], mem[1130], mem[1129], mem[1128]} = 64'd14;   //16
//    {mem[1143], mem[1142], mem[1141], mem[1140],mem[1139], mem[1138], mem[1137], mem[1136]} = 64'd11;   //17
//    {mem[1151], mem[1150], mem[1149], mem[1148],mem[1147], mem[1146], mem[1145], mem[1144]} = 64'd11;   //18
//    {mem[1159], mem[1158], mem[1157], mem[1156],mem[1155], mem[1154], mem[1153], mem[1152]} = 64'd11; //19
//    {mem[1507], mem[1506], mem[1505], mem[1504],mem[1503], mem[1502], mem[1501], mem[1500]} = {32'd50,32'd12};
  end
  
  
endmodule
