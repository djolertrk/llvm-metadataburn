; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -limit-float-precision=6 -mtriple=i686-- | FileCheck %s --check-prefix=precision6
; RUN: llc < %s -limit-float-precision=12 -mtriple=i686-- | FileCheck %s --check-prefix=precision12
; RUN: llc < %s -limit-float-precision=18 -mtriple=i686-- | FileCheck %s --check-prefix=precision18

define float @f1(float %x) nounwind noinline {
; precision6-LABEL: f1:
; precision6:       # %bb.0: # %entry
; precision6-NEXT:    subl $20, %esp
; precision6-NEXT:    flds {{[0-9]+}}(%esp)
; precision6-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    fnstcw (%esp)
; precision6-NEXT:    movzwl (%esp), %eax
; precision6-NEXT:    orl $3072, %eax # imm = 0xC00
; precision6-NEXT:    movw %ax, {{[0-9]+}}(%esp)
; precision6-NEXT:    fldcw {{[0-9]+}}(%esp)
; precision6-NEXT:    fistl {{[0-9]+}}(%esp)
; precision6-NEXT:    fldcw (%esp)
; precision6-NEXT:    movl {{[0-9]+}}(%esp), %eax
; precision6-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision6-NEXT:    fisubl {{[0-9]+}}(%esp)
; precision6-NEXT:    fld %st(0)
; precision6-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    fmulp %st, %st(1)
; precision6-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    fstps {{[0-9]+}}(%esp)
; precision6-NEXT:    shll $23, %eax
; precision6-NEXT:    addl {{[0-9]+}}(%esp), %eax
; precision6-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision6-NEXT:    flds {{[0-9]+}}(%esp)
; precision6-NEXT:    addl $20, %esp
; precision6-NEXT:    retl
;
; precision12-LABEL: f1:
; precision12:       # %bb.0: # %entry
; precision12-NEXT:    subl $20, %esp
; precision12-NEXT:    flds {{[0-9]+}}(%esp)
; precision12-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fnstcw (%esp)
; precision12-NEXT:    movzwl (%esp), %eax
; precision12-NEXT:    orl $3072, %eax # imm = 0xC00
; precision12-NEXT:    movw %ax, {{[0-9]+}}(%esp)
; precision12-NEXT:    fldcw {{[0-9]+}}(%esp)
; precision12-NEXT:    fistl {{[0-9]+}}(%esp)
; precision12-NEXT:    fldcw (%esp)
; precision12-NEXT:    movl {{[0-9]+}}(%esp), %eax
; precision12-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision12-NEXT:    fisubl {{[0-9]+}}(%esp)
; precision12-NEXT:    fld %st(0)
; precision12-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fmul %st(1), %st
; precision12-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fmulp %st, %st(1)
; precision12-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fstps {{[0-9]+}}(%esp)
; precision12-NEXT:    shll $23, %eax
; precision12-NEXT:    addl {{[0-9]+}}(%esp), %eax
; precision12-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision12-NEXT:    flds {{[0-9]+}}(%esp)
; precision12-NEXT:    addl $20, %esp
; precision12-NEXT:    retl
;
; precision18-LABEL: f1:
; precision18:       # %bb.0: # %entry
; precision18-NEXT:    subl $20, %esp
; precision18-NEXT:    flds {{[0-9]+}}(%esp)
; precision18-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fnstcw (%esp)
; precision18-NEXT:    movzwl (%esp), %eax
; precision18-NEXT:    orl $3072, %eax # imm = 0xC00
; precision18-NEXT:    movw %ax, {{[0-9]+}}(%esp)
; precision18-NEXT:    fldcw {{[0-9]+}}(%esp)
; precision18-NEXT:    fistl {{[0-9]+}}(%esp)
; precision18-NEXT:    fldcw (%esp)
; precision18-NEXT:    movl {{[0-9]+}}(%esp), %eax
; precision18-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision18-NEXT:    fisubl {{[0-9]+}}(%esp)
; precision18-NEXT:    fld %st(0)
; precision18-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmulp %st, %st(1)
; precision18-NEXT:    fld1
; precision18-NEXT:    faddp %st, %st(1)
; precision18-NEXT:    fstps {{[0-9]+}}(%esp)
; precision18-NEXT:    shll $23, %eax
; precision18-NEXT:    addl {{[0-9]+}}(%esp), %eax
; precision18-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision18-NEXT:    flds {{[0-9]+}}(%esp)
; precision18-NEXT:    addl $20, %esp
; precision18-NEXT:    retl
entry:
	%"alloca point" = bitcast i32 0 to i32		; <i32> [#uses=0]
	%0 = call float @llvm.exp.f32(float %x)		; <float> [#uses=1]
	ret float %0
}

declare float @llvm.exp.f32(float) nounwind readonly

define float @f2(float %x) nounwind noinline {
; precision6-LABEL: f2:
; precision6:       # %bb.0: # %entry
; precision6-NEXT:    subl $20, %esp
; precision6-NEXT:    flds {{[0-9]+}}(%esp)
; precision6-NEXT:    fnstcw (%esp)
; precision6-NEXT:    movzwl (%esp), %eax
; precision6-NEXT:    orl $3072, %eax # imm = 0xC00
; precision6-NEXT:    movw %ax, {{[0-9]+}}(%esp)
; precision6-NEXT:    fldcw {{[0-9]+}}(%esp)
; precision6-NEXT:    fistl {{[0-9]+}}(%esp)
; precision6-NEXT:    fldcw (%esp)
; precision6-NEXT:    movl {{[0-9]+}}(%esp), %eax
; precision6-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision6-NEXT:    fisubl {{[0-9]+}}(%esp)
; precision6-NEXT:    fld %st(0)
; precision6-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    fmulp %st, %st(1)
; precision6-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    fstps {{[0-9]+}}(%esp)
; precision6-NEXT:    shll $23, %eax
; precision6-NEXT:    addl {{[0-9]+}}(%esp), %eax
; precision6-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision6-NEXT:    flds {{[0-9]+}}(%esp)
; precision6-NEXT:    addl $20, %esp
; precision6-NEXT:    retl
;
; precision12-LABEL: f2:
; precision12:       # %bb.0: # %entry
; precision12-NEXT:    subl $20, %esp
; precision12-NEXT:    flds {{[0-9]+}}(%esp)
; precision12-NEXT:    fnstcw (%esp)
; precision12-NEXT:    movzwl (%esp), %eax
; precision12-NEXT:    orl $3072, %eax # imm = 0xC00
; precision12-NEXT:    movw %ax, {{[0-9]+}}(%esp)
; precision12-NEXT:    fldcw {{[0-9]+}}(%esp)
; precision12-NEXT:    fistl {{[0-9]+}}(%esp)
; precision12-NEXT:    fldcw (%esp)
; precision12-NEXT:    movl {{[0-9]+}}(%esp), %eax
; precision12-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision12-NEXT:    fisubl {{[0-9]+}}(%esp)
; precision12-NEXT:    fld %st(0)
; precision12-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fmul %st(1), %st
; precision12-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fmulp %st, %st(1)
; precision12-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fstps {{[0-9]+}}(%esp)
; precision12-NEXT:    shll $23, %eax
; precision12-NEXT:    addl {{[0-9]+}}(%esp), %eax
; precision12-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision12-NEXT:    flds {{[0-9]+}}(%esp)
; precision12-NEXT:    addl $20, %esp
; precision12-NEXT:    retl
;
; precision18-LABEL: f2:
; precision18:       # %bb.0: # %entry
; precision18-NEXT:    subl $20, %esp
; precision18-NEXT:    flds {{[0-9]+}}(%esp)
; precision18-NEXT:    fnstcw (%esp)
; precision18-NEXT:    movzwl (%esp), %eax
; precision18-NEXT:    orl $3072, %eax # imm = 0xC00
; precision18-NEXT:    movw %ax, {{[0-9]+}}(%esp)
; precision18-NEXT:    fldcw {{[0-9]+}}(%esp)
; precision18-NEXT:    fistl {{[0-9]+}}(%esp)
; precision18-NEXT:    fldcw (%esp)
; precision18-NEXT:    movl {{[0-9]+}}(%esp), %eax
; precision18-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision18-NEXT:    fisubl {{[0-9]+}}(%esp)
; precision18-NEXT:    fld %st(0)
; precision18-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmulp %st, %st(1)
; precision18-NEXT:    fld1
; precision18-NEXT:    faddp %st, %st(1)
; precision18-NEXT:    fstps {{[0-9]+}}(%esp)
; precision18-NEXT:    shll $23, %eax
; precision18-NEXT:    addl {{[0-9]+}}(%esp), %eax
; precision18-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision18-NEXT:    flds {{[0-9]+}}(%esp)
; precision18-NEXT:    addl $20, %esp
; precision18-NEXT:    retl
entry:
	%"alloca point" = bitcast i32 0 to i32		; <i32> [#uses=0]
	%0 = call float @llvm.exp2.f32(float %x)		; <float> [#uses=1]
	ret float %0
}

declare float @llvm.exp2.f32(float) nounwind readonly

define float @f3(float %x) nounwind noinline {
; precision6-LABEL: f3:
; precision6:       # %bb.0: # %entry
; precision6-NEXT:    subl $20, %esp
; precision6-NEXT:    flds {{[0-9]+}}(%esp)
; precision6-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    fnstcw (%esp)
; precision6-NEXT:    movzwl (%esp), %eax
; precision6-NEXT:    orl $3072, %eax # imm = 0xC00
; precision6-NEXT:    movw %ax, {{[0-9]+}}(%esp)
; precision6-NEXT:    fldcw {{[0-9]+}}(%esp)
; precision6-NEXT:    fistl {{[0-9]+}}(%esp)
; precision6-NEXT:    fldcw (%esp)
; precision6-NEXT:    movl {{[0-9]+}}(%esp), %eax
; precision6-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision6-NEXT:    fisubl {{[0-9]+}}(%esp)
; precision6-NEXT:    fld %st(0)
; precision6-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    fmulp %st, %st(1)
; precision6-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    fstps {{[0-9]+}}(%esp)
; precision6-NEXT:    shll $23, %eax
; precision6-NEXT:    addl {{[0-9]+}}(%esp), %eax
; precision6-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision6-NEXT:    flds {{[0-9]+}}(%esp)
; precision6-NEXT:    addl $20, %esp
; precision6-NEXT:    retl
;
; precision12-LABEL: f3:
; precision12:       # %bb.0: # %entry
; precision12-NEXT:    subl $20, %esp
; precision12-NEXT:    flds {{[0-9]+}}(%esp)
; precision12-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fnstcw (%esp)
; precision12-NEXT:    movzwl (%esp), %eax
; precision12-NEXT:    orl $3072, %eax # imm = 0xC00
; precision12-NEXT:    movw %ax, {{[0-9]+}}(%esp)
; precision12-NEXT:    fldcw {{[0-9]+}}(%esp)
; precision12-NEXT:    fistl {{[0-9]+}}(%esp)
; precision12-NEXT:    fldcw (%esp)
; precision12-NEXT:    movl {{[0-9]+}}(%esp), %eax
; precision12-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision12-NEXT:    fisubl {{[0-9]+}}(%esp)
; precision12-NEXT:    fld %st(0)
; precision12-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fmul %st(1), %st
; precision12-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fmulp %st, %st(1)
; precision12-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fstps {{[0-9]+}}(%esp)
; precision12-NEXT:    shll $23, %eax
; precision12-NEXT:    addl {{[0-9]+}}(%esp), %eax
; precision12-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision12-NEXT:    flds {{[0-9]+}}(%esp)
; precision12-NEXT:    addl $20, %esp
; precision12-NEXT:    retl
;
; precision18-LABEL: f3:
; precision18:       # %bb.0: # %entry
; precision18-NEXT:    subl $20, %esp
; precision18-NEXT:    flds {{[0-9]+}}(%esp)
; precision18-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fnstcw (%esp)
; precision18-NEXT:    movzwl (%esp), %eax
; precision18-NEXT:    orl $3072, %eax # imm = 0xC00
; precision18-NEXT:    movw %ax, {{[0-9]+}}(%esp)
; precision18-NEXT:    fldcw {{[0-9]+}}(%esp)
; precision18-NEXT:    fistl {{[0-9]+}}(%esp)
; precision18-NEXT:    fldcw (%esp)
; precision18-NEXT:    movl {{[0-9]+}}(%esp), %eax
; precision18-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision18-NEXT:    fisubl {{[0-9]+}}(%esp)
; precision18-NEXT:    fld %st(0)
; precision18-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmulp %st, %st(1)
; precision18-NEXT:    fld1
; precision18-NEXT:    faddp %st, %st(1)
; precision18-NEXT:    fstps {{[0-9]+}}(%esp)
; precision18-NEXT:    shll $23, %eax
; precision18-NEXT:    addl {{[0-9]+}}(%esp), %eax
; precision18-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision18-NEXT:    flds {{[0-9]+}}(%esp)
; precision18-NEXT:    addl $20, %esp
; precision18-NEXT:    retl
entry:
	%"alloca point" = bitcast i32 0 to i32		; <i32> [#uses=0]
	%0 = call float @llvm.pow.f32(float 1.000000e+01, float %x)		; <float> [#uses=1]
	ret float %0
}

declare float @llvm.pow.f32(float, float) nounwind readonly

define float @f4(float %x) nounwind noinline {
; precision6-LABEL: f4:
; precision6:       # %bb.0: # %entry
; precision6-NEXT:    subl $8, %esp
; precision6-NEXT:    movl {{[0-9]+}}(%esp), %eax
; precision6-NEXT:    movl %eax, %ecx
; precision6-NEXT:    andl $8388607, %ecx # imm = 0x7FFFFF
; precision6-NEXT:    orl $1065353216, %ecx # imm = 0x3F800000
; precision6-NEXT:    movl %ecx, (%esp)
; precision6-NEXT:    andl $2139095040, %eax # imm = 0x7F800000
; precision6-NEXT:    shrl $23, %eax
; precision6-NEXT:    addl $-127, %eax
; precision6-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision6-NEXT:    flds (%esp)
; precision6-NEXT:    fld %st(0)
; precision6-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    fmulp %st, %st(1)
; precision6-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    fildl {{[0-9]+}}(%esp)
; precision6-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    faddp %st, %st(1)
; precision6-NEXT:    addl $8, %esp
; precision6-NEXT:    retl
;
; precision12-LABEL: f4:
; precision12:       # %bb.0: # %entry
; precision12-NEXT:    subl $8, %esp
; precision12-NEXT:    movl {{[0-9]+}}(%esp), %eax
; precision12-NEXT:    movl %eax, %ecx
; precision12-NEXT:    andl $8388607, %ecx # imm = 0x7FFFFF
; precision12-NEXT:    orl $1065353216, %ecx # imm = 0x3F800000
; precision12-NEXT:    movl %ecx, (%esp)
; precision12-NEXT:    andl $2139095040, %eax # imm = 0x7F800000
; precision12-NEXT:    shrl $23, %eax
; precision12-NEXT:    addl $-127, %eax
; precision12-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision12-NEXT:    flds (%esp)
; precision12-NEXT:    fld %st(0)
; precision12-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fmul %st(1), %st
; precision12-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fmul %st(1), %st
; precision12-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fmulp %st, %st(1)
; precision12-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fildl {{[0-9]+}}(%esp)
; precision12-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    faddp %st, %st(1)
; precision12-NEXT:    addl $8, %esp
; precision12-NEXT:    retl
;
; precision18-LABEL: f4:
; precision18:       # %bb.0: # %entry
; precision18-NEXT:    subl $8, %esp
; precision18-NEXT:    movl {{[0-9]+}}(%esp), %eax
; precision18-NEXT:    movl %eax, %ecx
; precision18-NEXT:    andl $8388607, %ecx # imm = 0x7FFFFF
; precision18-NEXT:    orl $1065353216, %ecx # imm = 0x3F800000
; precision18-NEXT:    movl %ecx, (%esp)
; precision18-NEXT:    andl $2139095040, %eax # imm = 0x7F800000
; precision18-NEXT:    shrl $23, %eax
; precision18-NEXT:    addl $-127, %eax
; precision18-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision18-NEXT:    flds (%esp)
; precision18-NEXT:    fld %st(0)
; precision18-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmulp %st, %st(1)
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fildl {{[0-9]+}}(%esp)
; precision18-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    faddp %st, %st(1)
; precision18-NEXT:    addl $8, %esp
; precision18-NEXT:    retl
entry:
	%"alloca point" = bitcast i32 0 to i32		; <i32> [#uses=0]
	%0 = call float @llvm.log.f32(float %x)		; <float> [#uses=1]
	ret float %0
}

declare float @llvm.log.f32(float) nounwind readonly

define float @f5(float %x) nounwind noinline {
; precision6-LABEL: f5:
; precision6:       # %bb.0: # %entry
; precision6-NEXT:    subl $8, %esp
; precision6-NEXT:    movl {{[0-9]+}}(%esp), %eax
; precision6-NEXT:    movl %eax, %ecx
; precision6-NEXT:    andl $8388607, %ecx # imm = 0x7FFFFF
; precision6-NEXT:    orl $1065353216, %ecx # imm = 0x3F800000
; precision6-NEXT:    movl %ecx, (%esp)
; precision6-NEXT:    andl $2139095040, %eax # imm = 0x7F800000
; precision6-NEXT:    shrl $23, %eax
; precision6-NEXT:    addl $-127, %eax
; precision6-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision6-NEXT:    flds (%esp)
; precision6-NEXT:    fld %st(0)
; precision6-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    fmulp %st, %st(1)
; precision6-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    fiaddl {{[0-9]+}}(%esp)
; precision6-NEXT:    addl $8, %esp
; precision6-NEXT:    retl
;
; precision12-LABEL: f5:
; precision12:       # %bb.0: # %entry
; precision12-NEXT:    subl $8, %esp
; precision12-NEXT:    movl {{[0-9]+}}(%esp), %eax
; precision12-NEXT:    movl %eax, %ecx
; precision12-NEXT:    andl $8388607, %ecx # imm = 0x7FFFFF
; precision12-NEXT:    orl $1065353216, %ecx # imm = 0x3F800000
; precision12-NEXT:    movl %ecx, (%esp)
; precision12-NEXT:    andl $2139095040, %eax # imm = 0x7F800000
; precision12-NEXT:    shrl $23, %eax
; precision12-NEXT:    addl $-127, %eax
; precision12-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision12-NEXT:    flds (%esp)
; precision12-NEXT:    fld %st(0)
; precision12-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fmul %st(1), %st
; precision12-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fmul %st(1), %st
; precision12-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fmulp %st, %st(1)
; precision12-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fiaddl {{[0-9]+}}(%esp)
; precision12-NEXT:    addl $8, %esp
; precision12-NEXT:    retl
;
; precision18-LABEL: f5:
; precision18:       # %bb.0: # %entry
; precision18-NEXT:    subl $8, %esp
; precision18-NEXT:    movl {{[0-9]+}}(%esp), %eax
; precision18-NEXT:    movl %eax, %ecx
; precision18-NEXT:    andl $8388607, %ecx # imm = 0x7FFFFF
; precision18-NEXT:    orl $1065353216, %ecx # imm = 0x3F800000
; precision18-NEXT:    movl %ecx, (%esp)
; precision18-NEXT:    andl $2139095040, %eax # imm = 0x7F800000
; precision18-NEXT:    shrl $23, %eax
; precision18-NEXT:    addl $-127, %eax
; precision18-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision18-NEXT:    flds (%esp)
; precision18-NEXT:    fld %st(0)
; precision18-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmulp %st, %st(1)
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fiaddl {{[0-9]+}}(%esp)
; precision18-NEXT:    addl $8, %esp
; precision18-NEXT:    retl
entry:
	%"alloca point" = bitcast i32 0 to i32		; <i32> [#uses=0]
	%0 = call float @llvm.log2.f32(float %x)		; <float> [#uses=1]
	ret float %0
}

declare float @llvm.log2.f32(float) nounwind readonly

define float @f6(float %x) nounwind noinline {
; precision6-LABEL: f6:
; precision6:       # %bb.0: # %entry
; precision6-NEXT:    subl $8, %esp
; precision6-NEXT:    movl {{[0-9]+}}(%esp), %eax
; precision6-NEXT:    movl %eax, %ecx
; precision6-NEXT:    andl $8388607, %ecx # imm = 0x7FFFFF
; precision6-NEXT:    orl $1065353216, %ecx # imm = 0x3F800000
; precision6-NEXT:    movl %ecx, (%esp)
; precision6-NEXT:    andl $2139095040, %eax # imm = 0x7F800000
; precision6-NEXT:    shrl $23, %eax
; precision6-NEXT:    addl $-127, %eax
; precision6-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision6-NEXT:    flds (%esp)
; precision6-NEXT:    fld %st(0)
; precision6-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    fmulp %st, %st(1)
; precision6-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    fildl {{[0-9]+}}(%esp)
; precision6-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision6-NEXT:    faddp %st, %st(1)
; precision6-NEXT:    addl $8, %esp
; precision6-NEXT:    retl
;
; precision12-LABEL: f6:
; precision12:       # %bb.0: # %entry
; precision12-NEXT:    subl $8, %esp
; precision12-NEXT:    movl {{[0-9]+}}(%esp), %eax
; precision12-NEXT:    movl %eax, %ecx
; precision12-NEXT:    andl $8388607, %ecx # imm = 0x7FFFFF
; precision12-NEXT:    orl $1065353216, %ecx # imm = 0x3F800000
; precision12-NEXT:    movl %ecx, (%esp)
; precision12-NEXT:    andl $2139095040, %eax # imm = 0x7F800000
; precision12-NEXT:    shrl $23, %eax
; precision12-NEXT:    addl $-127, %eax
; precision12-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision12-NEXT:    flds (%esp)
; precision12-NEXT:    fld %st(0)
; precision12-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fmul %st(1), %st
; precision12-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fmulp %st, %st(1)
; precision12-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    fildl {{[0-9]+}}(%esp)
; precision12-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision12-NEXT:    faddp %st, %st(1)
; precision12-NEXT:    addl $8, %esp
; precision12-NEXT:    retl
;
; precision18-LABEL: f6:
; precision18:       # %bb.0: # %entry
; precision18-NEXT:    subl $8, %esp
; precision18-NEXT:    movl {{[0-9]+}}(%esp), %eax
; precision18-NEXT:    movl %eax, %ecx
; precision18-NEXT:    andl $8388607, %ecx # imm = 0x7FFFFF
; precision18-NEXT:    orl $1065353216, %ecx # imm = 0x3F800000
; precision18-NEXT:    movl %ecx, (%esp)
; precision18-NEXT:    andl $2139095040, %eax # imm = 0x7F800000
; precision18-NEXT:    shrl $23, %eax
; precision18-NEXT:    addl $-127, %eax
; precision18-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; precision18-NEXT:    flds (%esp)
; precision18-NEXT:    fld %st(0)
; precision18-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmul %st(1), %st
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fmulp %st, %st(1)
; precision18-NEXT:    fadds {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    fildl {{[0-9]+}}(%esp)
; precision18-NEXT:    fmuls {{\.LCPI[0-9]+_[0-9]+}}
; precision18-NEXT:    faddp %st, %st(1)
; precision18-NEXT:    addl $8, %esp
; precision18-NEXT:    retl
entry:
	%"alloca point" = bitcast i32 0 to i32		; <i32> [#uses=0]
	%0 = call float @llvm.log10.f32(float %x)		; <float> [#uses=1]
	ret float %0
}

declare float @llvm.log10.f32(float) nounwind readonly
