; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-eabi -mattr=+fullfp16 %s -o - | FileCheck %s

; The llvm.aarch64_neon_rbit intrinsic should be auto-upgraded to the
; target-independent bitreverse intrinsic.

declare <8 x i8> @llvm.aarch64.neon.rbit.v8i8(<8 x i8>) nounwind readnone

define <8 x i8> @rbit_8x8(<8 x i8> %A) nounwind {
; CHECK-LABEL: rbit_8x8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rbit v0.8b, v0.8b
; CHECK-NEXT:    ret
    %tmp3 = call <8 x i8> @llvm.aarch64.neon.rbit.v8i8(<8 x i8> %A)
	ret <8 x i8> %tmp3
}

declare <16 x i8> @llvm.aarch64.neon.rbit.v16i8(<16 x i8>) nounwind readnone

define <16 x i8> @rbit_16x8(<16 x i8> %A) nounwind {
; CHECK-LABEL: rbit_16x8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rbit v0.16b, v0.16b
; CHECK-NEXT:    ret
    %tmp3 = call <16 x i8> @llvm.aarch64.neon.rbit.v16i8(<16 x i8> %A)
	ret <16 x i8> %tmp3
}

declare <4 x i16> @llvm.aarch64.neon.rbit.v4i16(<4 x i16>) nounwind readnone

define <4 x i16> @rbit_4x16(<4 x i16> %A) nounwind {
; CHECK-LABEL: rbit_4x16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev16 v0.8b, v0.8b
; CHECK-NEXT:    rbit v0.8b, v0.8b
; CHECK-NEXT:    ret
    %tmp3 = call <4 x i16> @llvm.aarch64.neon.rbit.v4i16(<4 x i16> %A)
	ret <4 x i16> %tmp3
}

declare <8 x i16> @llvm.aarch64.neon.rbit.v8i16(<8 x i16>) nounwind readnone

define <8 x i16> @rbit_8x16(<8 x i16> %A) {
; CHECK-LABEL: rbit_8x16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev16 v0.16b, v0.16b
; CHECK-NEXT:    rbit v0.16b, v0.16b
; CHECK-NEXT:    ret
  %tmp3 = call <8 x i16> @llvm.aarch64.neon.rbit.v8i16(<8 x i16> %A)
  ret <8 x i16> %tmp3
}

declare <2 x i32> @llvm.aarch64.neon.rbit.v2i32(<2 x i32>) nounwind readnone

define <2 x i32> @rbit_2x32(<2 x i32> %A) {
; CHECK-LABEL: rbit_2x32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    rbit w8, w8
; CHECK-NEXT:    mov w9, v0.s[1]
; CHECK-NEXT:    fmov s0, w8
; CHECK-NEXT:    rbit w8, w9
; CHECK-NEXT:    mov v0.s[1], w8
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-NEXT:    ret
  %tmp3 = call <2 x i32> @llvm.aarch64.neon.rbit.v2i32(<2 x i32> %A)
  ret <2 x i32> %tmp3
}

declare <4 x i32> @llvm.aarch64.neon.rbit.v4i32(<4 x i32>) nounwind readnone

define <4 x i32> @rbit_4x32(<4 x i32> %A) {
; CHECK-LABEL: rbit_4x32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov w10, s0
; CHECK-NEXT:    mov w8, v0.s[1]
; CHECK-NEXT:    rbit w10, w10
; CHECK-NEXT:    mov w9, v0.s[2]
; CHECK-NEXT:    mov w11, v0.s[3]
; CHECK-NEXT:    fmov s0, w10
; CHECK-NEXT:    rbit w8, w8
; CHECK-NEXT:    rbit w9, w9
; CHECK-NEXT:    mov v0.s[1], w8
; CHECK-NEXT:    mov v0.s[2], w9
; CHECK-NEXT:    rbit w8, w11
; CHECK-NEXT:    mov v0.s[3], w8
; CHECK-NEXT:    ret
  %tmp3 = call <4 x i32> @llvm.aarch64.neon.rbit.v4i32(<4 x i32> %A)
  ret <4 x i32> %tmp3
}

declare <1 x i64> @llvm.aarch64.neon.rbit.v1i64(<1 x i64>) readnone

define <1 x i64> @rbit_1x64(<1 x i64> %A) {
; CHECK-LABEL: rbit_1x64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    fmov x8, d0
; CHECK-NEXT:    rbit x8, x8
; CHECK-NEXT:    fmov d0, x8
; CHECK-NEXT:    ret
  %tmp3 = call <1 x i64> @llvm.aarch64.neon.rbit.v1i64(<1 x i64> %A)
  ret <1 x i64> %tmp3
}

declare <2 x i64> @llvm.aarch64.neon.rbit.v2i64(<2 x i64>) readnone

define <2 x i64> @rbit_2x64(<2 x i64> %A) {
; CHECK-LABEL: rbit_2x64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov x8, d0
; CHECK-NEXT:    rbit x8, x8
; CHECK-NEXT:    mov x9, v0.d[1]
; CHECK-NEXT:    fmov d0, x8
; CHECK-NEXT:    rbit x8, x9
; CHECK-NEXT:    mov v0.d[1], x8
; CHECK-NEXT:    ret
  %tmp3 = call <2 x i64> @llvm.aarch64.neon.rbit.v2i64(<2 x i64> %A)
  ret <2 x i64> %tmp3
}