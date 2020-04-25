/*
 * Created by 
   ../bin/Linux-x86_64-O/oasysGui 19.2-p002 on Sat Apr 25 19:43:31 2020
 * (C) Mentor Graphics Corporation
 */
/* CheckSum: 114094907 */

module FullAdder__0_51(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   wire n_0_0;
   wire n_0_1;
   wire n_0_2;

   NAND2_X1 i_0_0 (.A1(n_0_2), .A2(n_0_0), .ZN(Co));
   OAI21_X1 i_0_1 (.A(in2), .B1(Ci), .B2(in1), .ZN(n_0_0));
   XNOR2_X1 i_0_2 (.A(in2), .B(n_0_1), .ZN(S));
   XNOR2_X1 i_0_3 (.A(Ci), .B(in1), .ZN(n_0_1));
   NAND2_X1 i_0_4 (.A1(Ci), .A2(in1), .ZN(n_0_2));
endmodule

module FullAdder__0_54(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XNOR2_X1 i_0_1 (.A(in1), .B(in2), .ZN(S));
endmodule

module FullAdder__0_57(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XOR2_X1 i_0_0 (.A(in2), .B(in1), .Z(S));
endmodule

module FullAdder__0_60(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XNOR2_X1 i_0_0 (.A(in2), .B(in1), .ZN(S));
   OR2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_63(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XOR2_X1 i_0_0 (.A(in1), .B(in2), .Z(S));
   AND2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_66(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XNOR2_X1 i_0_0 (.A(in2), .B(in1), .ZN(S));
   OR2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_69(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XOR2_X1 i_0_0 (.A(in1), .B(in2), .Z(S));
   AND2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_72(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XNOR2_X1 i_0_0 (.A(in2), .B(in1), .ZN(S));
   OR2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_75(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XOR2_X1 i_0_0 (.A(in1), .B(in2), .Z(S));
   AND2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_78(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XNOR2_X1 i_0_0 (.A(in2), .B(in1), .ZN(S));
   OR2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_81(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XOR2_X1 i_0_0 (.A(in1), .B(in2), .Z(S));
   AND2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_84(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XNOR2_X1 i_0_0 (.A(in2), .B(in1), .ZN(S));
   OR2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_87(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XOR2_X1 i_0_0 (.A(in1), .B(in2), .Z(S));
   AND2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_90(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XNOR2_X1 i_0_0 (.A(in2), .B(in1), .ZN(S));
   OR2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_93(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XOR2_X1 i_0_0 (.A(in1), .B(in2), .Z(S));
   AND2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_96(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XNOR2_X1 i_0_0 (.A(in2), .B(in1), .ZN(S));
   OR2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_99(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XOR2_X1 i_0_0 (.A(in1), .B(in2), .Z(S));
   AND2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_102(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XNOR2_X1 i_0_0 (.A(in2), .B(in1), .ZN(S));
   OR2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_105(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XOR2_X1 i_0_0 (.A(in1), .B(in2), .Z(S));
   AND2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_108(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XNOR2_X1 i_0_0 (.A(in2), .B(in1), .ZN(S));
   OR2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_111(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XOR2_X1 i_0_0 (.A(in1), .B(in2), .Z(S));
   AND2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_114(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XNOR2_X1 i_0_0 (.A(in2), .B(in1), .ZN(S));
   OR2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_117(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XOR2_X1 i_0_0 (.A(in1), .B(in2), .Z(S));
   AND2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_120(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XNOR2_X1 i_0_0 (.A(in2), .B(in1), .ZN(S));
   OR2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_123(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XOR2_X1 i_0_0 (.A(in1), .B(in2), .Z(S));
   AND2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_126(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XNOR2_X1 i_0_0 (.A(in2), .B(in1), .ZN(S));
   OR2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_129(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XOR2_X1 i_0_0 (.A(in1), .B(in2), .Z(S));
   AND2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_132(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XNOR2_X1 i_0_0 (.A(in2), .B(in1), .ZN(S));
   OR2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_135(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XOR2_X1 i_0_0 (.A(in1), .B(in2), .Z(S));
   AND2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder__0_138(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XNOR2_X1 i_0_0 (.A(in2), .B(in1), .ZN(S));
   OR2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module FullAdder(in1, in2, Ci, S, Co);
   input in1;
   input in2;
   input Ci;
   output S;
   output Co;

   XOR2_X1 i_0_0 (.A(in1), .B(in2), .Z(S));
   AND2_X1 i_0_1 (.A1(in2), .A2(in1), .ZN(Co));
endmodule

module mux__0_9(sel, in1, in2, i1, i2, out1, Carry);
   input sel;
   input in1;
   input in2;
   input i1;
   input i2;
   output out1;
   output Carry;

   MUX2_X1 i_0_0 (.A(i1), .B(i2), .S(sel), .Z(Carry));
   MUX2_X1 i_0_1 (.A(in1), .B(in2), .S(sel), .Z(out1));
endmodule

module mux__0_12(sel, in1, in2, i1, i2, out1, Carry);
   input sel;
   input in1;
   input in2;
   input i1;
   input i2;
   output out1;
   output Carry;

   MUX2_X1 i_0_0 (.A(i1), .B(i2), .S(sel), .Z(Carry));
   MUX2_X1 i_0_1 (.A(in1), .B(in2), .S(sel), .Z(out1));
endmodule

module mux__0_15(sel, in1, in2, i1, i2, out1, Carry);
   input sel;
   input in1;
   input in2;
   input i1;
   input i2;
   output out1;
   output Carry;

   MUX2_X1 i_0_0 (.A(i1), .B(i2), .S(sel), .Z(Carry));
   MUX2_X1 i_0_1 (.A(in1), .B(in2), .S(sel), .Z(out1));
endmodule

module mux__0_18(sel, in1, in2, i1, i2, out1, Carry);
   input sel;
   input in1;
   input in2;
   input i1;
   input i2;
   output out1;
   output Carry;

   MUX2_X1 i_0_0 (.A(i1), .B(i2), .S(sel), .Z(Carry));
   MUX2_X1 i_0_1 (.A(in1), .B(in2), .S(sel), .Z(out1));
endmodule

module mux__0_21(sel, in1, in2, i1, i2, out1, Carry);
   input sel;
   input in1;
   input in2;
   input i1;
   input i2;
   output out1;
   output Carry;

   MUX2_X1 i_0_0 (.A(i1), .B(i2), .S(sel), .Z(Carry));
   MUX2_X1 i_0_1 (.A(in1), .B(in2), .S(sel), .Z(out1));
endmodule

module mux__0_24(sel, in1, in2, i1, i2, out1, Carry);
   input sel;
   input in1;
   input in2;
   input i1;
   input i2;
   output out1;
   output Carry;

   MUX2_X1 i_0_0 (.A(i1), .B(i2), .S(sel), .Z(Carry));
   MUX2_X1 i_0_1 (.A(in1), .B(in2), .S(sel), .Z(out1));
endmodule

module mux__0_27(sel, in1, in2, i1, i2, out1, Carry);
   input sel;
   input in1;
   input in2;
   input i1;
   input i2;
   output out1;
   output Carry;

   MUX2_X1 i_0_0 (.A(i1), .B(i2), .S(sel), .Z(Carry));
   MUX2_X1 i_0_1 (.A(in1), .B(in2), .S(sel), .Z(out1));
endmodule

module mux__0_30(sel, in1, in2, i1, i2, out1, Carry);
   input sel;
   input in1;
   input in2;
   input i1;
   input i2;
   output out1;
   output Carry;

   MUX2_X1 i_0_0 (.A(i1), .B(i2), .S(sel), .Z(Carry));
   MUX2_X1 i_0_1 (.A(in1), .B(in2), .S(sel), .Z(out1));
endmodule

module mux__0_33(sel, in1, in2, i1, i2, out1, Carry);
   input sel;
   input in1;
   input in2;
   input i1;
   input i2;
   output out1;
   output Carry;

   MUX2_X1 i_0_0 (.A(i1), .B(i2), .S(sel), .Z(Carry));
   MUX2_X1 i_0_1 (.A(in1), .B(in2), .S(sel), .Z(out1));
endmodule

module mux__0_36(sel, in1, in2, i1, i2, out1, Carry);
   input sel;
   input in1;
   input in2;
   input i1;
   input i2;
   output out1;
   output Carry;

   MUX2_X1 i_0_0 (.A(i1), .B(i2), .S(sel), .Z(Carry));
   MUX2_X1 i_0_1 (.A(in1), .B(in2), .S(sel), .Z(out1));
endmodule

module mux__0_39(sel, in1, in2, i1, i2, out1, Carry);
   input sel;
   input in1;
   input in2;
   input i1;
   input i2;
   output out1;
   output Carry;

   MUX2_X1 i_0_0 (.A(i1), .B(i2), .S(sel), .Z(Carry));
   MUX2_X1 i_0_1 (.A(in1), .B(in2), .S(sel), .Z(out1));
endmodule

module mux__0_42(sel, in1, in2, i1, i2, out1, Carry);
   input sel;
   input in1;
   input in2;
   input i1;
   input i2;
   output out1;
   output Carry;

   MUX2_X1 i_0_0 (.A(i1), .B(i2), .S(sel), .Z(Carry));
   MUX2_X1 i_0_1 (.A(in1), .B(in2), .S(sel), .Z(out1));
endmodule

module mux__0_45(sel, in1, in2, i1, i2, out1, Carry);
   input sel;
   input in1;
   input in2;
   input i1;
   input i2;
   output out1;
   output Carry;

   MUX2_X1 i_0_0 (.A(i1), .B(i2), .S(sel), .Z(Carry));
   MUX2_X1 i_0_1 (.A(in1), .B(in2), .S(sel), .Z(out1));
endmodule

module mux__0_48(sel, in1, in2, i1, i2, out1, Carry);
   input sel;
   input in1;
   input in2;
   input i1;
   input i2;
   output out1;
   output Carry;

   MUX2_X1 i_0_0 (.A(i1), .B(i2), .S(sel), .Z(Carry));
   MUX2_X1 i_0_1 (.A(in1), .B(in2), .S(sel), .Z(out1));
endmodule

module mux(sel, in1, in2, i1, i2, out1, Carry);
   input sel;
   input in1;
   input in2;
   input i1;
   input i2;
   output out1;
   output Carry;

   MUX2_X1 i_1_0 (.A(in1), .B(in2), .S(sel), .Z(out1));
endmodule

module Addition1(A, B, Cin, sum, overFlow);
   input [15:0]A;
   input [15:0]B;
   input Cin;
   output [15:0]sum;
   output overFlow;

   wire n_0_0;
   wire S;
   wire n_0_2;
   wire n_0_3;
   wire n_0_4;
   wire n_0_5;
   wire n_0_6;
   wire n_0_7;
   wire n_0_8;
   wire n_0_9;
   wire n_0_10;
   wire n_0_11;
   wire n_0_12;
   wire n_0_13;
   wire n_0_14;
   wire n_0_15;
   wire n_0_16;
   wire n_0_17;
   wire n_0_18;
   wire n_0_19;
   wire n_0_20;
   wire n_0_21;
   wire n_0_22;
   wire n_0_23;
   wire n_0_24;
   wire n_0_25;
   wire n_0_26;
   wire n_0_27;
   wire n_0_28;
   wire n_0_29;
   wire n_0_30;
   wire n_0_31;
   wire n_0_32;
   wire n_0_33;
   wire n_0_34;
   wire n_0_35;
   wire n_0_36;
   wire n_0_37;
   wire n_0_38;
   wire n_0_39;
   wire n_0_40;
   wire n_0_41;
   wire n_0_42;
   wire n_0_43;
   wire n_0_44;
   wire n_0_45;
   wire n_0_46;
   wire n_0_47;
   wire n_0_48;
   wire n_0_49;
   wire n_0_50;
   wire n_0_51;
   wire n_0_52;
   wire n_0_53;
   wire n_0_54;
   wire n_0_55;
   wire n_0_56;
   wire n_0_57;
   wire n_0_58;
   wire n_0_59;
   wire n_0_60;
   wire n_0_61;
   wire n_0_62;
   wire n_0_63;
   wire n_0_64;
   wire n_0_65;
   wire n_0_66;
   wire n_0_67;
   wire n_0_68;
   wire n_0_69;
   wire n_0_70;
   wire n_0_1;
   wire Carry;
   wire n_0_0_0;
   wire n_0_0_1;
   wire n_0_0_2;
   wire n_0_0_3;

   FullAdder__0_51 FA0 (.in1(A[0]), .in2(B[0]), .Ci(Cin), .S(sum[0]), .Co(n_0_0));
   FullAdder__0_54 FA_15_FA1_i (.in1(A[15]), .in2(B[15]), .Ci(), .S(S), .Co());
   FullAdder__0_57 FA_15_FA0_i (.in1(A[15]), .in2(B[15]), .Ci(), .S(n_0_2), 
      .Co());
   FullAdder__0_60 FA_14_FA1_i (.in1(A[14]), .in2(B[14]), .Ci(), .S(n_0_4), 
      .Co(n_0_3));
   FullAdder__0_63 FA_14_FA0_i (.in1(A[14]), .in2(B[14]), .Ci(), .S(n_0_6), 
      .Co(n_0_5));
   FullAdder__0_66 FA_13_FA1_i (.in1(A[13]), .in2(B[13]), .Ci(), .S(n_0_8), 
      .Co(n_0_7));
   FullAdder__0_69 FA_13_FA0_i (.in1(A[13]), .in2(B[13]), .Ci(), .S(n_0_10), 
      .Co(n_0_9));
   FullAdder__0_72 FA_12_FA1_i (.in1(A[12]), .in2(B[12]), .Ci(), .S(n_0_12), 
      .Co(n_0_11));
   FullAdder__0_75 FA_12_FA0_i (.in1(A[12]), .in2(B[12]), .Ci(), .S(n_0_14), 
      .Co(n_0_13));
   FullAdder__0_78 FA_11_FA1_i (.in1(A[11]), .in2(B[11]), .Ci(), .S(n_0_16), 
      .Co(n_0_15));
   FullAdder__0_81 FA_11_FA0_i (.in1(A[11]), .in2(B[11]), .Ci(), .S(n_0_18), 
      .Co(n_0_17));
   FullAdder__0_84 FA_10_FA1_i (.in1(A[10]), .in2(B[10]), .Ci(), .S(n_0_20), 
      .Co(n_0_19));
   FullAdder__0_87 FA_10_FA0_i (.in1(A[10]), .in2(B[10]), .Ci(), .S(n_0_22), 
      .Co(n_0_21));
   FullAdder__0_90 FA_9_FA1_i (.in1(A[9]), .in2(B[9]), .Ci(), .S(n_0_24), 
      .Co(n_0_23));
   FullAdder__0_93 FA_9_FA0_i (.in1(A[9]), .in2(B[9]), .Ci(), .S(n_0_26), 
      .Co(n_0_25));
   FullAdder__0_96 FA_8_FA1_i (.in1(A[8]), .in2(B[8]), .Ci(), .S(n_0_28), 
      .Co(n_0_27));
   FullAdder__0_99 FA_8_FA0_i (.in1(A[8]), .in2(B[8]), .Ci(), .S(n_0_30), 
      .Co(n_0_29));
   FullAdder__0_102 FA_7_FA1_i (.in1(A[7]), .in2(B[7]), .Ci(), .S(n_0_32), 
      .Co(n_0_31));
   FullAdder__0_105 FA_7_FA0_i (.in1(A[7]), .in2(B[7]), .Ci(), .S(n_0_34), 
      .Co(n_0_33));
   FullAdder__0_108 FA_6_FA1_i (.in1(A[6]), .in2(B[6]), .Ci(), .S(n_0_36), 
      .Co(n_0_35));
   FullAdder__0_111 FA_6_FA0_i (.in1(A[6]), .in2(B[6]), .Ci(), .S(n_0_38), 
      .Co(n_0_37));
   FullAdder__0_114 FA_5_FA1_i (.in1(A[5]), .in2(B[5]), .Ci(), .S(n_0_40), 
      .Co(n_0_39));
   FullAdder__0_117 FA_5_FA0_i (.in1(A[5]), .in2(B[5]), .Ci(), .S(n_0_42), 
      .Co(n_0_41));
   FullAdder__0_120 FA_4_FA1_i (.in1(A[4]), .in2(B[4]), .Ci(), .S(n_0_44), 
      .Co(n_0_43));
   FullAdder__0_123 FA_4_FA0_i (.in1(A[4]), .in2(B[4]), .Ci(), .S(n_0_46), 
      .Co(n_0_45));
   FullAdder__0_126 FA_3_FA1_i (.in1(A[3]), .in2(B[3]), .Ci(), .S(n_0_48), 
      .Co(n_0_47));
   FullAdder__0_129 FA_3_FA0_i (.in1(A[3]), .in2(B[3]), .Ci(), .S(n_0_50), 
      .Co(n_0_49));
   FullAdder__0_132 FA_2_FA1_i (.in1(A[2]), .in2(B[2]), .Ci(), .S(n_0_52), 
      .Co(n_0_51));
   FullAdder__0_135 FA_2_FA0_i (.in1(A[2]), .in2(B[2]), .Ci(), .S(n_0_54), 
      .Co(n_0_53));
   FullAdder__0_138 FA_1_FA1_i (.in1(A[1]), .in2(B[1]), .Ci(), .S(n_0_56), 
      .Co(n_0_55));
   FullAdder FA_1_FA0_i (.in1(A[1]), .in2(B[1]), .Ci(), .S(n_0_58), .Co(n_0_57));
   mux__0_9 muxx_1_muxx_j (.sel(n_0_0), .in1(n_0_58), .in2(n_0_56), .i1(n_0_57), 
      .i2(n_0_55), .out1(sum[1]), .Carry(n_0_59));
   mux__0_12 muxx_2_muxx_j (.sel(n_0_59), .in1(n_0_54), .in2(n_0_52), .i1(n_0_53), 
      .i2(n_0_51), .out1(sum[2]), .Carry(n_0_60));
   mux__0_15 muxx_3_muxx_j (.sel(n_0_60), .in1(n_0_50), .in2(n_0_48), .i1(n_0_49), 
      .i2(n_0_47), .out1(sum[3]), .Carry(n_0_61));
   mux__0_18 muxx_4_muxx_j (.sel(n_0_61), .in1(n_0_46), .in2(n_0_44), .i1(n_0_45), 
      .i2(n_0_43), .out1(sum[4]), .Carry(n_0_62));
   mux__0_21 muxx_5_muxx_j (.sel(n_0_62), .in1(n_0_42), .in2(n_0_40), .i1(n_0_41), 
      .i2(n_0_39), .out1(sum[5]), .Carry(n_0_63));
   mux__0_24 muxx_6_muxx_j (.sel(n_0_63), .in1(n_0_38), .in2(n_0_36), .i1(n_0_37), 
      .i2(n_0_35), .out1(sum[6]), .Carry(n_0_64));
   mux__0_27 muxx_7_muxx_j (.sel(n_0_64), .in1(n_0_34), .in2(n_0_32), .i1(n_0_33), 
      .i2(n_0_31), .out1(sum[7]), .Carry(n_0_65));
   mux__0_30 muxx_8_muxx_j (.sel(n_0_65), .in1(n_0_30), .in2(n_0_28), .i1(n_0_29), 
      .i2(n_0_27), .out1(sum[8]), .Carry(n_0_66));
   mux__0_33 muxx_9_muxx_j (.sel(n_0_66), .in1(n_0_26), .in2(n_0_24), .i1(n_0_25), 
      .i2(n_0_23), .out1(sum[9]), .Carry(n_0_67));
   mux__0_36 muxx_10_muxx_j (.sel(n_0_67), .in1(n_0_22), .in2(n_0_20), .i1(
      n_0_21), .i2(n_0_19), .out1(sum[10]), .Carry(n_0_68));
   mux__0_39 muxx_11_muxx_j (.sel(n_0_68), .in1(n_0_18), .in2(n_0_16), .i1(
      n_0_17), .i2(n_0_15), .out1(sum[11]), .Carry(n_0_69));
   mux__0_42 muxx_12_muxx_j (.sel(n_0_69), .in1(n_0_14), .in2(n_0_12), .i1(
      n_0_13), .i2(n_0_11), .out1(sum[12]), .Carry(n_0_70));
   mux__0_45 muxx_13_muxx_j (.sel(n_0_70), .in1(n_0_10), .in2(n_0_8), .i1(n_0_9), 
      .i2(n_0_7), .out1(sum[13]), .Carry(n_0_1));
   mux__0_48 muxx_14_muxx_j (.sel(n_0_1), .in1(n_0_6), .in2(n_0_4), .i1(n_0_5), 
      .i2(n_0_3), .out1(sum[14]), .Carry(Carry));
   mux muxx_15_muxx_j (.sel(Carry), .in1(n_0_2), .in2(S), .i1(), .i2(), .out1(
      sum[15]), .Carry());
   NAND2_X1 i_0_0_0 (.A1(n_0_0_1), .A2(n_0_0_0), .ZN(overFlow));
   NAND3_X1 i_0_0_1 (.A1(A[15]), .A2(B[15]), .A3(n_0_0_2), .ZN(n_0_0_0));
   OR3_X1 i_0_0_2 (.A1(A[15]), .A2(B[15]), .A3(n_0_0_2), .ZN(n_0_0_1));
   AOI22_X1 i_0_0_3 (.A1(S), .A2(Carry), .B1(n_0_2), .B2(n_0_0_3), .ZN(n_0_0_2));
   INV_X1 i_0_0_4 (.A(Carry), .ZN(n_0_0_3));
endmodule
