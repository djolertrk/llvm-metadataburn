; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -loop-reduce < %s | FileCheck %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @use(i8 zeroext)
declare void @use_p(i8*)

; nuw needs to be dropped when switching to post-inc comparison.
define i8 @drop_nuw() {
; CHECK-LABEL: @drop_nuw(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i8 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    call void @use(i8 [[IV]])
; CHECK-NEXT:    [[IV_NEXT]] = add i8 [[IV]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[IV_NEXT]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    [[TMP0:%.*]] = add i8 [[IV_NEXT]], -1
; CHECK-NEXT:    ret i8 [[TMP0]]
;
entry:
  br label %loop

loop:
  %iv = phi i8 [ 0, %entry ], [ %iv.next, %loop ]
  call void @use(i8 %iv)

  %iv.next = add nuw i8 %iv, 1
  %cmp = icmp eq i8 %iv, -1
  br i1 %cmp, label %exit, label %loop

exit:
  ret i8 %iv
}

; nsw needs to be dropped when switching to post-inc comparison.
define i8 @drop_nsw() {
; CHECK-LABEL: @drop_nsw(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i8 [ 127, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    call void @use(i8 [[IV]])
; CHECK-NEXT:    [[IV_NEXT]] = add i8 [[IV]], -1
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[IV_NEXT]], 127
; CHECK-NEXT:    br i1 [[CMP]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    [[TMP0:%.*]] = add i8 [[IV_NEXT]], 1
; CHECK-NEXT:    ret i8 [[TMP0]]
;
entry:
  br label %loop

loop:
  %iv = phi i8 [ 127, %entry ], [ %iv.next, %loop ]
  call void @use(i8 %iv)

  %iv.next = add nsw i8 %iv, -1
  %cmp = icmp eq i8 %iv, -128
  br i1 %cmp, label %exit, label %loop

exit:
  ret i8 %iv
}

; Comparison already in post-inc form, no need to drop nuw.
define i8 @already_postinc() {
; CHECK-LABEL: @already_postinc(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i8 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    call void @use(i8 [[IV]])
; CHECK-NEXT:    [[IV_NEXT]] = add nuw i8 [[IV]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[IV_NEXT]], -1
; CHECK-NEXT:    br i1 [[CMP]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    [[TMP0:%.*]] = add i8 [[IV_NEXT]], -1
; CHECK-NEXT:    ret i8 [[TMP0]]
;
entry:
  br label %loop

loop:
  %iv = phi i8 [ 0, %entry ], [ %iv.next, %loop ]
  call void @use(i8 %iv)

  %iv.next = add nuw i8 %iv, 1
  %cmp = icmp eq i8 %iv.next, -1
  br i1 %cmp, label %exit, label %loop

exit:
  ret i8 %iv
}
