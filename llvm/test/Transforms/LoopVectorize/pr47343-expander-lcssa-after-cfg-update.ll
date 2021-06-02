; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -loop-vectorize -force-vector-width=2 %s -S | FileCheck %s

; Test case for PR47343. Make sure LCSSA phis are create correctly when
; expanding the memory runtime checks.

@f.e = external global i32, align 1
@d = external global i8*, align 1

declare i1 @cond()

define void @f() {
; CHECK-LABEL: @f(

; CHECK:       outer.header:
; CHECK-NEXT:    [[TMP0:%.*]] = load i8*, i8** @d, align 1
; CHECK-NEXT:    [[C_0:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[C_0]], label %outer.exit.0, label %inner.1.header.preheader

; CHECK:       outer.exit.0:
; CHECK-NEXT:    [[DOTLCSSA:%.*]] = phi i8* [ [[TMP0]], %outer.header ]
; CHECK-NEXT:    br label %loop.preheader

; CHECK:       outer.exit.1:
; CHECK-NEXT:    [[DOTLCSSA1:%.*]] = phi i8* [ [[TMP0]], %inner.1.latch ]
; CHECK-NEXT:    br label %loop.preheader

; CHECK:       loop.preheader:
; CHECK-NEXT:    [[TMP1:%.*]] = phi i8* [ [[DOTLCSSA]], %outer.exit.0 ], [ [[DOTLCSSA1]], %outer.exit.1 ]
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_MEMCHECK:%.*]]

; CHECK:       vector.memcheck:
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, i8* [[TMP1]], i64 1
; CHECK-NEXT:    [[BOUND0:%.*]] = icmp ult i8* bitcast (i32* @f.e to i8*), [[SCEVGEP]]
; CHECK-NEXT:    [[BOUND1:%.*]] = icmp ult i8* [[TMP0]], getelementptr (i8, i8* bitcast (i32* @f.e to i8*), i64 1)
; CHECK-NEXT:    [[FOUND_CONFLICT:%.*]] = and i1 [[BOUND0]], [[BOUND1]]
; CHECK-NEXT:    [[MEMCHECK_CONFLICT:%.*]] = and i1 [[FOUND_CONFLICT]], true
; CHECK-NEXT:    br i1 [[MEMCHECK_CONFLICT]], label [[SCALAR_PH]], label [[VECTOR_PH:%.*]]

; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]

; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP2:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    store i32 0, i32* @f.e, align 1, !alias.scope !0, !noalias !3
; CHECK-NEXT:    store i32 0, i32* @f.e, align 1, !alias.scope !0, !noalias !3
; CHECK-NEXT:    store i8 10, i8* [[TMP0]], align 1
; CHECK-NEXT:    store i8 10, i8* [[TMP0]], align 1
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 2
; CHECK-NEXT:    [[TMP3:%.*]] = icmp eq i32 [[INDEX_NEXT]], 500
; CHECK-NEXT:    br i1 [[TMP3]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], [[LOOP5:!llvm.loop !.*]]

; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i32 500, 500
; CHECK-NEXT:    br i1 [[CMP_N]], label [[EXIT:%.*]], label [[SCALAR_PH]]

; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ 500, %middle.block ], [ 0, %loop.preheader ], [ 0, %vector.memcheck ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
;
entry:
  br label %outer.header

outer.header:                            ; preds = %cleanup, %entry
  %0 = load i8*, i8** @d, align 1
  %c.0 = call i1 @cond()
  br i1 %c.0, label %outer.exit.0, label %inner.1.header

inner.1.header:                                         ; preds = %if.end, %for.body3.lr.ph.outer
  %c.1 = call i1 @cond()
  br i1 %c.1, label %inner.1.latch, label %outer.latch

inner.1.latch:                                           ; preds = %land.end
  %c.2 = call i1 @cond()
  br i1 %c.2, label %outer.exit.1, label %inner.1.header

outer.latch:                                          ; preds = %land.end
  br label %outer.header


outer.exit.0:                                         ; preds = %if.end, %if.end.us.us.us
  br label %loop

outer.exit.1:                                         ; preds = %if.end, %if.end.us.us.us
  br label %loop

loop:                                  ; preds = %if.end.us.us.us, %for.body3.lr.ph.outer
  %iv = phi i32 [ %iv.next, %loop ], [ 0, %outer.exit.0 ], [ 0, %outer.exit.1 ]
  %conv6.us.us.us = zext i1 false to i32
  store i32 %conv6.us.us.us, i32* @f.e, align 1
  store i8 10, i8* %0, align 1
  %iv.next = add nsw i32 %iv, 1
  %ec = icmp eq i32 %iv.next, 500
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}
