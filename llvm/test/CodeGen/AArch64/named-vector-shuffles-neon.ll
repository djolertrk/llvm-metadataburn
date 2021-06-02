; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

;
; VECTOR_SPLICE (index)
;

define <16 x i8> @splice_v16i8_idx(<16 x i8> %a, <16 x i8> %b) #0 {
; CHECK-LABEL: splice_v16i8_idx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ext v0.16b, v0.16b, v1.16b, #1
; CHECK-NEXT:    ret
  %res = call <16 x i8> @llvm.experimental.vector.splice.v16i8(<16 x i8> %a, <16 x i8> %b, i32 1)
  ret <16 x i8> %res
}

define <2 x double> @splice_v2f64_idx(<2 x double> %a, <2 x double> %b) #0 {
; CHECK-LABEL: splice_v2f64_idx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ext v0.16b, v0.16b, v1.16b, #8
; CHECK-NEXT:    ret
  %res = call <2 x double> @llvm.experimental.vector.splice.v2f64(<2 x double> %a, <2 x double> %b, i32 1)
  ret <2 x double> %res
}

; Verify promote type legalisation works as expected.
define <2 x i8> @splice_v2i8_idx(<2 x i8> %a, <2 x i8> %b) #0 {
; CHECK-LABEL: splice_v2i8_idx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ext v0.8b, v0.8b, v1.8b, #4
; CHECK-NEXT:    ret
  %res = call <2 x i8> @llvm.experimental.vector.splice.v2i8(<2 x i8> %a, <2 x i8> %b, i32 1)
  ret <2 x i8> %res
}

; Verify splitvec type legalisation works as expected.
define <8 x i32> @splice_v8i32_idx(<8 x i32> %a, <8 x i32> %b) #0 {
; CHECK-LABEL: splice_v8i32_idx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ext v0.16b, v1.16b, v2.16b, #4
; CHECK-NEXT:    ext v1.16b, v2.16b, v3.16b, #4
; CHECK-NEXT:    ret
  %res = call <8 x i32> @llvm.experimental.vector.splice.v8i32(<8 x i32> %a, <8 x i32> %b, i32 5)
  ret <8 x i32> %res
}

; Verify splitvec type legalisation works as expected.
define <16 x float> @splice_v16f32_idx(<16 x float> %a, <16 x float> %b) #0 {
; CHECK-LABEL: splice_v16f32_idx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ext v0.16b, v1.16b, v2.16b, #12
; CHECK-NEXT:    ext v1.16b, v2.16b, v3.16b, #12
; CHECK-NEXT:    ext v2.16b, v3.16b, v4.16b, #12
; CHECK-NEXT:    ext v3.16b, v4.16b, v5.16b, #12
; CHECK-NEXT:    ret
  %res = call <16 x float> @llvm.experimental.vector.splice.v16f32(<16 x float> %a, <16 x float> %b, i32 7)
  ret <16 x float> %res
}

; Verify out-of-bounds index results in undef vector.
define <2 x double> @splice_v2f64_idx_out_of_bounds(<2 x double> %a, <2 x double> %b) #0 {
; CHECK-LABEL: splice_v2f64_idx_out_of_bounds:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %res = call <2 x double> @llvm.experimental.vector.splice.v2f64(<2 x double> %a, <2 x double> %b, i32 2)
  ret <2 x double> %res
}

;
; VECTOR_SPLICE (trailing elements)
;

define <16 x i8> @splice_v16i8(<16 x i8> %a, <16 x i8> %b) #0 {
; CHECK-LABEL: splice_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ext v0.16b, v0.16b, v1.16b, #1
; CHECK-NEXT:    ret
  %res = call <16 x i8> @llvm.experimental.vector.splice.v16i8(<16 x i8> %a, <16 x i8> %b, i32 -15)
  ret <16 x i8> %res
}

define <2 x double> @splice_v2f64(<2 x double> %a, <2 x double> %b) #0 {
; CHECK-LABEL: splice_v2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ext v0.16b, v0.16b, v1.16b, #8
; CHECK-NEXT:    ret
  %res = call <2 x double> @llvm.experimental.vector.splice.v2f64(<2 x double> %a, <2 x double> %b, i32 -1)
  ret <2 x double> %res
}

; Verify promote type legalisation works as expected.
define <2 x i8> @splice_v2i8(<2 x i8> %a, <2 x i8> %b) #0 {
; CHECK-LABEL: splice_v2i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ext v0.8b, v0.8b, v1.8b, #4
; CHECK-NEXT:    ret
  %res = call <2 x i8> @llvm.experimental.vector.splice.v2i8(<2 x i8> %a, <2 x i8> %b, i32 -1)
  ret <2 x i8> %res
}

; Verify splitvec type legalisation works as expected.
define <8 x i32> @splice_v8i32(<8 x i32> %a, <8 x i32> %b) #0 {
; CHECK-LABEL: splice_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ext v0.16b, v1.16b, v2.16b, #4
; CHECK-NEXT:    ext v1.16b, v2.16b, v3.16b, #4
; CHECK-NEXT:    ret
  %res = call <8 x i32> @llvm.experimental.vector.splice.v8i32(<8 x i32> %a, <8 x i32> %b, i32 -3)
  ret <8 x i32> %res
}

; Verify splitvec type legalisation works as expected.
define <16 x float> @splice_v16f32(<16 x float> %a, <16 x float> %b) #0 {
; CHECK-LABEL: splice_v16f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ext v0.16b, v1.16b, v2.16b, #12
; CHECK-NEXT:    ext v1.16b, v2.16b, v3.16b, #12
; CHECK-NEXT:    ext v2.16b, v3.16b, v4.16b, #12
; CHECK-NEXT:    ext v3.16b, v4.16b, v5.16b, #12
; CHECK-NEXT:    ret
  %res = call <16 x float> @llvm.experimental.vector.splice.v16f32(<16 x float> %a, <16 x float> %b, i32 -9)
  ret <16 x float> %res
}

; Verify out-of-bounds trailing element count results in undef vector.
define <2 x double> @splice_v2f64_out_of_bounds(<2 x double> %a, <2 x double> %b) #0 {
; CHECK-LABEL: splice_v2f64_out_of_bounds:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %res = call <2 x double> @llvm.experimental.vector.splice.v2f64(<2 x double> %a, <2 x double> %b, i32 -3)
  ret <2 x double> %res
}

declare <2 x i8> @llvm.experimental.vector.splice.v2i8(<2 x i8>, <2 x i8>, i32)
declare <16 x i8> @llvm.experimental.vector.splice.v16i8(<16 x i8>, <16 x i8>, i32)
declare <8 x i32> @llvm.experimental.vector.splice.v8i32(<8 x i32>, <8 x i32>, i32)
declare <16 x float> @llvm.experimental.vector.splice.v16f32(<16 x float>, <16 x float>, i32)
declare <2 x double> @llvm.experimental.vector.splice.v2f64(<2 x double>, <2 x double>, i32)

attributes #0 = { nounwind "target-features"="+neon" }
