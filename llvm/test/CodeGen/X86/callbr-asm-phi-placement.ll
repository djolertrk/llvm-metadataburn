; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -verify-machineinstrs -O2 < %s | FileCheck %s

;; https://llvm.org/PR47468

;; PHI elimination should place copies BEFORE the inline asm, not
;; after, even if the inline-asm uses as an input the same value as
;; the PHI.

declare void @foo(i8*)

define void @test1(i8* %arg, i8** %mem) nounwind {
; CHECK-LABEL: test1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %r14
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    movq %rsi, %r14
; CHECK-NEXT:  .Ltmp0: # Block address taken
; CHECK-NEXT:  .LBB0_1: # %loop
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    movq (%r14), %rbx
; CHECK-NEXT:    callq foo
; CHECK-NEXT:    movq %rbx, %rdi
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:  # %bb.2: # %end
; CHECK-NEXT:    addq $8, %rsp
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    popq %r14
; CHECK-NEXT:    retq
entry:
  br label %loop

loop:
  %a = phi i8* [ %arg, %entry ], [ %b, %loop ]
  %b = load i8*, i8** %mem, align 8
  call void @foo(i8* %a)
  callbr void asm sideeffect "", "*m,X"(i8* %b, i8* blockaddress(@test1, %loop))
          to label %end [label %loop]

end:
  ret void
}
