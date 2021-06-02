; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-- -x86-asm-syntax=att -mattr=-sse2 | FileCheck %s

define fastcc double @sint64_to_fp(i64 %X) {
; CHECK-LABEL: sint64_to_fp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushl %ebp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    .cfi_offset %ebp, -8
; CHECK-NEXT:    movl %esp, %ebp
; CHECK-NEXT:    .cfi_def_cfa_register %ebp
; CHECK-NEXT:    andl $-8, %esp
; CHECK-NEXT:    subl $8, %esp
; CHECK-NEXT:    movl %edx, {{[0-9]+}}(%esp)
; CHECK-NEXT:    movl %ecx, (%esp)
; CHECK-NEXT:    fildll (%esp)
; CHECK-NEXT:    movl %ebp, %esp
; CHECK-NEXT:    popl %ebp
; CHECK-NEXT:    .cfi_def_cfa %esp, 4
; CHECK-NEXT:    retl
        %R = sitofp i64 %X to double            ; <double> [#uses=1]
        ret double %R
}

define fastcc double @uint64_to_fp(i64 %X) {
; CHECK-LABEL: uint64_to_fp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushl %ebp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    .cfi_offset %ebp, -8
; CHECK-NEXT:    movl %esp, %ebp
; CHECK-NEXT:    .cfi_def_cfa_register %ebp
; CHECK-NEXT:    andl $-8, %esp
; CHECK-NEXT:    subl $16, %esp
; CHECK-NEXT:    movl %edx, {{[0-9]+}}(%esp)
; CHECK-NEXT:    movl %ecx, (%esp)
; CHECK-NEXT:    shrl $31, %edx
; CHECK-NEXT:    fildll (%esp)
; CHECK-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}(,%edx,4)
; CHECK-NEXT:    fstpl {{[0-9]+}}(%esp)
; CHECK-NEXT:    fldl {{[0-9]+}}(%esp)
; CHECK-NEXT:    movl %ebp, %esp
; CHECK-NEXT:    popl %ebp
; CHECK-NEXT:    .cfi_def_cfa %esp, 4
; CHECK-NEXT:    retl
        %R = uitofp i64 %X to double            ; <double> [#uses=1]
        ret double %R
}

