; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I %s
; RUN: llc -mtriple=riscv32 -mattr=+m -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32IM %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64I %s
; RUN: llc -mtriple=riscv64 -mattr=+m -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64IM %s

define i32 @urem(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: urem:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __umodsi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: urem:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    remu a0, a0, a1
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: urem:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    slli a0, a0, 32
; RV64I-NEXT:    srli a0, a0, 32
; RV64I-NEXT:    slli a1, a1, 32
; RV64I-NEXT:    srli a1, a1, 32
; RV64I-NEXT:    call __umoddi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: urem:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define i32 @srem(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: srem:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __modsi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: srem:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    rem a0, a0, a1
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: srem:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    sext.w a1, a1
; RV64I-NEXT:    call __moddi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: srem:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define i64 @urem64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: urem64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __umoddi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: urem64:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    addi sp, sp, -16
; RV32IM-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IM-NEXT:    call __umoddi3@plt
; RV32IM-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IM-NEXT:    addi sp, sp, 16
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: urem64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __umoddi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: urem64:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remu a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i64 %a, %b
  ret i64 %1
}

define i64 @srem64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: srem64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __moddi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: srem64:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    addi sp, sp, -16
; RV32IM-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IM-NEXT:    call __moddi3@plt
; RV32IM-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IM-NEXT:    addi sp, sp, 16
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: srem64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __moddi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: srem64:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    rem a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i64 %a, %b
  ret i64 %1
}

define i8 @urem8(i8 %a, i8 %b) nounwind {
; RV32I-LABEL: urem8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    andi a0, a0, 255
; RV32I-NEXT:    andi a1, a1, 255
; RV32I-NEXT:    call __umodsi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: urem8:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    andi a1, a1, 255
; RV32IM-NEXT:    andi a0, a0, 255
; RV32IM-NEXT:    remu a0, a0, a1
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: urem8:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    andi a0, a0, 255
; RV64I-NEXT:    andi a1, a1, 255
; RV64I-NEXT:    call __umoddi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: urem8:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    andi a1, a1, 255
; RV64IM-NEXT:    andi a0, a0, 255
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i8 %a, %b
  ret i8 %1
}

define i8 @srem8(i8 %a, i8 %b) nounwind {
; RV32I-LABEL: srem8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    slli a0, a0, 24
; RV32I-NEXT:    srai a0, a0, 24
; RV32I-NEXT:    slli a1, a1, 24
; RV32I-NEXT:    srai a1, a1, 24
; RV32I-NEXT:    call __modsi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: srem8:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    slli a1, a1, 24
; RV32IM-NEXT:    srai a1, a1, 24
; RV32IM-NEXT:    slli a0, a0, 24
; RV32IM-NEXT:    srai a0, a0, 24
; RV32IM-NEXT:    rem a0, a0, a1
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: srem8:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    slli a0, a0, 56
; RV64I-NEXT:    srai a0, a0, 56
; RV64I-NEXT:    slli a1, a1, 56
; RV64I-NEXT:    srai a1, a1, 56
; RV64I-NEXT:    call __moddi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: srem8:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    slli a1, a1, 56
; RV64IM-NEXT:    srai a1, a1, 56
; RV64IM-NEXT:    slli a0, a0, 56
; RV64IM-NEXT:    srai a0, a0, 56
; RV64IM-NEXT:    rem a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i8 %a, %b
  ret i8 %1
}

define i16 @urem16(i16 %a, i16 %b) nounwind {
; RV32I-LABEL: urem16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    lui a2, 16
; RV32I-NEXT:    addi a2, a2, -1
; RV32I-NEXT:    and a0, a0, a2
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    call __umodsi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: urem16:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    lui a2, 16
; RV32IM-NEXT:    addi a2, a2, -1
; RV32IM-NEXT:    and a1, a1, a2
; RV32IM-NEXT:    and a0, a0, a2
; RV32IM-NEXT:    remu a0, a0, a1
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: urem16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    lui a2, 16
; RV64I-NEXT:    addiw a2, a2, -1
; RV64I-NEXT:    and a0, a0, a2
; RV64I-NEXT:    and a1, a1, a2
; RV64I-NEXT:    call __umoddi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: urem16:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    lui a2, 16
; RV64IM-NEXT:    addiw a2, a2, -1
; RV64IM-NEXT:    and a1, a1, a2
; RV64IM-NEXT:    and a0, a0, a2
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i16 %a, %b
  ret i16 %1
}

define i16 @srem16(i16 %a, i16 %b) nounwind {
; RV32I-LABEL: srem16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    srai a0, a0, 16
; RV32I-NEXT:    slli a1, a1, 16
; RV32I-NEXT:    srai a1, a1, 16
; RV32I-NEXT:    call __modsi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: srem16:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    slli a1, a1, 16
; RV32IM-NEXT:    srai a1, a1, 16
; RV32IM-NEXT:    slli a0, a0, 16
; RV32IM-NEXT:    srai a0, a0, 16
; RV32IM-NEXT:    rem a0, a0, a1
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: srem16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srai a0, a0, 48
; RV64I-NEXT:    slli a1, a1, 48
; RV64I-NEXT:    srai a1, a1, 48
; RV64I-NEXT:    call __moddi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: srem16:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    slli a1, a1, 48
; RV64IM-NEXT:    srai a1, a1, 48
; RV64IM-NEXT:    slli a0, a0, 48
; RV64IM-NEXT:    srai a0, a0, 48
; RV64IM-NEXT:    rem a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i16 %a, %b
  ret i16 %1
}
