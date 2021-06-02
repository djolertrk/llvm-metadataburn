; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I
; RUN: llc -mtriple=riscv32 -mattr=+experimental-b -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32IB
; RUN: llc -mtriple=riscv32 -mattr=+experimental-zbs -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32IBS

define i32 @sbclr_i32(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: sbclr_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a2, zero, 1
; RV32I-NEXT:    sll a1, a2, a1
; RV32I-NEXT:    not a1, a1
; RV32I-NEXT:    and a0, a1, a0
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbclr_i32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    bclr a0, a0, a1
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbclr_i32:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    bclr a0, a0, a1
; RV32IBS-NEXT:    ret
  %and = and i32 %b, 31
  %shl = shl nuw i32 1, %and
  %neg = xor i32 %shl, -1
  %and1 = and i32 %neg, %a
  ret i32 %and1
}

define i32 @sbclr_i32_no_mask(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: sbclr_i32_no_mask:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a2, zero, 1
; RV32I-NEXT:    sll a1, a2, a1
; RV32I-NEXT:    not a1, a1
; RV32I-NEXT:    and a0, a1, a0
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbclr_i32_no_mask:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    bclr a0, a0, a1
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbclr_i32_no_mask:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    bclr a0, a0, a1
; RV32IBS-NEXT:    ret
  %shl = shl nuw i32 1, %b
  %neg = xor i32 %shl, -1
  %and1 = and i32 %neg, %a
  ret i32 %and1
}

define i64 @sbclr_i64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: sbclr_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a3, a2, 63
; RV32I-NEXT:    addi a4, a3, -32
; RV32I-NEXT:    addi a3, zero, 1
; RV32I-NEXT:    bltz a4, .LBB2_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    sll a2, a3, a4
; RV32I-NEXT:    not a2, a2
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB2_2:
; RV32I-NEXT:    sll a2, a3, a2
; RV32I-NEXT:    not a2, a2
; RV32I-NEXT:    and a0, a0, a2
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbclr_i64:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    andi a3, a2, 63
; RV32IB-NEXT:    addi a3, a3, -32
; RV32IB-NEXT:    bset a4, zero, a3
; RV32IB-NEXT:    slti a5, a3, 0
; RV32IB-NEXT:    cmov a4, a5, zero, a4
; RV32IB-NEXT:    bset a2, zero, a2
; RV32IB-NEXT:    srai a3, a3, 31
; RV32IB-NEXT:    and a2, a3, a2
; RV32IB-NEXT:    andn a1, a1, a4
; RV32IB-NEXT:    andn a0, a0, a2
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbclr_i64:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    andi a3, a2, 63
; RV32IBS-NEXT:    addi a3, a3, -32
; RV32IBS-NEXT:    bltz a3, .LBB2_2
; RV32IBS-NEXT:  # %bb.1:
; RV32IBS-NEXT:    bclr a1, a1, a3
; RV32IBS-NEXT:    ret
; RV32IBS-NEXT:  .LBB2_2:
; RV32IBS-NEXT:    bclr a0, a0, a2
; RV32IBS-NEXT:    ret
  %and = and i64 %b, 63
  %shl = shl nuw i64 1, %and
  %neg = xor i64 %shl, -1
  %and1 = and i64 %neg, %a
  ret i64 %and1
}

define i32 @sbset_i32(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: sbset_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a2, zero, 1
; RV32I-NEXT:    sll a1, a2, a1
; RV32I-NEXT:    or a0, a1, a0
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbset_i32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    bset a0, a0, a1
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbset_i32:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    bset a0, a0, a1
; RV32IBS-NEXT:    ret
  %and = and i32 %b, 31
  %shl = shl nuw i32 1, %and
  %or = or i32 %shl, %a
  ret i32 %or
}

define i32 @sbset_i32_no_mask(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: sbset_i32_no_mask:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a2, zero, 1
; RV32I-NEXT:    sll a1, a2, a1
; RV32I-NEXT:    or a0, a1, a0
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbset_i32_no_mask:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    bset a0, a0, a1
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbset_i32_no_mask:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    bset a0, a0, a1
; RV32IBS-NEXT:    ret
  %shl = shl nuw i32 1, %b
  %or = or i32 %shl, %a
  ret i32 %or
}

; We can use sbsetw for 1 << x by setting the first source to zero.
define signext i32 @sbset_i32_zero(i32 signext %a) nounwind {
; RV32I-LABEL: sbset_i32_zero:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a1, zero, 1
; RV32I-NEXT:    sll a0, a1, a0
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbset_i32_zero:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    bset a0, zero, a0
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbset_i32_zero:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    bset a0, zero, a0
; RV32IBS-NEXT:    ret
  %shl = shl i32 1, %a
  ret i32 %shl
}

; As we are not matching directly i64 code patterns on RV32 some i64 patterns
; don't have yet any matching bit manipulation instructions on RV32.
; This test is presented here in case future expansions of the experimental-b
; extension introduce instructions suitable for this pattern.

define i64 @sbset_i64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: sbset_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a3, zero, 1
; RV32I-NEXT:    sll a2, a3, a2
; RV32I-NEXT:    srai a3, a2, 31
; RV32I-NEXT:    or a0, a2, a0
; RV32I-NEXT:    or a1, a3, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbset_i64:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    bset a3, zero, a2
; RV32IB-NEXT:    srai a3, a3, 31
; RV32IB-NEXT:    bset a0, a0, a2
; RV32IB-NEXT:    or a1, a3, a1
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbset_i64:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    bset a3, zero, a2
; RV32IBS-NEXT:    srai a3, a3, 31
; RV32IBS-NEXT:    bset a0, a0, a2
; RV32IBS-NEXT:    or a1, a3, a1
; RV32IBS-NEXT:    ret
  %1 = trunc i64 %b to i32
  %conv = and i32 %1, 63
  %shl = shl nuw i32 1, %conv
  %conv1 = sext i32 %shl to i64
  %or = or i64 %conv1, %a
  ret i64 %or
}

define signext i64 @sbset_i64_zero(i64 signext %a) nounwind {
; RV32I-LABEL: sbset_i64_zero:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a1, a0, -32
; RV32I-NEXT:    addi a2, zero, 1
; RV32I-NEXT:    bltz a1, .LBB7_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    mv a0, zero
; RV32I-NEXT:    sll a1, a2, a1
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB7_2:
; RV32I-NEXT:    mv a1, zero
; RV32I-NEXT:    sll a0, a2, a0
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbset_i64_zero:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    addi a2, a0, -32
; RV32IB-NEXT:    bset a1, zero, a2
; RV32IB-NEXT:    slti a3, a2, 0
; RV32IB-NEXT:    cmov a1, a3, zero, a1
; RV32IB-NEXT:    bset a0, zero, a0
; RV32IB-NEXT:    srai a2, a2, 31
; RV32IB-NEXT:    and a0, a2, a0
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbset_i64_zero:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    addi a1, a0, -32
; RV32IBS-NEXT:    bltz a1, .LBB7_2
; RV32IBS-NEXT:  # %bb.1:
; RV32IBS-NEXT:    mv a0, zero
; RV32IBS-NEXT:    bset a1, zero, a1
; RV32IBS-NEXT:    ret
; RV32IBS-NEXT:  .LBB7_2:
; RV32IBS-NEXT:    mv a1, zero
; RV32IBS-NEXT:    bset a0, zero, a0
; RV32IBS-NEXT:    ret
  %shl = shl i64 1, %a
  ret i64 %shl
}

define i32 @sbinv_i32(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: sbinv_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a2, zero, 1
; RV32I-NEXT:    sll a1, a2, a1
; RV32I-NEXT:    xor a0, a1, a0
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbinv_i32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    binv a0, a0, a1
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbinv_i32:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    binv a0, a0, a1
; RV32IBS-NEXT:    ret
  %and = and i32 %b, 31
  %shl = shl nuw i32 1, %and
  %xor = xor i32 %shl, %a
  ret i32 %xor
}

; As we are not matching directly i64 code patterns on RV32 some i64 patterns
; don't have yet any matching bit manipulation instructions on RV32.
; This test is presented here in case future expansions of the experimental-b
; extension introduce instructions suitable for this pattern.

define i64 @sbinv_i64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: sbinv_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a3, zero, 1
; RV32I-NEXT:    sll a2, a3, a2
; RV32I-NEXT:    srai a3, a2, 31
; RV32I-NEXT:    xor a0, a2, a0
; RV32I-NEXT:    xor a1, a3, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbinv_i64:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    bset a3, zero, a2
; RV32IB-NEXT:    srai a3, a3, 31
; RV32IB-NEXT:    binv a0, a0, a2
; RV32IB-NEXT:    xor a1, a3, a1
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbinv_i64:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    bset a3, zero, a2
; RV32IBS-NEXT:    srai a3, a3, 31
; RV32IBS-NEXT:    binv a0, a0, a2
; RV32IBS-NEXT:    xor a1, a3, a1
; RV32IBS-NEXT:    ret
  %1 = trunc i64 %b to i32
  %conv = and i32 %1, 63
  %shl = shl nuw i32 1, %conv
  %conv1 = sext i32 %shl to i64
  %xor = xor i64 %conv1, %a
  ret i64 %xor
}

define i32 @sbext_i32(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: sbext_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srl a0, a0, a1
; RV32I-NEXT:    andi a0, a0, 1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbext_i32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    bext a0, a0, a1
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbext_i32:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    bext a0, a0, a1
; RV32IBS-NEXT:    ret
  %and = and i32 %b, 31
  %shr = lshr i32 %a, %and
  %and1 = and i32 %shr, 1
  ret i32 %and1
}

define i32 @sbext_i32_no_mask(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: sbext_i32_no_mask:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srl a0, a0, a1
; RV32I-NEXT:    andi a0, a0, 1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbext_i32_no_mask:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    bext a0, a0, a1
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbext_i32_no_mask:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    bext a0, a0, a1
; RV32IBS-NEXT:    ret
  %shr = lshr i32 %a, %b
  %and1 = and i32 %shr, 1
  ret i32 %and1
}

; As we are not matching directly i64 code patterns on RV32 some i64 patterns
; don't have yet any matching bit manipulation instructions on RV32.
; This test is presented here in case future expansions of the experimental-b
; extension introduce instructions suitable for this pattern.

define i64 @sbext_i64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: sbext_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a3, a2, 63
; RV32I-NEXT:    addi a4, a3, -32
; RV32I-NEXT:    bltz a4, .LBB12_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    srl a0, a1, a4
; RV32I-NEXT:    j .LBB12_3
; RV32I-NEXT:  .LBB12_2:
; RV32I-NEXT:    srl a0, a0, a2
; RV32I-NEXT:    addi a2, zero, 31
; RV32I-NEXT:    sub a2, a2, a3
; RV32I-NEXT:    slli a1, a1, 1
; RV32I-NEXT:    sll a1, a1, a2
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:  .LBB12_3:
; RV32I-NEXT:    andi a0, a0, 1
; RV32I-NEXT:    mv a1, zero
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbext_i64:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    srl a0, a0, a2
; RV32IB-NEXT:    andi a2, a2, 63
; RV32IB-NEXT:    addi a3, zero, 31
; RV32IB-NEXT:    sub a3, a3, a2
; RV32IB-NEXT:    slli a4, a1, 1
; RV32IB-NEXT:    sll a3, a4, a3
; RV32IB-NEXT:    or a0, a0, a3
; RV32IB-NEXT:    addi a2, a2, -32
; RV32IB-NEXT:    srl a1, a1, a2
; RV32IB-NEXT:    slti a2, a2, 0
; RV32IB-NEXT:    cmov a0, a2, a0, a1
; RV32IB-NEXT:    andi a0, a0, 1
; RV32IB-NEXT:    mv a1, zero
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbext_i64:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    andi a3, a2, 63
; RV32IBS-NEXT:    addi a4, a3, -32
; RV32IBS-NEXT:    bltz a4, .LBB12_2
; RV32IBS-NEXT:  # %bb.1:
; RV32IBS-NEXT:    srl a0, a1, a4
; RV32IBS-NEXT:    j .LBB12_3
; RV32IBS-NEXT:  .LBB12_2:
; RV32IBS-NEXT:    srl a0, a0, a2
; RV32IBS-NEXT:    addi a2, zero, 31
; RV32IBS-NEXT:    sub a2, a2, a3
; RV32IBS-NEXT:    slli a1, a1, 1
; RV32IBS-NEXT:    sll a1, a1, a2
; RV32IBS-NEXT:    or a0, a0, a1
; RV32IBS-NEXT:  .LBB12_3:
; RV32IBS-NEXT:    andi a0, a0, 1
; RV32IBS-NEXT:    mv a1, zero
; RV32IBS-NEXT:    ret
  %conv = and i64 %b, 63
  %shr = lshr i64 %a, %conv
  %and1 = and i64 %shr, 1
  ret i64 %and1
}

define i32 @sbexti_i32(i32 %a) nounwind {
; RV32I-LABEL: sbexti_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srli a0, a0, 5
; RV32I-NEXT:    andi a0, a0, 1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbexti_i32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    bexti a0, a0, 5
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbexti_i32:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    bexti a0, a0, 5
; RV32IBS-NEXT:    ret
  %shr = lshr i32 %a, 5
  %and = and i32 %shr, 1
  ret i32 %and
}

define i64 @sbexti_i64(i64 %a) nounwind {
; RV32I-LABEL: sbexti_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srli a0, a0, 5
; RV32I-NEXT:    andi a0, a0, 1
; RV32I-NEXT:    mv a1, zero
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbexti_i64:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    bexti a0, a0, 5
; RV32IB-NEXT:    mv a1, zero
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbexti_i64:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    bexti a0, a0, 5
; RV32IBS-NEXT:    mv a1, zero
; RV32IBS-NEXT:    ret
  %shr = lshr i64 %a, 5
  %and = and i64 %shr, 1
  ret i64 %and
}

define i32 @sbclri_i32_10(i32 %a) nounwind {
; RV32I-LABEL: sbclri_i32_10:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a0, a0, -1025
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbclri_i32_10:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    andi a0, a0, -1025
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbclri_i32_10:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    andi a0, a0, -1025
; RV32IBS-NEXT:    ret
  %and = and i32 %a, -1025
  ret i32 %and
}

define i32 @sbclri_i32_11(i32 %a) nounwind {
; RV32I-LABEL: sbclri_i32_11:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 1048575
; RV32I-NEXT:    addi a1, a1, 2047
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbclri_i32_11:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    bclri a0, a0, 11
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbclri_i32_11:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    bclri a0, a0, 11
; RV32IBS-NEXT:    ret
  %and = and i32 %a, -2049
  ret i32 %and
}

define i32 @sbclri_i32_30(i32 %a) nounwind {
; RV32I-LABEL: sbclri_i32_30:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 786432
; RV32I-NEXT:    addi a1, a1, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbclri_i32_30:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    bclri a0, a0, 30
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbclri_i32_30:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    bclri a0, a0, 30
; RV32IBS-NEXT:    ret
  %and = and i32 %a, -1073741825
  ret i32 %and
}

define i32 @sbclri_i32_31(i32 %a) nounwind {
; RV32I-LABEL: sbclri_i32_31:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 524288
; RV32I-NEXT:    addi a1, a1, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbclri_i32_31:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    bclri a0, a0, 31
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbclri_i32_31:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    bclri a0, a0, 31
; RV32IBS-NEXT:    ret
  %and = and i32 %a, -2147483649
  ret i32 %and
}

define i32 @sbseti_i32_10(i32 %a) nounwind {
; RV32I-LABEL: sbseti_i32_10:
; RV32I:       # %bb.0:
; RV32I-NEXT:    ori a0, a0, 1024
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbseti_i32_10:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    ori a0, a0, 1024
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbseti_i32_10:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    ori a0, a0, 1024
; RV32IBS-NEXT:    ret
  %or = or i32 %a, 1024
  ret i32 %or
}

define i32 @sbseti_i32_11(i32 %a) nounwind {
; RV32I-LABEL: sbseti_i32_11:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 1
; RV32I-NEXT:    addi a1, a1, -2048
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbseti_i32_11:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    bseti a0, a0, 11
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbseti_i32_11:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    bseti a0, a0, 11
; RV32IBS-NEXT:    ret
  %or = or i32 %a, 2048
  ret i32 %or
}

define i32 @sbseti_i32_30(i32 %a) nounwind {
; RV32I-LABEL: sbseti_i32_30:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 262144
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbseti_i32_30:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    bseti a0, a0, 30
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbseti_i32_30:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    bseti a0, a0, 30
; RV32IBS-NEXT:    ret
  %or = or i32 %a, 1073741824
  ret i32 %or
}

define i32 @sbseti_i32_31(i32 %a) nounwind {
; RV32I-LABEL: sbseti_i32_31:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 524288
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbseti_i32_31:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    bseti a0, a0, 31
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbseti_i32_31:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    bseti a0, a0, 31
; RV32IBS-NEXT:    ret
  %or = or i32 %a, 2147483648
  ret i32 %or
}

define i32 @sbinvi_i32_10(i32 %a) nounwind {
; RV32I-LABEL: sbinvi_i32_10:
; RV32I:       # %bb.0:
; RV32I-NEXT:    xori a0, a0, 1024
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbinvi_i32_10:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    xori a0, a0, 1024
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbinvi_i32_10:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    xori a0, a0, 1024
; RV32IBS-NEXT:    ret
  %xor = xor i32 %a, 1024
  ret i32 %xor
}

define i32 @sbinvi_i32_11(i32 %a) nounwind {
; RV32I-LABEL: sbinvi_i32_11:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 1
; RV32I-NEXT:    addi a1, a1, -2048
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbinvi_i32_11:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    binvi a0, a0, 11
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbinvi_i32_11:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    binvi a0, a0, 11
; RV32IBS-NEXT:    ret
  %xor = xor i32 %a, 2048
  ret i32 %xor
}

define i32 @sbinvi_i32_30(i32 %a) nounwind {
; RV32I-LABEL: sbinvi_i32_30:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 262144
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbinvi_i32_30:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    binvi a0, a0, 30
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbinvi_i32_30:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    binvi a0, a0, 30
; RV32IBS-NEXT:    ret
  %xor = xor i32 %a, 1073741824
  ret i32 %xor
}

define i32 @sbinvi_i32_31(i32 %a) nounwind {
; RV32I-LABEL: sbinvi_i32_31:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 524288
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: sbinvi_i32_31:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    binvi a0, a0, 31
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: sbinvi_i32_31:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    binvi a0, a0, 31
; RV32IBS-NEXT:    ret
  %xor = xor i32 %a, 2147483648
  ret i32 %xor
}

define i32 @xor_i32_4098(i32 %a) nounwind {
; RV32I-LABEL: xor_i32_4098:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 1
; RV32I-NEXT:    addi a1, a1, 2
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: xor_i32_4098:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    binvi a0, a0, 1
; RV32IB-NEXT:    binvi a0, a0, 12
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: xor_i32_4098:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    binvi a0, a0, 1
; RV32IBS-NEXT:    binvi a0, a0, 12
; RV32IBS-NEXT:    ret
  %xor = xor i32 %a, 4098
  ret i32 %xor
}

define i32 @xor_i32_4099(i32 %a) nounwind {
; RV32I-LABEL: xor_i32_4099:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 1
; RV32I-NEXT:    addi a1, a1, 3
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: xor_i32_4099:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    xori a0, a0, 3
; RV32IB-NEXT:    binvi a0, a0, 12
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: xor_i32_4099:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    xori a0, a0, 3
; RV32IBS-NEXT:    binvi a0, a0, 12
; RV32IBS-NEXT:    ret
  %xor = xor i32 %a, 4099
  ret i32 %xor
}

define i32 @xor_i32_96(i32 %a) nounwind {
; RV32I-LABEL: xor_i32_96:
; RV32I:       # %bb.0:
; RV32I-NEXT:    xori a0, a0, 96
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: xor_i32_96:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    xori a0, a0, 96
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: xor_i32_96:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    xori a0, a0, 96
; RV32IBS-NEXT:    ret
  %xor = xor i32 %a, 96
  ret i32 %xor
}

define i32 @xor_i32_66901(i32 %a) nounwind {
; RV32I-LABEL: xor_i32_66901:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 16
; RV32I-NEXT:    addi a1, a1, 1365
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: xor_i32_66901:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    xori a0, a0, 1365
; RV32IB-NEXT:    binvi a0, a0, 16
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: xor_i32_66901:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    xori a0, a0, 1365
; RV32IBS-NEXT:    binvi a0, a0, 16
; RV32IBS-NEXT:    ret
  %xor = xor i32 %a, 66901
  ret i32 %xor
}

define i32 @or_i32_4098(i32 %a) nounwind {
; RV32I-LABEL: or_i32_4098:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 1
; RV32I-NEXT:    addi a1, a1, 2
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: or_i32_4098:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    bseti a0, a0, 1
; RV32IB-NEXT:    bseti a0, a0, 12
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: or_i32_4098:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    bseti a0, a0, 1
; RV32IBS-NEXT:    bseti a0, a0, 12
; RV32IBS-NEXT:    ret
  %or = or i32 %a, 4098
  ret i32 %or
}

define i32 @or_i32_4099(i32 %a) nounwind {
; RV32I-LABEL: or_i32_4099:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 1
; RV32I-NEXT:    addi a1, a1, 3
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: or_i32_4099:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    ori a0, a0, 3
; RV32IB-NEXT:    bseti a0, a0, 12
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: or_i32_4099:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    ori a0, a0, 3
; RV32IBS-NEXT:    bseti a0, a0, 12
; RV32IBS-NEXT:    ret
  %or = or i32 %a, 4099
  ret i32 %or
}

define i32 @or_i32_96(i32 %a) nounwind {
; RV32I-LABEL: or_i32_96:
; RV32I:       # %bb.0:
; RV32I-NEXT:    ori a0, a0, 96
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: or_i32_96:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    ori a0, a0, 96
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: or_i32_96:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    ori a0, a0, 96
; RV32IBS-NEXT:    ret
  %or = or i32 %a, 96
  ret i32 %or
}

define i32 @or_i32_66901(i32 %a) nounwind {
; RV32I-LABEL: or_i32_66901:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 16
; RV32I-NEXT:    addi a1, a1, 1365
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: or_i32_66901:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    ori a0, a0, 1365
; RV32IB-NEXT:    bseti a0, a0, 16
; RV32IB-NEXT:    ret
;
; RV32IBS-LABEL: or_i32_66901:
; RV32IBS:       # %bb.0:
; RV32IBS-NEXT:    ori a0, a0, 1365
; RV32IBS-NEXT:    bseti a0, a0, 16
; RV32IBS-NEXT:    ret
  %or = or i32 %a, 66901
  ret i32 %or
}
