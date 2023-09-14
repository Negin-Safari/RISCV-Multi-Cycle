module data_mem (adr, d_in, mrd, mwr, clk, d_out);
  input [63:0] adr;
  input [63:0] d_in;
  input mrd, mwr, clk;
  output [63:0] d_out;
  
  reg [15:0] mem[0:65535];
  
  initial
  begin
//    {mem[1503], mem[1502], mem[1501], mem[1500]} = {32'd50,32'd12};
//    {mem[1003], mem[1002], mem[1001], mem[1000]} = 64'd8;    //0
//    {mem[1007], mem[1006], mem[1005], mem[1004]} = 64'd111;  //1
//    {mem[1011], mem[1010], mem[1009], mem[1008]} = 64'd11;   //2
//    {mem[1015], mem[1014], mem[1013], mem[1012]} = 64'd5;    //3
//    {mem[1019], mem[1018], mem[1017], mem[1016]} = 64'd4;    //4
//    {mem[1023], mem[1022], mem[1021], mem[1020]} = 64'd5;    //5
//    {mem[1027], mem[1026], mem[1025], mem[1024]} = 64'd6;    //6
//    {mem[1031], mem[1030], mem[1029], mem[1028]} = 64'd7;    //7
//    {mem[1035], mem[1034], mem[1033], mem[1032]} = 64'd7;    //8
//    {mem[1039], mem[1038], mem[1037], mem[1036]} = 64'd3;    //9
//    {mem[1043], mem[1042], mem[1041], mem[1040]} = 64'd101;   //10
//    {mem[1047], mem[1046], mem[1045], mem[1044]} = 64'd11;   //11
//    {mem[1051], mem[1050], mem[1049], mem[1048]} = 64'd12;   //12
//    {mem[1055], mem[1054], mem[1053], mem[1052]} = 64'd13;   //13
//    {mem[1059], mem[1058], mem[1057], mem[1056]} = 64'd14;   //14
//    {mem[1063], mem[1062], mem[1061], mem[1060]} = 64'd5;   //15
//    {mem[1067], mem[1066], mem[1065], mem[1064]} = 64'd14;   //16
//    {mem[1071], mem[1070], mem[1069], mem[1068]} = 64'd14;   //17
//    {mem[1075], mem[1074], mem[1073], mem[1072]} = 64'd11;   //18
//    {mem[1079], mem[1078], mem[1077], mem[1076]} = 64'd11;   //19
  $readmemb( "DATA.mem", mem );

  end
  
  
  // The following initial block is for TEST PURPOSE ONLY 
  initial begin
    #3000 $display("The content of mem[2000] = %d", {mem[2003], mem[2002], mem[2001], mem[2000]});
    #50 $display("The content of mem[2004] = %d", {mem[2007], mem[2006], mem[2005], mem[2004]});
 end
 
  always @(posedge clk)
    if (mwr==1'b1)
      {mem[adr+3], mem[adr+2], mem[adr+1], mem[adr]} = d_in;
  
  assign d_out = (mrd==1'b1) ? {mem[adr+3], mem[adr+2], mem[adr+1], mem[adr]} : 64'd0;
  
endmodule   
