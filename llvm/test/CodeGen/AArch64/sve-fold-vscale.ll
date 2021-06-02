; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve -disable-lsr < %s | FileCheck %s

; Check that vscale call is recognised by load/store reg/reg pattern and
; partially folded, with the rest pulled out of the loop. This requires LSR to
; be disabled, which is something that will be addressed at a later date.

define void @ld1w_reg_loop([32000 x i32]* %addr) {
; CHECK-LABEL: ld1w_reg_loop:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:    cntw x9
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:  .LBB0_1: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0, x8, lsl #2]
; CHECK-NEXT:    adds x8, x8, x9
; CHECK-NEXT:    b.ne .LBB0_1
; CHECK-NEXT:  // %bb.2: // %for.cond.cleanup
; CHECK-NEXT:    ret
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl i64 %0, 2
  br label %vector.body

vector.body:
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %2 = getelementptr inbounds [32000 x i32], [32000 x i32]* %addr, i64 0, i64 %index
  %3 = bitcast i32* %2 to <vscale x 4 x i32>*
  %load = load volatile <vscale x 4 x i32>, <vscale x 4 x i32>* %3, align 16
  %index.next = add i64 %index, %1
  %4 = icmp eq i64 %index.next, 0
  br i1 %4, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:
  ret void
}

define void @st1w_reg_loop([32000 x i32]* %addr, <vscale x 4 x i32> %val) {
; CHECK-LABEL: st1w_reg_loop:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:    cntw x9
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:  .LBB1_1: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    st1w { z0.s }, p0, [x0, x8, lsl #2]
; CHECK-NEXT:    adds x8, x8, x9
; CHECK-NEXT:    b.ne .LBB1_1
; CHECK-NEXT:  // %bb.2: // %for.cond.cleanup
; CHECK-NEXT:    ret
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl i64 %0, 2
  br label %vector.body

vector.body:
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %2 = getelementptr inbounds [32000 x i32], [32000 x i32]* %addr, i64 0, i64 %index
  %3 = bitcast i32* %2 to <vscale x 4 x i32>*
  store volatile <vscale x 4 x i32> %val, <vscale x 4 x i32>* %3, align 16
  %index.next = add i64 %index, %1
  %4 = icmp eq i64 %index.next, 0
  br i1 %4, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:
  ret void
}

declare i64 @llvm.vscale.i64()
