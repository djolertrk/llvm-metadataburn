; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+m,+experimental-v -verify-machineinstrs < %s \
; RUN:    | FileCheck %s

define void @lmul1() nounwind {
; CHECK-LABEL: lmul1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %v = alloca <vscale x 1 x i64>
  ret void
}

define void @lmul2() nounwind {
; CHECK-LABEL: lmul2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 1
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 1
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %v = alloca <vscale x 2 x i64>
  ret void
}

define void @lmul4() nounwind {
; CHECK-LABEL: lmul4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -32
; CHECK-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; CHECK-NEXT:    addi s0, sp, 32
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 2
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    andi sp, sp, -32
; CHECK-NEXT:    addi sp, s0, -32
; CHECK-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 32
; CHECK-NEXT:    ret
  %v = alloca <vscale x 4 x i64>
  ret void
}

define void @lmul8() nounwind {
; CHECK-LABEL: lmul8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -64
; CHECK-NEXT:    sd ra, 56(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s0, 48(sp) # 8-byte Folded Spill
; CHECK-NEXT:    addi s0, sp, 64
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    andi sp, sp, -64
; CHECK-NEXT:    addi sp, s0, -64
; CHECK-NEXT:    ld s0, 48(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld ra, 56(sp) # 8-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 64
; CHECK-NEXT:    ret
  %v = alloca <vscale x 8 x i64>
  ret void
}

define void @lmul1_and_2() nounwind {
; CHECK-LABEL: lmul1_and_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a1, a0, 1
; CHECK-NEXT:    add a0, a1, a0
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a1, a0, 1
; CHECK-NEXT:    add a0, a1, a0
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %v1 = alloca <vscale x 1 x i64>
  %v2 = alloca <vscale x 2 x i64>
  ret void
}

define void @lmul2_and_4() nounwind {
; CHECK-LABEL: lmul2_and_4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -32
; CHECK-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; CHECK-NEXT:    addi s0, sp, 32
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    addi a1, zero, 6
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    andi sp, sp, -32
; CHECK-NEXT:    addi sp, s0, -32
; CHECK-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 32
; CHECK-NEXT:    ret
  %v1 = alloca <vscale x 2 x i64>
  %v2 = alloca <vscale x 4 x i64>
  ret void
}

define void @lmul1_and_4() nounwind {
; CHECK-LABEL: lmul1_and_4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -32
; CHECK-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; CHECK-NEXT:    addi s0, sp, 32
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a1, a0, 2
; CHECK-NEXT:    add a0, a1, a0
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    andi sp, sp, -32
; CHECK-NEXT:    addi sp, s0, -32
; CHECK-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 32
; CHECK-NEXT:    ret
  %v1 = alloca <vscale x 1 x i64>
  %v2 = alloca <vscale x 4 x i64>
  ret void
}

define void @lmul2_and_1() nounwind {
; CHECK-LABEL: lmul2_and_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a1, a0, 1
; CHECK-NEXT:    add a0, a1, a0
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a1, a0, 1
; CHECK-NEXT:    add a0, a1, a0
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %v1 = alloca <vscale x 2 x i64>
  %v2 = alloca <vscale x 1 x i64>
  ret void
}

define void @lmul4_and_1() nounwind {
; CHECK-LABEL: lmul4_and_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -32
; CHECK-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; CHECK-NEXT:    addi s0, sp, 32
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a1, a0, 2
; CHECK-NEXT:    add a0, a1, a0
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    andi sp, sp, -32
; CHECK-NEXT:    addi sp, s0, -32
; CHECK-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 32
; CHECK-NEXT:    ret
  %v1 = alloca <vscale x 4 x i64>
  %v2 = alloca <vscale x 1 x i64>
  ret void
}

define void @lmul4_and_2() nounwind {
; CHECK-LABEL: lmul4_and_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -32
; CHECK-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; CHECK-NEXT:    addi s0, sp, 32
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    addi a1, zero, 6
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    andi sp, sp, -32
; CHECK-NEXT:    addi sp, s0, -32
; CHECK-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 32
; CHECK-NEXT:    ret
  %v1 = alloca <vscale x 4 x i64>
  %v2 = alloca <vscale x 2 x i64>
  ret void
}

define void @lmul4_and_2_x2_0() nounwind {
; CHECK-LABEL: lmul4_and_2_x2_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -32
; CHECK-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; CHECK-NEXT:    addi s0, sp, 32
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    addi a1, zero, 12
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    andi sp, sp, -32
; CHECK-NEXT:    addi sp, s0, -32
; CHECK-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 32
; CHECK-NEXT:    ret
  %v1 = alloca <vscale x 4 x i64>
  %v2 = alloca <vscale x 2 x i64>
  %v3 = alloca <vscale x 4 x i64>
  %v4 = alloca <vscale x 2 x i64>
  ret void
}

define void @lmul4_and_2_x2_1() nounwind {
; CHECK-LABEL: lmul4_and_2_x2_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -32
; CHECK-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; CHECK-NEXT:    addi s0, sp, 32
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    addi a1, zero, 12
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    andi sp, sp, -32
; CHECK-NEXT:    addi sp, s0, -32
; CHECK-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 32
; CHECK-NEXT:    ret
  %v1 = alloca <vscale x 4 x i64>
  %v3 = alloca <vscale x 4 x i64>
  %v2 = alloca <vscale x 2 x i64>
  %v4 = alloca <vscale x 2 x i64>
  ret void
}


define void @gpr_and_lmul1_and_2() nounwind {
; CHECK-LABEL: gpr_and_lmul1_and_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -32
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a1, a0, 1
; CHECK-NEXT:    add a0, a1, a0
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    addi a0, zero, 3
; CHECK-NEXT:    sd a0, 24(sp)
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a1, a0, 1
; CHECK-NEXT:    add a0, a1, a0
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 32
; CHECK-NEXT:    ret
  %x1 = alloca i64
  %v1 = alloca <vscale x 1 x i64>
  %v2 = alloca <vscale x 2 x i64>
  store volatile i64 3, i64* %x1
  ret void
}

define void @gpr_and_lmul1_and_4() nounwind {
; CHECK-LABEL: gpr_and_lmul1_and_4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -64
; CHECK-NEXT:    sd ra, 56(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s0, 48(sp) # 8-byte Folded Spill
; CHECK-NEXT:    addi s0, sp, 64
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a1, a0, 2
; CHECK-NEXT:    add a0, a1, a0
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    andi sp, sp, -32
; CHECK-NEXT:    addi a0, zero, 3
; CHECK-NEXT:    sd a0, 40(sp)
; CHECK-NEXT:    addi sp, s0, -64
; CHECK-NEXT:    ld s0, 48(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld ra, 56(sp) # 8-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 64
; CHECK-NEXT:    ret
  %x1 = alloca i64
  %v1 = alloca <vscale x 1 x i64>
  %v2 = alloca <vscale x 4 x i64>
  store volatile i64 3, i64* %x1
  ret void
}

define void @lmul_1_2_4_8() nounwind {
; CHECK-LABEL: lmul_1_2_4_8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -64
; CHECK-NEXT:    sd ra, 56(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s0, 48(sp) # 8-byte Folded Spill
; CHECK-NEXT:    addi s0, sp, 64
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a1, a0, vl
; CHECK-NEXT:    sub a0, a1, a0
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    andi sp, sp, -64
; CHECK-NEXT:    addi sp, s0, -64
; CHECK-NEXT:    ld s0, 48(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld ra, 56(sp) # 8-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 64
; CHECK-NEXT:    ret
  %v1 = alloca <vscale x 1 x i64>
  %v2 = alloca <vscale x 2 x i64>
  %v4 = alloca <vscale x 4 x i64>
  %v8 = alloca <vscale x 8 x i64>
  ret void
}

define void @lmul_1_2_4_8_x2_0() nounwind {
; CHECK-LABEL: lmul_1_2_4_8_x2_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -64
; CHECK-NEXT:    sd ra, 56(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s0, 48(sp) # 8-byte Folded Spill
; CHECK-NEXT:    addi s0, sp, 64
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    addi a1, zero, 30
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    andi sp, sp, -64
; CHECK-NEXT:    addi sp, s0, -64
; CHECK-NEXT:    ld s0, 48(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld ra, 56(sp) # 8-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 64
; CHECK-NEXT:    ret
  %v1 = alloca <vscale x 1 x i64>
  %v2 = alloca <vscale x 1 x i64>
  %v3 = alloca <vscale x 2 x i64>
  %v4 = alloca <vscale x 2 x i64>
  %v5 = alloca <vscale x 4 x i64>
  %v6 = alloca <vscale x 4 x i64>
  %v7 = alloca <vscale x 8 x i64>
  %v8 = alloca <vscale x 8 x i64>
  ret void
}

define void @lmul_1_2_4_8_x2_1() nounwind {
; CHECK-LABEL: lmul_1_2_4_8_x2_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -64
; CHECK-NEXT:    sd ra, 56(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s0, 48(sp) # 8-byte Folded Spill
; CHECK-NEXT:    addi s0, sp, 64
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    addi a1, zero, 30
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    andi sp, sp, -64
; CHECK-NEXT:    addi sp, s0, -64
; CHECK-NEXT:    ld s0, 48(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld ra, 56(sp) # 8-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 64
; CHECK-NEXT:    ret
  %v8 = alloca <vscale x 8 x i64>
  %v7 = alloca <vscale x 8 x i64>
  %v6 = alloca <vscale x 4 x i64>
  %v5 = alloca <vscale x 4 x i64>
  %v4 = alloca <vscale x 2 x i64>
  %v3 = alloca <vscale x 2 x i64>
  %v2 = alloca <vscale x 1 x i64>
  %v1 = alloca <vscale x 1 x i64>
  ret void
}

define void @masks() nounwind {
; CHECK-LABEL: masks:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 2
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 2
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %v1 = alloca <vscale x 1 x i1>
  %v2 = alloca <vscale x 2 x i1>
  %v4 = alloca <vscale x 4 x i1>
  %v8 = alloca <vscale x 8 x i1>
  ret void
}