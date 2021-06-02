; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s  -loop-vectorize -force-vector-width=4 -S | FileCheck %s

; The function finds the smallest value from a float vector.
; Check if vectorization is enabled by instruction flag `fcmp nnan`.

define float @minloop(float* nocapture readonly %arg) {
; CHECK-LABEL: @minloop(
; CHECK-NEXT:  top:
; CHECK-NEXT:    [[T:%.*]] = load float, float* [[ARG:%.*]], align 4
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[T1:%.*]] = phi i64 [ [[T7:%.*]], [[LOOP]] ], [ 1, [[TOP:%.*]] ]
; CHECK-NEXT:    [[T2:%.*]] = phi float [ [[T6:%.*]], [[LOOP]] ], [ [[T]], [[TOP]] ]
; CHECK-NEXT:    [[T3:%.*]] = getelementptr float, float* [[ARG]], i64 [[T1]]
; CHECK-NEXT:    [[T4:%.*]] = load float, float* [[T3]], align 4
; CHECK-NEXT:    [[T5:%.*]] = fcmp nnan olt float [[T2]], [[T4]]
; CHECK-NEXT:    [[T6]] = select i1 [[T5]], float [[T2]], float [[T4]]
; CHECK-NEXT:    [[T7]] = add i64 [[T1]], 1
; CHECK-NEXT:    [[T8:%.*]] = icmp eq i64 [[T7]], 65537
; CHECK-NEXT:    br i1 [[T8]], label [[OUT:%.*]], label [[LOOP]]
; CHECK:       out:
; CHECK-NEXT:    [[T6_LCSSA:%.*]] = phi float [ [[T6]], [[LOOP]] ]
; CHECK-NEXT:    ret float [[T6_LCSSA]]
;
top:
  %t = load float, float* %arg
  br label %loop

loop:                                             ; preds = %loop, %top
  %t1 = phi i64 [ %t7, %loop ], [ 1, %top ]
  %t2 = phi float [ %t6, %loop ], [ %t, %top ]
  %t3 = getelementptr float, float* %arg, i64 %t1
  %t4 = load float, float* %t3, align 4
  %t5 = fcmp nnan olt float %t2, %t4
  %t6 = select i1 %t5, float %t2, float %t4
  %t7 = add i64 %t1, 1
  %t8 = icmp eq i64 %t7, 65537
  br i1 %t8, label %out, label %loop

out:                                              ; preds = %loop
  ret float %t6
}

; Check if vectorization is still enabled by function attribute.

define float @minloopattr(float* nocapture readonly %arg) #0 {
; CHECK-LABEL: @minloopattr(
; CHECK-NEXT:  top:
; CHECK-NEXT:    [[T:%.*]] = load float, float* [[ARG:%.*]], align 4
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[MINMAX_IDENT_SPLATINSERT:%.*]] = insertelement <4 x float> poison, float [[T]], i32 0
; CHECK-NEXT:    [[MINMAX_IDENT_SPLAT:%.*]] = shufflevector <4 x float> [[MINMAX_IDENT_SPLATINSERT]], <4 x float> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x float> [ [[MINMAX_IDENT_SPLAT]], [[VECTOR_PH]] ], [ [[TMP5:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = add i64 1, [[INDEX]]
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[OFFSET_IDX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr float, float* [[ARG]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr float, float* [[TMP1]], i32 0
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast float* [[TMP2]] to <4 x float>*
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x float>, <4 x float>* [[TMP3]], align 4
; CHECK-NEXT:    [[TMP4:%.*]] = fcmp olt <4 x float> [[VEC_PHI]], [[WIDE_LOAD]]
; CHECK-NEXT:    [[TMP5]] = select <4 x i1> [[TMP4]], <4 x float> [[VEC_PHI]], <4 x float> [[WIDE_LOAD]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP6:%.*]] = icmp eq i64 [[INDEX_NEXT]], 65536
; CHECK-NEXT:    br i1 [[TMP6]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], [[LOOP0:!llvm.loop !.*]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[TMP7:%.*]] = call float @llvm.vector.reduce.fmin.v4f32(<4 x float> [[TMP5]])
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 65536, 65536
; CHECK-NEXT:    br i1 [[CMP_N]], label [[OUT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 65537, [[MIDDLE_BLOCK]] ], [ 1, [[TOP:%.*]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi float [ [[T]], [[TOP]] ], [ [[TMP7]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[T1:%.*]] = phi i64 [ [[T7:%.*]], [[LOOP]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[T2:%.*]] = phi float [ [[T6:%.*]], [[LOOP]] ], [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[T3:%.*]] = getelementptr float, float* [[ARG]], i64 [[T1]]
; CHECK-NEXT:    [[T4:%.*]] = load float, float* [[T3]], align 4
; CHECK-NEXT:    [[T5:%.*]] = fcmp olt float [[T2]], [[T4]]
; CHECK-NEXT:    [[T6]] = select i1 [[T5]], float [[T2]], float [[T4]]
; CHECK-NEXT:    [[T7]] = add i64 [[T1]], 1
; CHECK-NEXT:    [[T8:%.*]] = icmp eq i64 [[T7]], 65537
; CHECK-NEXT:    br i1 [[T8]], label [[OUT]], label [[LOOP]], [[LOOP2:!llvm.loop !.*]]
; CHECK:       out:
; CHECK-NEXT:    [[T6_LCSSA:%.*]] = phi float [ [[T6]], [[LOOP]] ], [ [[TMP7]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret float [[T6_LCSSA]]
;
top:
  %t = load float, float* %arg
  br label %loop

loop:                                             ; preds = %loop, %top
  %t1 = phi i64 [ %t7, %loop ], [ 1, %top ]
  %t2 = phi float [ %t6, %loop ], [ %t, %top ]
  %t3 = getelementptr float, float* %arg, i64 %t1
  %t4 = load float, float* %t3, align 4
  %t5 = fcmp olt float %t2, %t4
  %t6 = select i1 %t5, float %t2, float %t4
  %t7 = add i64 %t1, 1
  %t8 = icmp eq i64 %t7, 65537
  br i1 %t8, label %out, label %loop

out:                                              ; preds = %loop
  ret float %t6
}

; Check if vectorization is prevented without the flag or attribute.

define float @minloopnovec(float* nocapture readonly %arg) {
; CHECK-LABEL: @minloopnovec(
; CHECK-NEXT:  top:
; CHECK-NEXT:    [[T:%.*]] = load float, float* [[ARG:%.*]], align 4
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[T1:%.*]] = phi i64 [ [[T7:%.*]], [[LOOP]] ], [ 1, [[TOP:%.*]] ]
; CHECK-NEXT:    [[T2:%.*]] = phi float [ [[T6:%.*]], [[LOOP]] ], [ [[T]], [[TOP]] ]
; CHECK-NEXT:    [[T3:%.*]] = getelementptr float, float* [[ARG]], i64 [[T1]]
; CHECK-NEXT:    [[T4:%.*]] = load float, float* [[T3]], align 4
; CHECK-NEXT:    [[T5:%.*]] = fcmp olt float [[T2]], [[T4]]
; CHECK-NEXT:    [[T6]] = select i1 [[T5]], float [[T2]], float [[T4]]
; CHECK-NEXT:    [[T7]] = add i64 [[T1]], 1
; CHECK-NEXT:    [[T8:%.*]] = icmp eq i64 [[T7]], 65537
; CHECK-NEXT:    br i1 [[T8]], label [[OUT:%.*]], label [[LOOP]]
; CHECK:       out:
; CHECK-NEXT:    [[T6_LCSSA:%.*]] = phi float [ [[T6]], [[LOOP]] ]
; CHECK-NEXT:    ret float [[T6_LCSSA]]
;
top:
  %t = load float, float* %arg
  br label %loop

loop:                                             ; preds = %loop, %top
  %t1 = phi i64 [ %t7, %loop ], [ 1, %top ]
  %t2 = phi float [ %t6, %loop ], [ %t, %top ]
  %t3 = getelementptr float, float* %arg, i64 %t1
  %t4 = load float, float* %t3, align 4
  %t5 = fcmp olt float %t2, %t4
  %t6 = select i1 %t5, float %t2, float %t4
  %t7 = add i64 %t1, 1
  %t8 = icmp eq i64 %t7, 65537
  br i1 %t8, label %out, label %loop

out:                                              ; preds = %loop
  ret float %t6
}

; This test is checking that we don't vectorize when only one of the required attributes is set.
; Note that this test should not vectorize even after switching to IR-level FMF.
define float @minloopmissingnsz(float* nocapture readonly %arg) #1 {
; CHECK-LABEL: @minloopmissingnsz(
; CHECK-NEXT:  top:
; CHECK-NEXT:    [[T:%.*]] = load float, float* [[ARG:%.*]], align 4
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[T1:%.*]] = phi i64 [ [[T7:%.*]], [[LOOP]] ], [ 1, [[TOP:%.*]] ]
; CHECK-NEXT:    [[T2:%.*]] = phi float [ [[T6:%.*]], [[LOOP]] ], [ [[T]], [[TOP]] ]
; CHECK-NEXT:    [[T3:%.*]] = getelementptr float, float* [[ARG]], i64 [[T1]]
; CHECK-NEXT:    [[T4:%.*]] = load float, float* [[T3]], align 4
; CHECK-NEXT:    [[T5:%.*]] = fcmp olt float [[T2]], [[T4]]
; CHECK-NEXT:    [[T6]] = select i1 [[T5]], float [[T2]], float [[T4]]
; CHECK-NEXT:    [[T7]] = add i64 [[T1]], 1
; CHECK-NEXT:    [[T8:%.*]] = icmp eq i64 [[T7]], 65537
; CHECK-NEXT:    br i1 [[T8]], label [[OUT:%.*]], label [[LOOP]]
; CHECK:       out:
; CHECK-NEXT:    [[T6_LCSSA:%.*]] = phi float [ [[T6]], [[LOOP]] ]
; CHECK-NEXT:    ret float [[T6_LCSSA]]
;
top:
  %t = load float, float* %arg
  br label %loop

loop:                                             ; preds = %loop, %top
  %t1 = phi i64 [ %t7, %loop ], [ 1, %top ]
  %t2 = phi float [ %t6, %loop ], [ %t, %top ]
  %t3 = getelementptr float, float* %arg, i64 %t1
  %t4 = load float, float* %t3, align 4
  %t5 = fcmp olt float %t2, %t4
  %t6 = select i1 %t5, float %t2, float %t4
  %t7 = add i64 %t1, 1
  %t8 = icmp eq i64 %t7, 65537
  br i1 %t8, label %out, label %loop

out:                                              ; preds = %loop
  ret float %t6
}

; This would assert on FMF propagation.

define void @not_a_min_max() {
; CHECK-LABEL: @not_a_min_max(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[F9_S0_V0:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[ADD:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[T14:%.*]] = icmp eq i32 [[F9_S0_V0]], 5
; CHECK-NEXT:    [[T15:%.*]] = select reassoc nnan ninf nsz contract afn i1 [[T14]], float 0x36A0000000000000, float 0.000000e+00
; CHECK-NEXT:    [[ADD]] = add nuw nsw i32 [[F9_S0_V0]], 1
; CHECK-NEXT:    br i1 false, label [[END:%.*]], label [[LOOP]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %f9.s0.v0 = phi i32 [ 0, %entry ], [ %add, %loop ]
  %t14 = icmp eq i32 %f9.s0.v0, 5
  %t15 = select reassoc nnan ninf nsz contract afn i1 %t14, float 0x36A0000000000000, float 0.0
  %add = add nuw nsw i32 %f9.s0.v0, 1
  br i1 false, label %end, label %loop

end:
  ret void
}

attributes #0 = { "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" }
attributes #1 = { "no-nans-fp-math"="true" }
