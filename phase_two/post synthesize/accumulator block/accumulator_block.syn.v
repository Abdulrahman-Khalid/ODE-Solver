/*
 * Created by 
   ../bin/Linux-x86_64-O/oasysGui 19.2-p002 on Sat Apr 25 18:01:28 2020
 * (C) Mentor Graphics Corporation
 */
/* CheckSum: 2895413119 */

module \reg (load, a, clk, clr, b);
   input load;
   input [15:0]a;
   input clk;
   input clr;
   output [15:0]b;

   CLKGATETST_X1 clk_gate_b_reg (.CK(clk), .E(load), .SE(1'b0), .GCK(n_0));
   DFFR_X1 \b_reg[15]  (.D(a[15]), .RN(n_1), .CK(n_0), .Q(b[15]), .QN());
   INV_X1 i_0_0 (.A(clr), .ZN(n_1));
   DFFR_X1 \b_reg[14]  (.D(a[14]), .RN(n_1), .CK(n_0), .Q(b[14]), .QN());
   DFFR_X1 \b_reg[13]  (.D(a[13]), .RN(n_1), .CK(n_0), .Q(b[13]), .QN());
   DFFR_X1 \b_reg[12]  (.D(a[12]), .RN(n_1), .CK(n_0), .Q(b[12]), .QN());
   DFFR_X1 \b_reg[11]  (.D(a[11]), .RN(n_1), .CK(n_0), .Q(b[11]), .QN());
   DFFR_X1 \b_reg[10]  (.D(a[10]), .RN(n_1), .CK(n_0), .Q(b[10]), .QN());
   DFFR_X1 \b_reg[9]  (.D(a[9]), .RN(n_1), .CK(n_0), .Q(b[9]), .QN());
   DFFR_X1 \b_reg[8]  (.D(a[8]), .RN(n_1), .CK(n_0), .Q(b[8]), .QN());
   DFFR_X1 \b_reg[7]  (.D(a[7]), .RN(n_1), .CK(n_0), .Q(b[7]), .QN());
   DFFR_X1 \b_reg[6]  (.D(a[6]), .RN(n_1), .CK(n_0), .Q(b[6]), .QN());
   DFFR_X1 \b_reg[5]  (.D(a[5]), .RN(n_1), .CK(n_0), .Q(b[5]), .QN());
   DFFR_X1 \b_reg[4]  (.D(a[4]), .RN(n_1), .CK(n_0), .Q(b[4]), .QN());
   DFFR_X1 \b_reg[3]  (.D(a[3]), .RN(n_1), .CK(n_0), .Q(b[3]), .QN());
   DFFR_X1 \b_reg[2]  (.D(a[2]), .RN(n_1), .CK(n_0), .Q(b[2]), .QN());
   DFFR_X1 \b_reg[1]  (.D(a[1]), .RN(n_1), .CK(n_0), .Q(b[1]), .QN());
   DFFR_X1 \b_reg[0]  (.D(a[0]), .RN(n_1), .CK(n_0), .Q(b[0]), .QN());
endmodule

module Partial_Full_Adder__0_164(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_1_0 (.A(A), .B(Cin), .Z(S));
endmodule

module Partial_Full_Adder__0_160(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_1_0 (.A(A), .B(Cin), .Z(S));
endmodule

module Partial_Full_Adder__0_156(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_1_0 (.A(A), .B(Cin), .Z(S));
endmodule

module Partial_Full_Adder__0_152(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_1_0 (.A(A), .B(Cin), .Z(S));
endmodule

module Partial_Full_Adder__0_148(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_1_0 (.A(A), .B(Cin), .Z(S));
endmodule

module Partial_Full_Adder__0_144(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_1_0 (.A(A), .B(Cin), .Z(S));
endmodule

module Partial_Full_Adder__0_140(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_1_0 (.A(A), .B(Cin), .Z(S));
endmodule

module Partial_Full_Adder__0_136(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_1_0 (.A(A), .B(Cin), .Z(S));
endmodule

module Partial_Full_Adder__0_132(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_1_0 (.A(A), .B(Cin), .Z(S));
endmodule

module Partial_Full_Adder__0_128(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_1_0 (.A(A), .B(Cin), .Z(S));
endmodule

module Partial_Full_Adder__0_124(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_1_0 (.A(A), .B(Cin), .Z(S));
endmodule

module Partial_Full_Adder__0_120(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_1_0 (.A(A), .B(Cin), .Z(S));
endmodule

module Partial_Full_Adder__0_116(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_1_0 (.A(A), .B(Cin), .Z(S));
endmodule

module Partial_Full_Adder__0_112(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_1_0 (.A(A), .B(Cin), .Z(S));
endmodule

module Partial_Full_Adder__0_108(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_1_0 (.A(A), .B(Cin), .Z(S));
endmodule

module Carry_Look_Ahead_generic__0_180(A, B, Cin, S, overFlow);
   input [15:0]A;
   input [15:0]B;
   input Cin;
   output [15:0]S;
   output overFlow;

   wire c;

   Partial_Full_Adder__0_164 GEN_FULL_ADDERS_15_FULL_ADDER_INST (.A(A[15]), 
      .B(), .Cin(c), .S(S[15]), .P(), .G());
   Partial_Full_Adder__0_160 GEN_FULL_ADDERS_14_FULL_ADDER_INST (.A(A[14]), 
      .B(), .Cin(n_0), .S(S[14]), .P(), .G());
   Partial_Full_Adder__0_156 GEN_FULL_ADDERS_13_FULL_ADDER_INST (.A(A[13]), 
      .B(), .Cin(n_1), .S(S[13]), .P(), .G());
   Partial_Full_Adder__0_152 GEN_FULL_ADDERS_12_FULL_ADDER_INST (.A(A[12]), 
      .B(), .Cin(n_2), .S(S[12]), .P(), .G());
   Partial_Full_Adder__0_148 GEN_FULL_ADDERS_11_FULL_ADDER_INST (.A(A[11]), 
      .B(), .Cin(n_3), .S(S[11]), .P(), .G());
   Partial_Full_Adder__0_144 GEN_FULL_ADDERS_10_FULL_ADDER_INST (.A(A[10]), 
      .B(), .Cin(n_4), .S(S[10]), .P(), .G());
   Partial_Full_Adder__0_140 GEN_FULL_ADDERS_9_FULL_ADDER_INST (.A(A[9]), .B(), 
      .Cin(n_5), .S(S[9]), .P(), .G());
   Partial_Full_Adder__0_136 GEN_FULL_ADDERS_8_FULL_ADDER_INST (.A(A[8]), .B(), 
      .Cin(n_6), .S(S[8]), .P(), .G());
   Partial_Full_Adder__0_132 GEN_FULL_ADDERS_7_FULL_ADDER_INST (.A(A[7]), .B(), 
      .Cin(n_7), .S(S[7]), .P(), .G());
   Partial_Full_Adder__0_128 GEN_FULL_ADDERS_6_FULL_ADDER_INST (.A(A[6]), .B(), 
      .Cin(n_8), .S(S[6]), .P(), .G());
   Partial_Full_Adder__0_124 GEN_FULL_ADDERS_5_FULL_ADDER_INST (.A(A[5]), .B(), 
      .Cin(n_9), .S(S[5]), .P(), .G());
   Partial_Full_Adder__0_120 GEN_FULL_ADDERS_4_FULL_ADDER_INST (.A(A[4]), .B(), 
      .Cin(n_10), .S(S[4]), .P(), .G());
   Partial_Full_Adder__0_116 GEN_FULL_ADDERS_3_FULL_ADDER_INST (.A(A[3]), .B(), 
      .Cin(n_11), .S(S[3]), .P(), .G());
   Partial_Full_Adder__0_112 GEN_FULL_ADDERS_2_FULL_ADDER_INST (.A(A[2]), .B(), 
      .Cin(n_12), .S(S[2]), .P(), .G());
   Partial_Full_Adder__0_108 GEN_FULL_ADDERS_1_FULL_ADDER_INST (.A(A[1]), .B(), 
      .Cin(A[0]), .S(S[1]), .P(), .G());
   AND2_X1 i_0_0 (.A1(A[14]), .A2(n_0), .ZN(c));
   AND2_X1 i_0_1 (.A1(A[13]), .A2(n_1), .ZN(n_0));
   AND2_X1 i_0_2 (.A1(A[12]), .A2(n_2), .ZN(n_1));
   AND2_X1 i_0_3 (.A1(A[11]), .A2(n_3), .ZN(n_2));
   AND2_X1 i_0_4 (.A1(A[10]), .A2(n_4), .ZN(n_3));
   AND2_X1 i_0_5 (.A1(A[9]), .A2(n_5), .ZN(n_4));
   AND2_X1 i_0_6 (.A1(A[8]), .A2(n_6), .ZN(n_5));
   AND2_X1 i_0_7 (.A1(A[7]), .A2(n_7), .ZN(n_6));
   AND2_X1 i_0_8 (.A1(A[6]), .A2(n_8), .ZN(n_7));
   AND2_X1 i_0_9 (.A1(A[5]), .A2(n_9), .ZN(n_8));
   AND2_X1 i_0_10 (.A1(A[4]), .A2(n_10), .ZN(n_9));
   AND2_X1 i_0_11 (.A1(A[3]), .A2(n_11), .ZN(n_10));
   AND2_X1 i_0_12 (.A1(A[2]), .A2(n_12), .ZN(n_11));
   AND2_X1 i_0_13 (.A1(A[0]), .A2(A[1]), .ZN(n_12));
endmodule

module Partial_Full_Adder__0_247(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_243(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_239(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_235(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_231(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_227(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_223(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_219(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_215(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_211(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_207(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_203(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_199(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_195(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_191(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_187(A, B, Cin, S, P, G);
   input A;
   input B;
   input Cin;
   output S;
   output P;
   output G;

   XOR2_X1 i_0_0 (.A(A), .B(B), .Z(S));
   AND2_X1 i_0_1 (.A1(A), .A2(B), .ZN(G));
endmodule

module Carry_Look_Ahead_generic__0_263(A, B, Cin, S, overFlow);
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
   wire c;

   Partial_Full_Adder__0_247 GEN_FULL_ADDERS_15_FULL_ADDER_INST (.A(A[15]), 
      .B(B[15]), .Cin(c), .S(S[15]), .P(), .G());
   Partial_Full_Adder__0_243 GEN_FULL_ADDERS_14_FULL_ADDER_INST (.A(A[14]), 
      .B(B[14]), .Cin(n_39), .S(S[14]), .P(P), .G(G));
   Partial_Full_Adder__0_239 GEN_FULL_ADDERS_13_FULL_ADDER_INST (.A(A[13]), 
      .B(B[13]), .Cin(n_38), .S(S[13]), .P(n_1), .G(n_0));
   Partial_Full_Adder__0_235 GEN_FULL_ADDERS_12_FULL_ADDER_INST (.A(A[12]), 
      .B(B[12]), .Cin(n_37), .S(S[12]), .P(n_3), .G(n_2));
   Partial_Full_Adder__0_231 GEN_FULL_ADDERS_11_FULL_ADDER_INST (.A(A[11]), 
      .B(B[11]), .Cin(n_36), .S(S[11]), .P(n_5), .G(n_4));
   Partial_Full_Adder__0_227 GEN_FULL_ADDERS_10_FULL_ADDER_INST (.A(A[10]), 
      .B(B[10]), .Cin(n_35), .S(S[10]), .P(n_7), .G(n_6));
   Partial_Full_Adder__0_223 GEN_FULL_ADDERS_9_FULL_ADDER_INST (.A(A[9]), 
      .B(B[9]), .Cin(n_34), .S(S[9]), .P(n_9), .G(n_8));
   Partial_Full_Adder__0_219 GEN_FULL_ADDERS_8_FULL_ADDER_INST (.A(A[8]), 
      .B(B[8]), .Cin(n_33), .S(S[8]), .P(n_11), .G(n_10));
   Partial_Full_Adder__0_215 GEN_FULL_ADDERS_7_FULL_ADDER_INST (.A(A[7]), 
      .B(B[7]), .Cin(n_32), .S(S[7]), .P(n_13), .G(n_12));
   Partial_Full_Adder__0_211 GEN_FULL_ADDERS_6_FULL_ADDER_INST (.A(A[6]), 
      .B(B[6]), .Cin(n_31), .S(S[6]), .P(n_15), .G(n_14));
   Partial_Full_Adder__0_207 GEN_FULL_ADDERS_5_FULL_ADDER_INST (.A(A[5]), 
      .B(B[5]), .Cin(n_30), .S(S[5]), .P(n_17), .G(n_16));
   Partial_Full_Adder__0_203 GEN_FULL_ADDERS_4_FULL_ADDER_INST (.A(A[4]), 
      .B(B[4]), .Cin(n_29), .S(S[4]), .P(n_19), .G(n_18));
   Partial_Full_Adder__0_199 GEN_FULL_ADDERS_3_FULL_ADDER_INST (.A(A[3]), 
      .B(B[3]), .Cin(n_28), .S(S[3]), .P(n_21), .G(n_20));
   Partial_Full_Adder__0_195 GEN_FULL_ADDERS_2_FULL_ADDER_INST (.A(A[2]), 
      .B(B[2]), .Cin(n_27), .S(S[2]), .P(n_23), .G(n_22));
   Partial_Full_Adder__0_191 GEN_FULL_ADDERS_1_FULL_ADDER_INST (.A(A[1]), 
      .B(B[1]), .Cin(n_26), .S(S[1]), .P(n_25), .G(n_24));
   Partial_Full_Adder__0_187 GEN_FULL_ADDERS_0_FULL_ADDER_INST (.A(A[0]), 
      .B(B[0]), .Cin(), .S(S[0]), .P(), .G(n_26));
   AOI21_X1 i_0_0 (.A(n_24), .B1(n_25), .B2(n_26), .ZN(n_0_0));
   INV_X1 i_0_1 (.A(n_0_0), .ZN(n_27));
   AOI21_X1 i_0_2 (.A(n_22), .B1(n_23), .B2(n_27), .ZN(n_0_1));
   INV_X1 i_0_3 (.A(n_0_1), .ZN(n_28));
   AOI21_X1 i_0_4 (.A(n_20), .B1(n_21), .B2(n_28), .ZN(n_0_2));
   INV_X1 i_0_5 (.A(n_0_2), .ZN(n_29));
   AOI21_X1 i_0_6 (.A(n_18), .B1(n_19), .B2(n_29), .ZN(n_0_3));
   INV_X1 i_0_7 (.A(n_0_3), .ZN(n_30));
   AOI21_X1 i_0_8 (.A(n_16), .B1(n_17), .B2(n_30), .ZN(n_0_4));
   INV_X1 i_0_9 (.A(n_0_4), .ZN(n_31));
   AOI21_X1 i_0_10 (.A(n_14), .B1(n_15), .B2(n_31), .ZN(n_0_5));
   INV_X1 i_0_11 (.A(n_0_5), .ZN(n_32));
   AOI21_X1 i_0_12 (.A(n_12), .B1(n_13), .B2(n_32), .ZN(n_0_6));
   INV_X1 i_0_13 (.A(n_0_6), .ZN(n_33));
   AOI21_X1 i_0_14 (.A(n_10), .B1(n_11), .B2(n_33), .ZN(n_0_7));
   INV_X1 i_0_15 (.A(n_0_7), .ZN(n_34));
   AOI21_X1 i_0_16 (.A(n_8), .B1(n_9), .B2(n_34), .ZN(n_0_8));
   INV_X1 i_0_17 (.A(n_0_8), .ZN(n_35));
   AOI21_X1 i_0_18 (.A(n_6), .B1(n_7), .B2(n_35), .ZN(n_0_9));
   INV_X1 i_0_19 (.A(n_0_9), .ZN(n_36));
   AOI21_X1 i_0_20 (.A(n_4), .B1(n_5), .B2(n_36), .ZN(n_0_10));
   INV_X1 i_0_21 (.A(n_0_10), .ZN(n_37));
   AOI21_X1 i_0_22 (.A(n_2), .B1(n_3), .B2(n_37), .ZN(n_0_11));
   INV_X1 i_0_23 (.A(n_0_11), .ZN(n_38));
   AOI21_X1 i_0_24 (.A(n_0), .B1(n_1), .B2(n_38), .ZN(n_0_12));
   INV_X1 i_0_25 (.A(n_0_12), .ZN(n_39));
   AOI21_X1 i_0_26 (.A(G), .B1(P), .B2(n_39), .ZN(n_0_13));
   INV_X1 i_0_27 (.A(n_0_13), .ZN(c));
endmodule

module Partial_Full_Adder__0_41(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_45(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_49(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_53(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_57(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_61(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_65(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_69(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_73(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_77(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_81(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_85(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_89(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_93(A, B, Cin, S, P, G);
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

module Partial_Full_Adder__0_97(A, B, Cin, S, P, G);
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

   XOR2_X1 i_0_0 (.A(A), .B(B), .Z(S));
   AND2_X1 i_0_1 (.A1(A), .A2(B), .ZN(G));
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
   wire n_1_0;
   wire n_1_1;
   wire n_1_2;
   wire n_1_3;
   wire n_1_4;
   wire n_1_5;
   wire n_1_6;
   wire n_1_7;
   wire n_1_8;
   wire n_1_9;
   wire n_1_10;
   wire n_1_11;
   wire n_1_12;
   wire n_1_13;
   wire c;

   Partial_Full_Adder__0_41 GEN_FULL_ADDERS_15_FULL_ADDER_INST (.A(A[15]), 
      .B(B[15]), .Cin(c), .S(S[15]), .P(), .G());
   Partial_Full_Adder__0_45 GEN_FULL_ADDERS_14_FULL_ADDER_INST (.A(A[14]), 
      .B(B[14]), .Cin(n_39), .S(S[14]), .P(P), .G(G));
   Partial_Full_Adder__0_49 GEN_FULL_ADDERS_13_FULL_ADDER_INST (.A(A[13]), 
      .B(B[13]), .Cin(n_38), .S(S[13]), .P(n_1), .G(n_0));
   Partial_Full_Adder__0_53 GEN_FULL_ADDERS_12_FULL_ADDER_INST (.A(A[12]), 
      .B(B[12]), .Cin(n_37), .S(S[12]), .P(n_3), .G(n_2));
   Partial_Full_Adder__0_57 GEN_FULL_ADDERS_11_FULL_ADDER_INST (.A(A[11]), 
      .B(B[11]), .Cin(n_36), .S(S[11]), .P(n_5), .G(n_4));
   Partial_Full_Adder__0_61 GEN_FULL_ADDERS_10_FULL_ADDER_INST (.A(A[10]), 
      .B(B[10]), .Cin(n_35), .S(S[10]), .P(n_7), .G(n_6));
   Partial_Full_Adder__0_65 GEN_FULL_ADDERS_9_FULL_ADDER_INST (.A(A[9]), 
      .B(B[9]), .Cin(n_34), .S(S[9]), .P(n_9), .G(n_8));
   Partial_Full_Adder__0_69 GEN_FULL_ADDERS_8_FULL_ADDER_INST (.A(A[8]), 
      .B(B[8]), .Cin(n_33), .S(S[8]), .P(n_11), .G(n_10));
   Partial_Full_Adder__0_73 GEN_FULL_ADDERS_7_FULL_ADDER_INST (.A(A[7]), 
      .B(B[7]), .Cin(n_32), .S(S[7]), .P(n_13), .G(n_12));
   Partial_Full_Adder__0_77 GEN_FULL_ADDERS_6_FULL_ADDER_INST (.A(A[6]), 
      .B(B[6]), .Cin(n_31), .S(S[6]), .P(n_15), .G(n_14));
   Partial_Full_Adder__0_81 GEN_FULL_ADDERS_5_FULL_ADDER_INST (.A(A[5]), 
      .B(B[5]), .Cin(n_30), .S(S[5]), .P(n_17), .G(n_16));
   Partial_Full_Adder__0_85 GEN_FULL_ADDERS_4_FULL_ADDER_INST (.A(A[4]), 
      .B(B[4]), .Cin(n_29), .S(S[4]), .P(n_19), .G(n_18));
   Partial_Full_Adder__0_89 GEN_FULL_ADDERS_3_FULL_ADDER_INST (.A(A[3]), 
      .B(B[3]), .Cin(n_28), .S(S[3]), .P(n_21), .G(n_20));
   Partial_Full_Adder__0_93 GEN_FULL_ADDERS_2_FULL_ADDER_INST (.A(A[2]), 
      .B(B[2]), .Cin(n_27), .S(S[2]), .P(n_23), .G(n_22));
   Partial_Full_Adder__0_97 GEN_FULL_ADDERS_1_FULL_ADDER_INST (.A(A[1]), 
      .B(B[1]), .Cin(n_26), .S(S[1]), .P(n_25), .G(n_24));
   Partial_Full_Adder GEN_FULL_ADDERS_0_FULL_ADDER_INST (.A(A[0]), .B(B[0]), 
      .Cin(), .S(S[0]), .P(), .G(n_26));
   OAI22_X1 i_0_0 (.A1(B[15]), .A2(n_0_1), .B1(n_0_0), .B2(S[15]), .ZN(overFlow));
   NAND2_X1 i_0_1 (.A1(A[15]), .A2(B[15]), .ZN(n_0_0));
   NAND2_X1 i_0_2 (.A1(n_0_2), .A2(S[15]), .ZN(n_0_1));
   INV_X1 i_0_3 (.A(A[15]), .ZN(n_0_2));
   AOI21_X1 i_1_0 (.A(n_24), .B1(n_25), .B2(n_26), .ZN(n_1_0));
   INV_X1 i_1_1 (.A(n_1_0), .ZN(n_27));
   AOI21_X1 i_1_2 (.A(n_22), .B1(n_23), .B2(n_27), .ZN(n_1_1));
   INV_X1 i_1_3 (.A(n_1_1), .ZN(n_28));
   AOI21_X1 i_1_4 (.A(n_20), .B1(n_21), .B2(n_28), .ZN(n_1_2));
   INV_X1 i_1_5 (.A(n_1_2), .ZN(n_29));
   AOI21_X1 i_1_6 (.A(n_18), .B1(n_19), .B2(n_29), .ZN(n_1_3));
   INV_X1 i_1_7 (.A(n_1_3), .ZN(n_30));
   AOI21_X1 i_1_8 (.A(n_16), .B1(n_17), .B2(n_30), .ZN(n_1_4));
   INV_X1 i_1_9 (.A(n_1_4), .ZN(n_31));
   AOI21_X1 i_1_10 (.A(n_14), .B1(n_15), .B2(n_31), .ZN(n_1_5));
   INV_X1 i_1_11 (.A(n_1_5), .ZN(n_32));
   AOI21_X1 i_1_12 (.A(n_12), .B1(n_13), .B2(n_32), .ZN(n_1_6));
   INV_X1 i_1_13 (.A(n_1_6), .ZN(n_33));
   AOI21_X1 i_1_14 (.A(n_10), .B1(n_11), .B2(n_33), .ZN(n_1_7));
   INV_X1 i_1_15 (.A(n_1_7), .ZN(n_34));
   AOI21_X1 i_1_16 (.A(n_8), .B1(n_9), .B2(n_34), .ZN(n_1_8));
   INV_X1 i_1_17 (.A(n_1_8), .ZN(n_35));
   AOI21_X1 i_1_18 (.A(n_6), .B1(n_7), .B2(n_35), .ZN(n_1_9));
   INV_X1 i_1_19 (.A(n_1_9), .ZN(n_36));
   AOI21_X1 i_1_20 (.A(n_4), .B1(n_5), .B2(n_36), .ZN(n_1_10));
   INV_X1 i_1_21 (.A(n_1_10), .ZN(n_37));
   AOI21_X1 i_1_22 (.A(n_2), .B1(n_3), .B2(n_37), .ZN(n_1_11));
   INV_X1 i_1_23 (.A(n_1_11), .ZN(n_38));
   AOI21_X1 i_1_24 (.A(n_0), .B1(n_1), .B2(n_38), .ZN(n_1_12));
   INV_X1 i_1_25 (.A(n_1_12), .ZN(n_39));
   AOI21_X1 i_1_26 (.A(G), .B1(P), .B2(n_39), .ZN(n_1_13));
   INV_X1 i_1_27 (.A(n_1_13), .ZN(c));
endmodule

module accumulator_block(x, y, S, clr, clk, load, overFlow_out_error);
   input [15:0]x;
   input [15:0]y;
   output [15:0]S;
   input clr;
   input clk;
   input load;
   output overFlow_out_error;

   wire [15:0]b;
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
   wire n_0_28;
   wire n_0_29;
   wire n_0_30;
   wire n_0_0;
   wire [15:0]abs_diff;
   wire n_0_0_0;
   wire n_0_0_1;
   wire n_0_0_2;
   wire n_0_0_3;
   wire n_0_0_4;
   wire n_0_0_5;
   wire n_0_0_6;
   wire n_0_0_7;
   wire n_0_0_8;
   wire n_0_0_9;
   wire n_0_0_10;
   wire n_0_0_11;
   wire n_0_0_12;
   wire n_0_0_13;
   wire n_0_0_14;
   wire n_0_0_15;
   wire n_0_0_16;
   wire n_0_0_17;
   wire n_0_0_18;
   wire n_0_0_19;
   wire n_0_0_20;
   wire n_0_0_21;
   wire [15:0]y_not;
   wire n_0_0_22;

   \reg  put_final_value_in_latch (.load(load), .a(S), .clk(clk), .clr(clr), 
      .b(b));
   Carry_Look_Ahead_generic__0_180 find_difference (.A(y_not), .B(), .Cin(), 
      .S({n_0_15, n_0_14, n_0_13, n_0_12, n_0_11, n_0_10, n_0_9, n_0_8, n_0_7, 
      n_0_6, n_0_5, n_0_4, n_0_3, n_0_2, n_0_1, uc_0}), .overFlow());
   Carry_Look_Ahead_generic__0_263 twos_complement (.A(x), .B({n_0_15, n_0_14, 
      n_0_13, n_0_12, n_0_11, n_0_10, n_0_9, n_0_8, n_0_7, n_0_6, n_0_5, n_0_4, 
      n_0_3, n_0_2, n_0_1, y[0]}), .Cin(), .S({n_0_0, n_0_30, n_0_29, n_0_28, 
      n_0_27, n_0_26, n_0_25, n_0_24, n_0_23, n_0_22, n_0_21, n_0_20, n_0_19, 
      n_0_18, n_0_17, n_0_16}), .overFlow());
   Carry_Look_Ahead_generic add_latch_data_with_new_diff (.A(b), .B({
      abs_diff[15], abs_diff[14], abs_diff[13], abs_diff[12], abs_diff[11], 
      abs_diff[10], abs_diff[9], abs_diff[8], abs_diff[7], abs_diff[6], 
      abs_diff[5], abs_diff[4], abs_diff[3], abs_diff[2], abs_diff[1], n_0_16}), 
      .Cin(), .S(S), .overFlow(overFlow_out_error));
   XNOR2_X1 i_0_0_0 (.A(n_0_17), .B(n_0_0_0), .ZN(abs_diff[1]));
   NAND2_X1 i_0_0_1 (.A1(n_0_0), .A2(n_0_16), .ZN(n_0_0_0));
   XNOR2_X1 i_0_0_2 (.A(n_0_18), .B(n_0_0_1), .ZN(abs_diff[2]));
   NAND2_X1 i_0_0_3 (.A1(n_0_0_21), .A2(n_0_0), .ZN(n_0_0_1));
   XNOR2_X1 i_0_0_4 (.A(n_0_19), .B(n_0_0_2), .ZN(abs_diff[3]));
   NAND2_X1 i_0_0_5 (.A1(n_0_0_20), .A2(n_0_0), .ZN(n_0_0_2));
   XNOR2_X1 i_0_0_6 (.A(n_0_20), .B(n_0_0_3), .ZN(abs_diff[4]));
   OAI21_X1 i_0_0_7 (.A(n_0_0), .B1(n_0_0_20), .B2(n_0_19), .ZN(n_0_0_3));
   XNOR2_X1 i_0_0_8 (.A(n_0_21), .B(n_0_0_4), .ZN(abs_diff[5]));
   NAND2_X1 i_0_0_9 (.A1(n_0_0_19), .A2(n_0_0), .ZN(n_0_0_4));
   XNOR2_X1 i_0_0_10 (.A(n_0_22), .B(n_0_0_5), .ZN(abs_diff[6]));
   NAND2_X1 i_0_0_11 (.A1(n_0_0_18), .A2(n_0_0), .ZN(n_0_0_5));
   XNOR2_X1 i_0_0_12 (.A(n_0_23), .B(n_0_0_6), .ZN(abs_diff[7]));
   OAI21_X1 i_0_0_13 (.A(n_0_0), .B1(n_0_0_18), .B2(n_0_22), .ZN(n_0_0_6));
   XNOR2_X1 i_0_0_14 (.A(n_0_24), .B(n_0_0_7), .ZN(abs_diff[8]));
   NAND2_X1 i_0_0_15 (.A1(n_0_0_17), .A2(n_0_0), .ZN(n_0_0_7));
   XNOR2_X1 i_0_0_16 (.A(n_0_25), .B(n_0_0_8), .ZN(abs_diff[9]));
   NAND2_X1 i_0_0_17 (.A1(n_0_0_16), .A2(n_0_0), .ZN(n_0_0_8));
   XNOR2_X1 i_0_0_18 (.A(n_0_26), .B(n_0_0_9), .ZN(abs_diff[10]));
   OAI21_X1 i_0_0_19 (.A(n_0_0), .B1(n_0_0_16), .B2(n_0_25), .ZN(n_0_0_9));
   XNOR2_X1 i_0_0_20 (.A(n_0_27), .B(n_0_0_10), .ZN(abs_diff[11]));
   NAND2_X1 i_0_0_21 (.A1(n_0_0_15), .A2(n_0_0), .ZN(n_0_0_10));
   XNOR2_X1 i_0_0_22 (.A(n_0_28), .B(n_0_0_11), .ZN(abs_diff[12]));
   OAI21_X1 i_0_0_23 (.A(n_0_0), .B1(n_0_0_15), .B2(n_0_27), .ZN(n_0_0_11));
   XNOR2_X1 i_0_0_24 (.A(n_0_29), .B(n_0_0_12), .ZN(abs_diff[13]));
   NAND2_X1 i_0_0_25 (.A1(n_0_0_14), .A2(n_0_0), .ZN(n_0_0_12));
   XNOR2_X1 i_0_0_26 (.A(n_0_30), .B(n_0_0_13), .ZN(abs_diff[14]));
   OAI21_X1 i_0_0_27 (.A(n_0_0), .B1(n_0_0_14), .B2(n_0_29), .ZN(n_0_0_13));
   NOR4_X1 i_0_0_28 (.A1(n_0_30), .A2(n_0_0_14), .A3(n_0_29), .A4(n_0_0_22), 
      .ZN(abs_diff[15]));
   OR3_X1 i_0_0_29 (.A1(n_0_0_15), .A2(n_0_27), .A3(n_0_28), .ZN(n_0_0_14));
   OR3_X1 i_0_0_30 (.A1(n_0_0_16), .A2(n_0_25), .A3(n_0_26), .ZN(n_0_0_15));
   OR2_X1 i_0_0_31 (.A1(n_0_0_17), .A2(n_0_24), .ZN(n_0_0_16));
   OR3_X1 i_0_0_32 (.A1(n_0_0_18), .A2(n_0_22), .A3(n_0_23), .ZN(n_0_0_17));
   OR2_X1 i_0_0_33 (.A1(n_0_0_19), .A2(n_0_21), .ZN(n_0_0_18));
   OR3_X1 i_0_0_34 (.A1(n_0_0_20), .A2(n_0_19), .A3(n_0_20), .ZN(n_0_0_19));
   OR2_X1 i_0_0_35 (.A1(n_0_0_21), .A2(n_0_18), .ZN(n_0_0_20));
   OR2_X1 i_0_0_36 (.A1(n_0_17), .A2(n_0_16), .ZN(n_0_0_21));
   INV_X1 i_0_0_37 (.A(y[0]), .ZN(y_not[0]));
   INV_X1 i_0_0_38 (.A(y[1]), .ZN(y_not[1]));
   INV_X1 i_0_0_39 (.A(y[2]), .ZN(y_not[2]));
   INV_X1 i_0_0_40 (.A(y[3]), .ZN(y_not[3]));
   INV_X1 i_0_0_41 (.A(y[4]), .ZN(y_not[4]));
   INV_X1 i_0_0_42 (.A(y[5]), .ZN(y_not[5]));
   INV_X1 i_0_0_43 (.A(y[6]), .ZN(y_not[6]));
   INV_X1 i_0_0_44 (.A(y[7]), .ZN(y_not[7]));
   INV_X1 i_0_0_45 (.A(y[8]), .ZN(y_not[8]));
   INV_X1 i_0_0_46 (.A(y[9]), .ZN(y_not[9]));
   INV_X1 i_0_0_47 (.A(y[10]), .ZN(y_not[10]));
   INV_X1 i_0_0_48 (.A(y[11]), .ZN(y_not[11]));
   INV_X1 i_0_0_49 (.A(y[12]), .ZN(y_not[12]));
   INV_X1 i_0_0_50 (.A(y[13]), .ZN(y_not[13]));
   INV_X1 i_0_0_51 (.A(y[14]), .ZN(y_not[14]));
   INV_X1 i_0_0_52 (.A(y[15]), .ZN(y_not[15]));
   INV_X1 i_0_0_53 (.A(n_0_0), .ZN(n_0_0_22));
endmodule
