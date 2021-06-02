; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve -verify-machineinstrs %s -o - | FileCheck %s

define arm_aapcs_vfpcc <4 x i32> @vqmovni32_smaxmin(<4 x i32> %s0) {
; CHECK-LABEL: vqmovni32_smaxmin:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vqmovnb.s32 q0, q0
; CHECK-NEXT:    vmovlb.s16 q0, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp slt <4 x i32> %s0, <i32 32767, i32 32767, i32 32767, i32 32767>
  %s1 = select <4 x i1> %c1, <4 x i32> %s0, <4 x i32> <i32 32767, i32 32767, i32 32767, i32 32767>
  %c2 = icmp sgt <4 x i32> %s1, <i32 -32768, i32 -32768, i32 -32768, i32 -32768>
  %s2 = select <4 x i1> %c2, <4 x i32> %s1, <4 x i32> <i32 -32768, i32 -32768, i32 -32768, i32 -32768>
  ret <4 x i32> %s2
}

define arm_aapcs_vfpcc <4 x i32> @vqmovni32_sminmax(<4 x i32> %s0) {
; CHECK-LABEL: vqmovni32_sminmax:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vqmovnb.s32 q0, q0
; CHECK-NEXT:    vmovlb.s16 q0, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp sgt <4 x i32> %s0, <i32 -32768, i32 -32768, i32 -32768, i32 -32768>
  %s1 = select <4 x i1> %c1, <4 x i32> %s0, <4 x i32> <i32 -32768, i32 -32768, i32 -32768, i32 -32768>
  %c2 = icmp slt <4 x i32> %s1, <i32 32767, i32 32767, i32 32767, i32 32767>
  %s2 = select <4 x i1> %c2, <4 x i32> %s1, <4 x i32> <i32 32767, i32 32767, i32 32767, i32 32767>
  ret <4 x i32> %s2
}

define arm_aapcs_vfpcc <4 x i32> @vqmovni32_umaxmin(<4 x i32> %s0) {
; CHECK-LABEL: vqmovni32_umaxmin:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vqmovnb.u32 q0, q0
; CHECK-NEXT:    vmovlb.u16 q0, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp ult <4 x i32> %s0, <i32 65535, i32 65535, i32 65535, i32 65535>
  %s1 = select <4 x i1> %c1, <4 x i32> %s0, <4 x i32> <i32 65535, i32 65535, i32 65535, i32 65535>
  ret <4 x i32> %s1
}

define arm_aapcs_vfpcc <4 x i32> @vqmovni32_uminmax(<4 x i32> %s0) {
; CHECK-LABEL: vqmovni32_uminmax:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vqmovnb.u32 q0, q0
; CHECK-NEXT:    vmovlb.u16 q0, q0
; CHECK-NEXT:    bx lr
entry:
  %c2 = icmp ult <4 x i32> %s0, <i32 65535, i32 65535, i32 65535, i32 65535>
  %s2 = select <4 x i1> %c2, <4 x i32> %s0, <4 x i32> <i32 65535, i32 65535, i32 65535, i32 65535>
  ret <4 x i32> %s2
}

define arm_aapcs_vfpcc <8 x i16> @vqmovni16_smaxmin(<8 x i16> %s0) {
; CHECK-LABEL: vqmovni16_smaxmin:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vqmovnb.s16 q0, q0
; CHECK-NEXT:    vmovlb.s8 q0, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp slt <8 x i16> %s0, <i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127>
  %s1 = select <8 x i1> %c1, <8 x i16> %s0, <8 x i16> <i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127>
  %c2 = icmp sgt <8 x i16> %s1, <i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128>
  %s2 = select <8 x i1> %c2, <8 x i16> %s1, <8 x i16> <i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128>
  ret <8 x i16> %s2
}

define arm_aapcs_vfpcc <8 x i16> @vqmovni16_sminmax(<8 x i16> %s0) {
; CHECK-LABEL: vqmovni16_sminmax:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vqmovnb.s16 q0, q0
; CHECK-NEXT:    vmovlb.s8 q0, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp sgt <8 x i16> %s0, <i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128>
  %s1 = select <8 x i1> %c1, <8 x i16> %s0, <8 x i16> <i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128>
  %c2 = icmp slt <8 x i16> %s1, <i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127>
  %s2 = select <8 x i1> %c2, <8 x i16> %s1, <8 x i16> <i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127>
  ret <8 x i16> %s2
}

define arm_aapcs_vfpcc <8 x i16> @vqmovni16_umaxmin(<8 x i16> %s0) {
; CHECK-LABEL: vqmovni16_umaxmin:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vqmovnb.u16 q0, q0
; CHECK-NEXT:    vmovlb.u8 q0, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp ult <8 x i16> %s0, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  %s1 = select <8 x i1> %c1, <8 x i16> %s0, <8 x i16> <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  ret <8 x i16> %s1
}

define arm_aapcs_vfpcc <8 x i16> @vqmovni16_uminmax(<8 x i16> %s0) {
; CHECK-LABEL: vqmovni16_uminmax:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vqmovnb.u16 q0, q0
; CHECK-NEXT:    vmovlb.u8 q0, q0
; CHECK-NEXT:    bx lr
entry:
  %c2 = icmp ult <8 x i16> %s0, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  %s2 = select <8 x i1> %c2, <8 x i16> %s0, <8 x i16> <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  ret <8 x i16> %s2
}

define arm_aapcs_vfpcc <16 x i8> @vqmovni8_smaxmin(<16 x i8> %s0) {
; CHECK-LABEL: vqmovni8_smaxmin:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.i8 q1, #0x7
; CHECK-NEXT:    vmin.s8 q0, q0, q1
; CHECK-NEXT:    vmov.i8 q1, #0xf8
; CHECK-NEXT:    vmax.s8 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp slt <16 x i8> %s0, <i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7>
  %s1 = select <16 x i1> %c1, <16 x i8> %s0, <16 x i8> <i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7>
  %c2 = icmp sgt <16 x i8> %s1, <i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8>
  %s2 = select <16 x i1> %c2, <16 x i8> %s1, <16 x i8> <i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8>
  ret <16 x i8> %s2
}

define arm_aapcs_vfpcc <16 x i8> @vqmovni8_sminmax(<16 x i8> %s0) {
; CHECK-LABEL: vqmovni8_sminmax:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.i8 q1, #0xf8
; CHECK-NEXT:    vmax.s8 q0, q0, q1
; CHECK-NEXT:    vmov.i8 q1, #0x7
; CHECK-NEXT:    vmin.s8 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp sgt <16 x i8> %s0, <i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8>
  %s1 = select <16 x i1> %c1, <16 x i8> %s0, <16 x i8> <i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8, i8 -8>
  %c2 = icmp slt <16 x i8> %s1, <i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7>
  %s2 = select <16 x i1> %c2, <16 x i8> %s1, <16 x i8> <i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7>
  ret <16 x i8> %s2
}

define arm_aapcs_vfpcc <16 x i8> @vqmovni8_umaxmin(<16 x i8> %s0) {
; CHECK-LABEL: vqmovni8_umaxmin:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.i8 q1, #0xf
; CHECK-NEXT:    vmin.u8 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp ult <16 x i8> %s0, <i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15>
  %s1 = select <16 x i1> %c1, <16 x i8> %s0, <16 x i8> <i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15>
  ret <16 x i8> %s1
}

define arm_aapcs_vfpcc <16 x i8> @vqmovni8_uminmax(<16 x i8> %s0) {
; CHECK-LABEL: vqmovni8_uminmax:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.i8 q1, #0xf
; CHECK-NEXT:    vmin.u8 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %c2 = icmp ult <16 x i8> %s0, <i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15>
  %s2 = select <16 x i1> %c2, <16 x i8> %s0, <16 x i8> <i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15, i8 15>
  ret <16 x i8> %s2
}

define arm_aapcs_vfpcc <2 x i64> @vqmovni64_smaxmin(<2 x i64> %s0) {
; CHECK-LABEL: vqmovni64_smaxmin:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov r1, r2, d1
; CHECK-NEXT:    mvn r12, #-2147483648
; CHECK-NEXT:    movs r0, #0
; CHECK-NEXT:    subs.w r1, r1, r12
; CHECK-NEXT:    sbcs r1, r2, #0
; CHECK-NEXT:    vmov r2, r3, d0
; CHECK-NEXT:    mov.w r1, #0
; CHECK-NEXT:    it lt
; CHECK-NEXT:    movlt r1, #1
; CHECK-NEXT:    cmp r1, #0
; CHECK-NEXT:    csetm r1, ne
; CHECK-NEXT:    subs.w r2, r2, r12
; CHECK-NEXT:    mov.w r12, #-1
; CHECK-NEXT:    sbcs r2, r3, #0
; CHECK-NEXT:    mov.w r2, #0
; CHECK-NEXT:    it lt
; CHECK-NEXT:    movlt r2, #1
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    csetm r2, ne
; CHECK-NEXT:    vmov q1[2], q1[0], r2, r1
; CHECK-NEXT:    vmov q1[3], q1[1], r2, r1
; CHECK-NEXT:    adr r1, .LCPI12_0
; CHECK-NEXT:    vldrw.u32 q2, [r1]
; CHECK-NEXT:    vand q0, q0, q1
; CHECK-NEXT:    vbic q2, q2, q1
; CHECK-NEXT:    vorr q0, q0, q2
; CHECK-NEXT:    vmov r1, r2, d1
; CHECK-NEXT:    rsbs.w r1, r1, #-2147483648
; CHECK-NEXT:    sbcs.w r1, r12, r2
; CHECK-NEXT:    vmov r2, r3, d0
; CHECK-NEXT:    mov.w r1, #0
; CHECK-NEXT:    it lt
; CHECK-NEXT:    movlt r1, #1
; CHECK-NEXT:    cmp r1, #0
; CHECK-NEXT:    csetm r1, ne
; CHECK-NEXT:    rsbs.w r2, r2, #-2147483648
; CHECK-NEXT:    sbcs.w r2, r12, r3
; CHECK-NEXT:    it lt
; CHECK-NEXT:    movlt r0, #1
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    csetm r0, ne
; CHECK-NEXT:    vmov q1[2], q1[0], r0, r1
; CHECK-NEXT:    vmov q1[3], q1[1], r0, r1
; CHECK-NEXT:    adr r0, .LCPI12_1
; CHECK-NEXT:    vldrw.u32 q2, [r0]
; CHECK-NEXT:    vand q0, q0, q1
; CHECK-NEXT:    vbic q2, q2, q1
; CHECK-NEXT:    vorr q0, q0, q2
; CHECK-NEXT:    bx lr
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:  .LCPI12_0:
; CHECK-NEXT:    .long 2147483647 @ 0x7fffffff
; CHECK-NEXT:    .long 0 @ 0x0
; CHECK-NEXT:    .long 2147483647 @ 0x7fffffff
; CHECK-NEXT:    .long 0 @ 0x0
; CHECK-NEXT:  .LCPI12_1:
; CHECK-NEXT:    .long 2147483648 @ 0x80000000
; CHECK-NEXT:    .long 4294967295 @ 0xffffffff
; CHECK-NEXT:    .long 2147483648 @ 0x80000000
; CHECK-NEXT:    .long 4294967295 @ 0xffffffff
entry:
  %c1 = icmp slt <2 x i64> %s0, <i64 2147483647, i64 2147483647>
  %s1 = select <2 x i1> %c1, <2 x i64> %s0, <2 x i64> <i64 2147483647, i64 2147483647>
  %c2 = icmp sgt <2 x i64> %s1, <i64 -2147483648, i64 -2147483648>
  %s2 = select <2 x i1> %c2, <2 x i64> %s1, <2 x i64> <i64 -2147483648, i64 -2147483648>
  ret <2 x i64> %s2
}

define arm_aapcs_vfpcc <2 x i64> @vqmovni64_sminmax(<2 x i64> %s0) {
; CHECK-LABEL: vqmovni64_sminmax:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov r1, r2, d1
; CHECK-NEXT:    mov.w r12, #-1
; CHECK-NEXT:    movs r0, #0
; CHECK-NEXT:    rsbs.w r1, r1, #-2147483648
; CHECK-NEXT:    sbcs.w r1, r12, r2
; CHECK-NEXT:    vmov r2, r3, d0
; CHECK-NEXT:    mov.w r1, #0
; CHECK-NEXT:    it lt
; CHECK-NEXT:    movlt r1, #1
; CHECK-NEXT:    cmp r1, #0
; CHECK-NEXT:    csetm r1, ne
; CHECK-NEXT:    rsbs.w r2, r2, #-2147483648
; CHECK-NEXT:    sbcs.w r2, r12, r3
; CHECK-NEXT:    mvn r12, #-2147483648
; CHECK-NEXT:    mov.w r2, #0
; CHECK-NEXT:    it lt
; CHECK-NEXT:    movlt r2, #1
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    csetm r2, ne
; CHECK-NEXT:    vmov q1[2], q1[0], r2, r1
; CHECK-NEXT:    vmov q1[3], q1[1], r2, r1
; CHECK-NEXT:    adr r1, .LCPI13_0
; CHECK-NEXT:    vldrw.u32 q2, [r1]
; CHECK-NEXT:    vand q0, q0, q1
; CHECK-NEXT:    vbic q2, q2, q1
; CHECK-NEXT:    vorr q0, q0, q2
; CHECK-NEXT:    vmov r1, r2, d1
; CHECK-NEXT:    subs.w r1, r1, r12
; CHECK-NEXT:    sbcs r1, r2, #0
; CHECK-NEXT:    vmov r2, r3, d0
; CHECK-NEXT:    mov.w r1, #0
; CHECK-NEXT:    it lt
; CHECK-NEXT:    movlt r1, #1
; CHECK-NEXT:    cmp r1, #0
; CHECK-NEXT:    csetm r1, ne
; CHECK-NEXT:    subs.w r2, r2, r12
; CHECK-NEXT:    sbcs r2, r3, #0
; CHECK-NEXT:    it lt
; CHECK-NEXT:    movlt r0, #1
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    csetm r0, ne
; CHECK-NEXT:    vmov q1[2], q1[0], r0, r1
; CHECK-NEXT:    vmov q1[3], q1[1], r0, r1
; CHECK-NEXT:    adr r0, .LCPI13_1
; CHECK-NEXT:    vldrw.u32 q2, [r0]
; CHECK-NEXT:    vand q0, q0, q1
; CHECK-NEXT:    vbic q2, q2, q1
; CHECK-NEXT:    vorr q0, q0, q2
; CHECK-NEXT:    bx lr
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:  .LCPI13_0:
; CHECK-NEXT:    .long 2147483648 @ 0x80000000
; CHECK-NEXT:    .long 4294967295 @ 0xffffffff
; CHECK-NEXT:    .long 2147483648 @ 0x80000000
; CHECK-NEXT:    .long 4294967295 @ 0xffffffff
; CHECK-NEXT:  .LCPI13_1:
; CHECK-NEXT:    .long 2147483647 @ 0x7fffffff
; CHECK-NEXT:    .long 0 @ 0x0
; CHECK-NEXT:    .long 2147483647 @ 0x7fffffff
; CHECK-NEXT:    .long 0 @ 0x0
entry:
  %c1 = icmp sgt <2 x i64> %s0, <i64 -2147483648, i64 -2147483648>
  %s1 = select <2 x i1> %c1, <2 x i64> %s0, <2 x i64> <i64 -2147483648, i64 -2147483648>
  %c2 = icmp slt <2 x i64> %s1, <i64 2147483647, i64 2147483647>
  %s2 = select <2 x i1> %c2, <2 x i64> %s1, <2 x i64> <i64 2147483647, i64 2147483647>
  ret <2 x i64> %s2
}

define arm_aapcs_vfpcc <2 x i64> @vqmovni64_umaxmin(<2 x i64> %s0) {
; CHECK-LABEL: vqmovni64_umaxmin:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov r0, r1, d1
; CHECK-NEXT:    movs r2, #0
; CHECK-NEXT:    vmov.i64 q2, #0xffffffff
; CHECK-NEXT:    subs.w r0, r0, #-1
; CHECK-NEXT:    sbcs r0, r1, #0
; CHECK-NEXT:    vmov r1, r3, d0
; CHECK-NEXT:    mov.w r0, #0
; CHECK-NEXT:    it lo
; CHECK-NEXT:    movlo r0, #1
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    csetm r0, ne
; CHECK-NEXT:    subs.w r1, r1, #-1
; CHECK-NEXT:    sbcs r1, r3, #0
; CHECK-NEXT:    it lo
; CHECK-NEXT:    movlo r2, #1
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    csetm r1, ne
; CHECK-NEXT:    vmov q1[2], q1[0], r1, r0
; CHECK-NEXT:    vmov q1[3], q1[1], r1, r0
; CHECK-NEXT:    vbic q2, q2, q1
; CHECK-NEXT:    vand q0, q0, q1
; CHECK-NEXT:    vorr q0, q0, q2
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp ult <2 x i64> %s0, <i64 4294967295, i64 4294967295>
  %s1 = select <2 x i1> %c1, <2 x i64> %s0, <2 x i64> <i64 4294967295, i64 4294967295>
  ret <2 x i64> %s1
}

define arm_aapcs_vfpcc <2 x i64> @vqmovni64_uminmax(<2 x i64> %s0) {
; CHECK-LABEL: vqmovni64_uminmax:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov r0, r1, d1
; CHECK-NEXT:    movs r2, #0
; CHECK-NEXT:    vmov.i64 q2, #0xffffffff
; CHECK-NEXT:    subs.w r0, r0, #-1
; CHECK-NEXT:    sbcs r0, r1, #0
; CHECK-NEXT:    vmov r1, r3, d0
; CHECK-NEXT:    mov.w r0, #0
; CHECK-NEXT:    it lo
; CHECK-NEXT:    movlo r0, #1
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    csetm r0, ne
; CHECK-NEXT:    subs.w r1, r1, #-1
; CHECK-NEXT:    sbcs r1, r3, #0
; CHECK-NEXT:    it lo
; CHECK-NEXT:    movlo r2, #1
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    csetm r1, ne
; CHECK-NEXT:    vmov q1[2], q1[0], r1, r0
; CHECK-NEXT:    vmov q1[3], q1[1], r1, r0
; CHECK-NEXT:    vbic q2, q2, q1
; CHECK-NEXT:    vand q0, q0, q1
; CHECK-NEXT:    vorr q0, q0, q2
; CHECK-NEXT:    bx lr
entry:
  %c2 = icmp ult <2 x i64> %s0, <i64 4294967295, i64 4294967295>
  %s2 = select <2 x i1> %c2, <2 x i64> %s0, <2 x i64> <i64 4294967295, i64 4294967295>
  ret <2 x i64> %s2
}
