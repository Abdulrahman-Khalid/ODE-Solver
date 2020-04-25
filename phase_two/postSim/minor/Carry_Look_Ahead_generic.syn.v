/*
 * Created by 
   ../bin/Linux-x86_64-O/oasysGui 19.2-p002 on Sat Apr 25 18:10:44 2020
 * (C) Mentor Graphics Corporation
 */
/* CheckSum: 4131661078 */

module Partial_Full_Adder__0_23(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   wire n_0_0;

   XOR2_X1 i_0_0 (.A(A), .B(B), .Z(n_0_0));
   XOR2_X1 i_0_1 (.A(n_0_0), .B(Cin), .Z(S));
endmodule

module Partial_Full_Adder__0_27(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_0_0 (.A(A), .B(B), .Z(P));
   XOR2_X1 i_0_1 (.A(P), .B(Cin), .Z(S));
   AND2_X1 i_0_2 (.A1(A), .A2(B), .ZN(G));
endmodule

module Partial_Full_Adder__0_31(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_0_0 (.A(A), .B(B), .Z(P));
   XOR2_X1 i_0_1 (.A(P), .B(Cin), .Z(S));
   AND2_X1 i_0_2 (.A1(A), .A2(B), .ZN(G));
endmodule

module Partial_Full_Adder__0_35(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_0_0 (.A(A), .B(B), .Z(P));
   XOR2_X1 i_0_1 (.A(P), .B(Cin), .Z(S));
   AND2_X1 i_0_2 (.A1(A), .A2(B), .ZN(G));
endmodule

module Partial_Full_Adder__0_39(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_0_0 (.A(A), .B(B), .Z(P));
   XOR2_X1 i_0_1 (.A(P), .B(Cin), .Z(S));
   AND2_X1 i_0_2 (.A1(A), .A2(B), .ZN(G));
endmodule

module Partial_Full_Adder__0_43(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_0_0 (.A(A), .B(B), .Z(P));
   XOR2_X1 i_0_1 (.A(P), .B(Cin), .Z(S));
   AND2_X1 i_0_2 (.A1(A), .A2(B), .ZN(G));
endmodule

module Partial_Full_Adder__0_47(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_0_0 (.A(A), .B(B), .Z(P));
   XOR2_X1 i_0_1 (.A(P), .B(Cin), .Z(S));
   AND2_X1 i_0_2 (.A1(A), .A2(B), .ZN(G));
endmodule

module Partial_Full_Adder__0_51(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_0_0 (.A(A), .B(B), .Z(P));
   XOR2_X1 i_0_1 (.A(P), .B(Cin), .Z(S));
   AND2_X1 i_0_2 (.A1(A), .A2(B), .ZN(G));
endmodule

module Partial_Full_Adder__0_55(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_0_0 (.A(A), .B(B), .Z(P));
   XOR2_X1 i_0_1 (.A(P), .B(Cin), .Z(S));
   AND2_X1 i_0_2 (.A1(A), .A2(B), .ZN(G));
endmodule

module Partial_Full_Adder__0_59(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_0_0 (.A(A), .B(B), .Z(P));
   XOR2_X1 i_0_1 (.A(P), .B(Cin), .Z(S));
   AND2_X1 i_0_2 (.A1(A), .A2(B), .ZN(G));
endmodule

module Partial_Full_Adder__0_63(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_0_0 (.A(A), .B(B), .Z(P));
   XOR2_X1 i_0_1 (.A(P), .B(Cin), .Z(S));
   AND2_X1 i_0_2 (.A1(A), .A2(B), .ZN(G));
endmodule

module Partial_Full_Adder__0_67(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_0_0 (.A(A), .B(B), .Z(P));
   XOR2_X1 i_0_1 (.A(P), .B(Cin), .Z(S));
   AND2_X1 i_0_2 (.A1(A), .A2(B), .ZN(G));
endmodule

module Partial_Full_Adder__0_71(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_0_0 (.A(A), .B(B), .Z(P));
   XOR2_X1 i_0_1 (.A(P), .B(Cin), .Z(S));
   AND2_X1 i_0_2 (.A1(A), .A2(B), .ZN(G));
endmodule

module Partial_Full_Adder__0_75(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_0_0 (.A(A), .B(B), .Z(P));
   XOR2_X1 i_0_1 (.A(P), .B(Cin), .Z(S));
   AND2_X1 i_0_2 (.A1(A), .A2(B), .ZN(G));
endmodule

module Partial_Full_Adder__0_79(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_0_0 (.A(A), .B(B), .Z(P));
   XOR2_X1 i_0_1 (.A(P), .B(Cin), .Z(S));
   AND2_X1 i_0_2 (.A1(A), .A2(B), .ZN(G));
endmodule

module Partial_Full_Adder(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_0_0 (.A(A), .B(B), .Z(P));
   XOR2_X1 i_0_1 (.A(P), .B(Cin), .Z(S));
   AND2_X1 i_0_2 (.A1(A), .A2(B), .ZN(G));
endmodule

module Carry_Look_Ahead_generic(A, B, Cin, S, overFlow);
   input [15:0]A;
   input [15:0]B;
   input Cin;
   output [15:0]S;
   output overFlow;

   wire G;
   wire P;
   wire n_0_0;
   wire n_0_1;
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
   wire n_0_0_0;
   wire n_0_0_1;
   wire n_0_0_2;
   wire n_0_1_0;
   wire n_0_41;
   wire n_0_1_1;
   wire n_0_40;
   wire n_0_1_2;
   wire n_0_39;
   wire n_0_1_3;
   wire n_0_38;
   wire n_0_1_4;
   wire n_0_37;
   wire n_0_1_5;
   wire n_0_36;
   wire n_0_1_6;
   wire n_0_35;
   wire n_0_1_7;
   wire n_0_34;
   wire n_0_1_8;
   wire n_0_33;
   wire n_0_1_9;
   wire n_0_32;
   wire n_0_1_10;
   wire n_0_31;
   wire n_0_1_11;
   wire n_0_30;
   wire n_0_1_12;
   wire n_0_29;
   wire n_0_1_13;
   wire n_0_28;
   wire n_0_1_14;
   wire c;

   Partial_Full_Adder__0_23 GEN_FULL_ADDERS_15_FULL_ADDER_INST (.A(A[15]), 
      .B(B[15]), .Cin(c), .S(S[15]), .P(), .G());
   Partial_Full_Adder__0_27 GEN_FULL_ADDERS_14_FULL_ADDER_INST (.A(A[14]), 
      .B(B[14]), .Cin(n_0_28), .S(S[14]), .P(P), .G(G));
   Partial_Full_Adder__0_31 GEN_FULL_ADDERS_13_FULL_ADDER_INST (.A(A[13]), 
      .B(B[13]), .Cin(n_0_29), .S(S[13]), .P(n_0_1), .G(n_0_0));
   Partial_Full_Adder__0_35 GEN_FULL_ADDERS_12_FULL_ADDER_INST (.A(A[12]), 
      .B(B[12]), .Cin(n_0_30), .S(S[12]), .P(n_0_3), .G(n_0_2));
   Partial_Full_Adder__0_39 GEN_FULL_ADDERS_11_FULL_ADDER_INST (.A(A[11]), 
      .B(B[11]), .Cin(n_0_31), .S(S[11]), .P(n_0_5), .G(n_0_4));
   Partial_Full_Adder__0_43 GEN_FULL_ADDERS_10_FULL_ADDER_INST (.A(A[10]), 
      .B(B[10]), .Cin(n_0_32), .S(S[10]), .P(n_0_7), .G(n_0_6));
   Partial_Full_Adder__0_47 GEN_FULL_ADDERS_9_FULL_ADDER_INST (.A(A[9]), 
      .B(B[9]), .Cin(n_0_33), .S(S[9]), .P(n_0_9), .G(n_0_8));
   Partial_Full_Adder__0_51 GEN_FULL_ADDERS_8_FULL_ADDER_INST (.A(A[8]), 
      .B(B[8]), .Cin(n_0_34), .S(S[8]), .P(n_0_11), .G(n_0_10));
   Partial_Full_Adder__0_55 GEN_FULL_ADDERS_7_FULL_ADDER_INST (.A(A[7]), 
      .B(B[7]), .Cin(n_0_35), .S(S[7]), .P(n_0_13), .G(n_0_12));
   Partial_Full_Adder__0_59 GEN_FULL_ADDERS_6_FULL_ADDER_INST (.A(A[6]), 
      .B(B[6]), .Cin(n_0_36), .S(S[6]), .P(n_0_15), .G(n_0_14));
   Partial_Full_Adder__0_63 GEN_FULL_ADDERS_5_FULL_ADDER_INST (.A(A[5]), 
      .B(B[5]), .Cin(n_0_37), .S(S[5]), .P(n_0_17), .G(n_0_16));
   Partial_Full_Adder__0_67 GEN_FULL_ADDERS_4_FULL_ADDER_INST (.A(A[4]), 
      .B(B[4]), .Cin(n_0_38), .S(S[4]), .P(n_0_19), .G(n_0_18));
   Partial_Full_Adder__0_71 GEN_FULL_ADDERS_3_FULL_ADDER_INST (.A(A[3]), 
      .B(B[3]), .Cin(n_0_39), .S(S[3]), .P(n_0_21), .G(n_0_20));
   Partial_Full_Adder__0_75 GEN_FULL_ADDERS_2_FULL_ADDER_INST (.A(A[2]), 
      .B(B[2]), .Cin(n_0_40), .S(S[2]), .P(n_0_23), .G(n_0_22));
   Partial_Full_Adder__0_79 GEN_FULL_ADDERS_1_FULL_ADDER_INST (.A(A[1]), 
      .B(B[1]), .Cin(n_0_41), .S(S[1]), .P(n_0_25), .G(n_0_24));
   Partial_Full_Adder GEN_FULL_ADDERS_0_FULL_ADDER_INST (.A(A[0]), .B(B[0]), 
      .Cin(Cin), .S(S[0]), .P(n_0_27), .G(n_0_26));
   OAI22_X1 i_0_0_0 (.A1(B[15]), .A2(n_0_0_1), .B1(n_0_0_0), .B2(S[15]), 
      .ZN(overFlow));
   NAND2_X1 i_0_0_1 (.A1(A[15]), .A2(B[15]), .ZN(n_0_0_0));
   NAND2_X1 i_0_0_2 (.A1(n_0_0_2), .A2(S[15]), .ZN(n_0_0_1));
   INV_X1 i_0_0_3 (.A(A[15]), .ZN(n_0_0_2));
   AOI21_X1 i_0_1_0 (.A(n_0_26), .B1(n_0_27), .B2(Cin), .ZN(n_0_1_0));
   INV_X1 i_0_1_1 (.A(n_0_1_0), .ZN(n_0_41));
   AOI21_X1 i_0_1_2 (.A(n_0_24), .B1(n_0_25), .B2(n_0_41), .ZN(n_0_1_1));
   INV_X1 i_0_1_3 (.A(n_0_1_1), .ZN(n_0_40));
   AOI21_X1 i_0_1_4 (.A(n_0_22), .B1(n_0_23), .B2(n_0_40), .ZN(n_0_1_2));
   INV_X1 i_0_1_5 (.A(n_0_1_2), .ZN(n_0_39));
   AOI21_X1 i_0_1_6 (.A(n_0_20), .B1(n_0_21), .B2(n_0_39), .ZN(n_0_1_3));
   INV_X1 i_0_1_7 (.A(n_0_1_3), .ZN(n_0_38));
   AOI21_X1 i_0_1_8 (.A(n_0_18), .B1(n_0_19), .B2(n_0_38), .ZN(n_0_1_4));
   INV_X1 i_0_1_9 (.A(n_0_1_4), .ZN(n_0_37));
   AOI21_X1 i_0_1_10 (.A(n_0_16), .B1(n_0_17), .B2(n_0_37), .ZN(n_0_1_5));
   INV_X1 i_0_1_11 (.A(n_0_1_5), .ZN(n_0_36));
   AOI21_X1 i_0_1_12 (.A(n_0_14), .B1(n_0_15), .B2(n_0_36), .ZN(n_0_1_6));
   INV_X1 i_0_1_13 (.A(n_0_1_6), .ZN(n_0_35));
   AOI21_X1 i_0_1_14 (.A(n_0_12), .B1(n_0_13), .B2(n_0_35), .ZN(n_0_1_7));
   INV_X1 i_0_1_15 (.A(n_0_1_7), .ZN(n_0_34));
   AOI21_X1 i_0_1_16 (.A(n_0_10), .B1(n_0_11), .B2(n_0_34), .ZN(n_0_1_8));
   INV_X1 i_0_1_17 (.A(n_0_1_8), .ZN(n_0_33));
   AOI21_X1 i_0_1_18 (.A(n_0_8), .B1(n_0_9), .B2(n_0_33), .ZN(n_0_1_9));
   INV_X1 i_0_1_19 (.A(n_0_1_9), .ZN(n_0_32));
   AOI21_X1 i_0_1_20 (.A(n_0_6), .B1(n_0_7), .B2(n_0_32), .ZN(n_0_1_10));
   INV_X1 i_0_1_21 (.A(n_0_1_10), .ZN(n_0_31));
   AOI21_X1 i_0_1_22 (.A(n_0_4), .B1(n_0_5), .B2(n_0_31), .ZN(n_0_1_11));
   INV_X1 i_0_1_23 (.A(n_0_1_11), .ZN(n_0_30));
   AOI21_X1 i_0_1_24 (.A(n_0_2), .B1(n_0_3), .B2(n_0_30), .ZN(n_0_1_12));
   INV_X1 i_0_1_25 (.A(n_0_1_12), .ZN(n_0_29));
   AOI21_X1 i_0_1_26 (.A(n_0_0), .B1(n_0_1), .B2(n_0_29), .ZN(n_0_1_13));
   INV_X1 i_0_1_27 (.A(n_0_1_13), .ZN(n_0_28));
   AOI21_X1 i_0_1_28 (.A(G), .B1(P), .B2(n_0_28), .ZN(n_0_1_14));
   INV_X1 i_0_1_29 (.A(n_0_1_14), .ZN(c));
endmodule
