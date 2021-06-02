; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -verify-machineinstrs -mattr=+simd128 | FileCheck %s

; Test SIMD v128.load{32,64}_zero instructions

target datalayout = "e-m:e-p:32:32-i64:64-n32:64-S128"
target triple = "wasm32-unknown-unknown"

declare <4 x i32> @llvm.wasm.load32.zero(i32*)
declare <2 x i64> @llvm.wasm.load64.zero(i64*)

;===----------------------------------------------------------------------------
; v128.load32_zero
;===----------------------------------------------------------------------------

define <4 x i32> @load_zero_i32_no_offset(i32* %p) {
; CHECK-LABEL: load_zero_i32_no_offset:
; CHECK:         .functype load_zero_i32_no_offset (i32) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.load32_zero 0:p2align=0
; CHECK-NEXT:    # fallthrough-return
  %v = tail call <4 x i32> @llvm.wasm.load32.zero(i32* %p)
  ret <4 x i32> %v
}

define <4 x i32> @load_zero_i32_with_folded_offset(i32* %p) {
; CHECK-LABEL: load_zero_i32_with_folded_offset:
; CHECK:         .functype load_zero_i32_with_folded_offset (i32) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.load32_zero 24:p2align=0
; CHECK-NEXT:    # fallthrough-return
  %q = ptrtoint i32* %p to i32
  %r = add nuw i32 %q, 24
  %s = inttoptr i32 %r to i32*
  %t = tail call <4 x i32> @llvm.wasm.load32.zero(i32* %s)
  ret <4 x i32> %t
}

define <4 x i32> @load_zero_i32_with_folded_gep_offset(i32* %p) {
; CHECK-LABEL: load_zero_i32_with_folded_gep_offset:
; CHECK:         .functype load_zero_i32_with_folded_gep_offset (i32) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.load32_zero 24:p2align=0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr inbounds i32, i32* %p, i32 6
  %t = tail call <4 x i32> @llvm.wasm.load32.zero(i32* %s)
  ret <4 x i32> %t
}

define <4 x i32> @load_zero_i32_with_unfolded_gep_negative_offset(i32* %p) {
; CHECK-LABEL: load_zero_i32_with_unfolded_gep_negative_offset:
; CHECK:         .functype load_zero_i32_with_unfolded_gep_negative_offset (i32) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const -24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    v128.load32_zero 0:p2align=0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr inbounds i32, i32* %p, i32 -6
  %t = tail call <4 x i32> @llvm.wasm.load32.zero(i32* %s)
  ret <4 x i32> %t
}

define <4 x i32> @load_zero_i32_with_unfolded_offset(i32* %p) {
; CHECK-LABEL: load_zero_i32_with_unfolded_offset:
; CHECK:         .functype load_zero_i32_with_unfolded_offset (i32) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    v128.load32_zero 0:p2align=0
; CHECK-NEXT:    # fallthrough-return
  %q = ptrtoint i32* %p to i32
  %r = add nsw i32 %q, 24
  %s = inttoptr i32 %r to i32*
  %t = tail call <4 x i32> @llvm.wasm.load32.zero(i32* %s)
  ret <4 x i32> %t
}

define <4 x i32> @load_zero_i32_with_unfolded_gep_offset(i32* %p) {
; CHECK-LABEL: load_zero_i32_with_unfolded_gep_offset:
; CHECK:         .functype load_zero_i32_with_unfolded_gep_offset (i32) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    v128.load32_zero 0:p2align=0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr i32, i32* %p, i32 6
  %t = tail call <4 x i32> @llvm.wasm.load32.zero(i32* %s)
  ret <4 x i32> %t
}

define <4 x i32> @load_zero_i32_from_numeric_address() {
; CHECK-LABEL: load_zero_i32_from_numeric_address:
; CHECK:         .functype load_zero_i32_from_numeric_address () -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    i32.const 0
; CHECK-NEXT:    v128.load32_zero 42:p2align=0
; CHECK-NEXT:    # fallthrough-return
  %s = inttoptr i32 42 to i32*
  %t = tail call <4 x i32> @llvm.wasm.load32.zero(i32* %s)
  ret <4 x i32> %t
}

@gv_i32 = global i32 0
define <4 x i32> @load_zero_i32_from_global_address() {
; CHECK-LABEL: load_zero_i32_from_global_address:
; CHECK:         .functype load_zero_i32_from_global_address () -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    i32.const 0
; CHECK-NEXT:    v128.load32_zero gv_i32:p2align=0
; CHECK-NEXT:    # fallthrough-return
  %t = tail call <4 x i32> @llvm.wasm.load32.zero(i32* @gv_i32)
  ret <4 x i32> %t
}

;===----------------------------------------------------------------------------
; v128.load64_zero
;===----------------------------------------------------------------------------

define <2 x i64> @load_zero_i64_no_offset(i64* %p) {
; CHECK-LABEL: load_zero_i64_no_offset:
; CHECK:         .functype load_zero_i64_no_offset (i32) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.load64_zero 0:p2align=0
; CHECK-NEXT:    # fallthrough-return
  %v = tail call <2 x i64> @llvm.wasm.load64.zero(i64* %p)
  ret <2 x i64> %v
}

define <2 x i64> @load_zero_i64_with_folded_offset(i64* %p) {
; CHECK-LABEL: load_zero_i64_with_folded_offset:
; CHECK:         .functype load_zero_i64_with_folded_offset (i32) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.load64_zero 24:p2align=0
; CHECK-NEXT:    # fallthrough-return
  %q = ptrtoint i64* %p to i32
  %r = add nuw i32 %q, 24
  %s = inttoptr i32 %r to i64*
  %t = tail call <2 x i64> @llvm.wasm.load64.zero(i64* %s)
  ret <2 x i64> %t
}

define <2 x i64> @load_zero_i64_with_folded_gep_offset(i64* %p) {
; CHECK-LABEL: load_zero_i64_with_folded_gep_offset:
; CHECK:         .functype load_zero_i64_with_folded_gep_offset (i32) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.load64_zero 48:p2align=0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr inbounds i64, i64* %p, i64 6
  %t = tail call <2 x i64> @llvm.wasm.load64.zero(i64* %s)
  ret <2 x i64> %t
}

define <2 x i64> @load_zero_i64_with_unfolded_gep_negative_offset(i64* %p) {
; CHECK-LABEL: load_zero_i64_with_unfolded_gep_negative_offset:
; CHECK:         .functype load_zero_i64_with_unfolded_gep_negative_offset (i32) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const -48
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    v128.load64_zero 0:p2align=0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr inbounds i64, i64* %p, i64 -6
  %t = tail call <2 x i64> @llvm.wasm.load64.zero(i64* %s)
  ret <2 x i64> %t
}

define <2 x i64> @load_zero_i64_with_unfolded_offset(i64* %p) {
; CHECK-LABEL: load_zero_i64_with_unfolded_offset:
; CHECK:         .functype load_zero_i64_with_unfolded_offset (i32) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const 24
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    v128.load64_zero 0:p2align=0
; CHECK-NEXT:    # fallthrough-return
  %q = ptrtoint i64* %p to i32
  %r = add nsw i32 %q, 24
  %s = inttoptr i32 %r to i64*
  %t = tail call <2 x i64> @llvm.wasm.load64.zero(i64* %s)
  ret <2 x i64> %t
}

define <2 x i64> @load_zero_i64_with_unfolded_gep_offset(i64* %p) {
; CHECK-LABEL: load_zero_i64_with_unfolded_gep_offset:
; CHECK:         .functype load_zero_i64_with_unfolded_gep_offset (i32) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    i32.const 48
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    v128.load64_zero 0:p2align=0
; CHECK-NEXT:    # fallthrough-return
  %s = getelementptr i64, i64* %p, i64 6
  %t = tail call <2 x i64> @llvm.wasm.load64.zero(i64* %s)
  ret <2 x i64> %t
}

define <2 x i64> @load_zero_i64_from_numeric_address() {
; CHECK-LABEL: load_zero_i64_from_numeric_address:
; CHECK:         .functype load_zero_i64_from_numeric_address () -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    i32.const 0
; CHECK-NEXT:    v128.load64_zero 42:p2align=0
; CHECK-NEXT:    # fallthrough-return
  %s = inttoptr i32 42 to i64*
  %t = tail call <2 x i64> @llvm.wasm.load64.zero(i64* %s)
  ret <2 x i64> %t
}

@gv_i64 = global i64 0
define <2 x i64> @load_zero_i64_from_global_address() {
; CHECK-LABEL: load_zero_i64_from_global_address:
; CHECK:         .functype load_zero_i64_from_global_address () -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    i32.const 0
; CHECK-NEXT:    v128.load64_zero gv_i64:p2align=0
; CHECK-NEXT:    # fallthrough-return
  %t = tail call <2 x i64> @llvm.wasm.load64.zero(i64* @gv_i64)
  ret <2 x i64> %t
}