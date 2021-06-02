; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-linux | FileCheck -check-prefix=X64 %s
; Win64 has not supported byval yet.
; RUN: llc < %s -mtriple=i686-- | FileCheck -check-prefix=X86 %s

%struct.s = type { i64, i64, i64 }

define i64 @f(%struct.s* byval(%struct.s) %a) {
; X64-LABEL: f:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movq 8(%rsp), %rax
; X64-NEXT:    retq
;
; X86-LABEL: f:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl 4(%esp), %eax
; X86-NEXT:    movl 8(%esp), %edx
; X86-NEXT:    retl
entry:
	%tmp2 = getelementptr %struct.s, %struct.s* %a, i32 0, i32 0
	%tmp3 = load i64, i64* %tmp2, align 8
	ret i64 %tmp3
}
