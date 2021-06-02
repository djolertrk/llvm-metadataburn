; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes='default<O3>' -S %s | FileCheck %s

target triple = "arm64-apple-darwin"

; Make sure we can vectorize a loop that uses a function to clamp a double to
; be between a given minimum and maximum value.

define internal double @clamp(double %v) {
entry:
  %retval = alloca double, align 8
  %v.addr = alloca double, align 8
  store double %v, double* %v.addr, align 8
  %0 = load double, double* %v.addr, align 8
  %cmp = fcmp olt double %0, 0.000000e+00
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store double 0.000000e+00, double* %retval, align 8
  br label %return

if.end:                                           ; preds = %entry
  %1 = load double, double* %v.addr, align 8
  %cmp1 = fcmp ogt double %1, 6.000000e+00
  br i1 %cmp1, label %if.then2, label %if.end3

if.then2:                                         ; preds = %if.end
  store double 6.000000e+00, double* %retval, align 8
  br label %return

if.end3:                                          ; preds = %if.end
  %2 = load double, double* %v.addr, align 8
  store double %2, double* %retval, align 8
  br label %return

return:                                           ; preds = %if.end3, %if.then2, %if.then
  %3 = load double, double* %retval, align 8
  ret double %3
}

define void @loop(double* %X, double* %Y) {
; CHECK-LABEL: @loop(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr double, double* [[X:%.*]], i64 20000
; CHECK-NEXT:    [[SCEVGEP9:%.*]] = getelementptr double, double* [[Y:%.*]], i64 20000
; CHECK-NEXT:    [[BOUND0:%.*]] = icmp ugt double* [[SCEVGEP9]], [[X]]
; CHECK-NEXT:    [[BOUND1:%.*]] = icmp ugt double* [[SCEVGEP]], [[Y]]
; CHECK-NEXT:    [[FOUND_CONFLICT:%.*]] = and i1 [[BOUND0]], [[BOUND1]]
; CHECK-NEXT:    br i1 [[FOUND_CONFLICT]], label [[FOR_BODY:%.*]], label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = zext i32 [[INDEX]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds double, double* [[Y]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast double* [[TMP1]] to <2 x double>*
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <2 x double>, <2 x double>* [[TMP2]], align 8, !alias.scope !0
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds double, double* [[TMP1]], i64 2
; CHECK-NEXT:    [[TMP4:%.*]] = bitcast double* [[TMP3]] to <2 x double>*
; CHECK-NEXT:    [[WIDE_LOAD11:%.*]] = load <2 x double>, <2 x double>* [[TMP4]], align 8, !alias.scope !0
; CHECK-NEXT:    [[TMP5:%.*]] = fcmp olt <2 x double> [[WIDE_LOAD]], zeroinitializer
; CHECK-NEXT:    [[TMP6:%.*]] = fcmp olt <2 x double> [[WIDE_LOAD11]], zeroinitializer
; CHECK-NEXT:    [[TMP7:%.*]] = fcmp ogt <2 x double> [[WIDE_LOAD]], <double 6.000000e+00, double 6.000000e+00>
; CHECK-NEXT:    [[TMP8:%.*]] = fcmp ogt <2 x double> [[WIDE_LOAD11]], <double 6.000000e+00, double 6.000000e+00>
; CHECK-NEXT:    [[TMP9:%.*]] = select <2 x i1> [[TMP7]], <2 x double> <double 6.000000e+00, double 6.000000e+00>, <2 x double> [[WIDE_LOAD]]
; CHECK-NEXT:    [[TMP10:%.*]] = select <2 x i1> [[TMP8]], <2 x double> <double 6.000000e+00, double 6.000000e+00>, <2 x double> [[WIDE_LOAD11]]
; CHECK-NEXT:    [[TMP11:%.*]] = select <2 x i1> [[TMP5]], <2 x double> zeroinitializer, <2 x double> [[TMP9]]
; CHECK-NEXT:    [[TMP12:%.*]] = select <2 x i1> [[TMP6]], <2 x double> zeroinitializer, <2 x double> [[TMP10]]
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds double, double* [[X]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP14:%.*]] = bitcast double* [[TMP13]] to <2 x double>*
; CHECK-NEXT:    store <2 x double> [[TMP11]], <2 x double>* [[TMP14]], align 8, !alias.scope !3, !noalias !0
; CHECK-NEXT:    [[TMP15:%.*]] = getelementptr inbounds double, double* [[TMP13]], i64 2
; CHECK-NEXT:    [[TMP16:%.*]] = bitcast double* [[TMP15]] to <2 x double>*
; CHECK-NEXT:    store <2 x double> [[TMP12]], <2 x double>* [[TMP16]], align 8, !alias.scope !3, !noalias !0
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP17:%.*]] = icmp eq i32 [[INDEX_NEXT]], 20000
; CHECK-NEXT:    br i1 [[TMP17]], label [[FOR_COND_CLEANUP:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void
; CHECK:       for.body:
; CHECK-NEXT:    [[I_05:%.*]] = phi i32 [ [[INC:%.*]], [[FOR_BODY]] ], [ 0, [[ENTRY]] ]
; CHECK-NEXT:    [[IDXPROM:%.*]] = zext i32 [[I_05]] to i64
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds double, double* [[Y]], i64 [[IDXPROM]]
; CHECK-NEXT:    [[TMP18:%.*]] = load double, double* [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[CMP_I:%.*]] = fcmp olt double [[TMP18]], 0.000000e+00
; CHECK-NEXT:    [[CMP1_I:%.*]] = fcmp ogt double [[TMP18]], 6.000000e+00
; CHECK-NEXT:    [[DOTV_I:%.*]] = select i1 [[CMP1_I]], double 6.000000e+00, double [[TMP18]]
; CHECK-NEXT:    [[RETVAL_0_I:%.*]] = select i1 [[CMP_I]], double 0.000000e+00, double [[DOTV_I]]
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds double, double* [[X]], i64 [[IDXPROM]]
; CHECK-NEXT:    store double [[RETVAL_0_I]], double* [[ARRAYIDX2]], align 8
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_05]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[I_05]], 19999
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_COND_CLEANUP]], !llvm.loop [[LOOP7:![0-9]+]]
;
entry:
  %X.addr = alloca double*, align 8
  %Y.addr = alloca double*, align 8
  %i = alloca i32, align 4
  store double* %X, double** %X.addr, align 8
  store double* %Y, double** %Y.addr, align 8
  %0 = bitcast i32* %i to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #2
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i32, i32* %i, align 4
  %cmp = icmp ult i32 %1, 20000
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond
  %2 = bitcast i32* %i to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #2
  br label %for.end

for.body:                                         ; preds = %for.cond
  %3 = load double*, double** %Y.addr, align 8
  %4 = load i32, i32* %i, align 4
  %idxprom = zext i32 %4 to i64
  %arrayidx = getelementptr inbounds double, double* %3, i64 %idxprom
  %5 = load double, double* %arrayidx, align 8
  %call = call double @clamp(double %5)
  %6 = load double*, double** %X.addr, align 8
  %7 = load i32, i32* %i, align 4
  %idxprom1 = zext i32 %7 to i64
  %arrayidx2 = getelementptr inbounds double, double* %6, i64 %idxprom1
  store double %call, double* %arrayidx2, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %8 = load i32, i32* %i, align 4
  %inc = add i32 %8, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond.cleanup
  ret void
}

; Test that requires sinking/hoisting of instructions for vectorization.

define void @loop2(float* %A, float* %B, i32* %C, float %x) {
; CHECK-LABEL: @loop2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr float, float* [[B:%.*]], i64 10000
; CHECK-NEXT:    [[SCEVGEP6:%.*]] = getelementptr i32, i32* [[C:%.*]], i64 10000
; CHECK-NEXT:    [[SCEVGEP9:%.*]] = getelementptr float, float* [[A:%.*]], i64 10000
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i32* [[SCEVGEP6]] to float*
; CHECK-NEXT:    [[BOUND0:%.*]] = icmp ugt float* [[TMP0]], [[B]]
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast float* [[SCEVGEP]] to i32*
; CHECK-NEXT:    [[BOUND1:%.*]] = icmp ugt i32* [[TMP1]], [[C]]
; CHECK-NEXT:    [[FOUND_CONFLICT:%.*]] = and i1 [[BOUND0]], [[BOUND1]]
; CHECK-NEXT:    [[BOUND011:%.*]] = icmp ugt float* [[SCEVGEP9]], [[B]]
; CHECK-NEXT:    [[BOUND112:%.*]] = icmp ugt float* [[SCEVGEP]], [[A]]
; CHECK-NEXT:    [[FOUND_CONFLICT13:%.*]] = and i1 [[BOUND011]], [[BOUND112]]
; CHECK-NEXT:    [[CONFLICT_RDX:%.*]] = or i1 [[FOUND_CONFLICT]], [[FOUND_CONFLICT13]]
; CHECK-NEXT:    br i1 [[CONFLICT_RDX]], label [[LOOP_BODY:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <4 x float> poison, float [[X:%.*]], i32 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <4 x float> [[BROADCAST_SPLATINSERT]], <4 x float> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[DOT0:%.*]] = getelementptr inbounds i32, i32* [[C]], i64 0
; CHECK-NEXT:    [[DOT017:%.*]] = getelementptr inbounds float, float* [[A]], i64 0
; CHECK-NEXT:    [[DOT018:%.*]] = getelementptr inbounds float, float* [[B]], i64 0
; CHECK-NEXT:    [[INDEX_NEXT_0:%.*]] = add i64 0, 4
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX_NEXT_PHI:%.*]] = phi i64 [ [[INDEX_NEXT_0]], [[VECTOR_PH]] ], [ [[INDEX_NEXT_1:%.*]], [[VECTOR_BODY_VECTOR_BODY_CRIT_EDGE:%.*]] ]
; CHECK-NEXT:    [[DOTPHI:%.*]] = phi float* [ [[DOT018]], [[VECTOR_PH]] ], [ [[DOT120:%.*]], [[VECTOR_BODY_VECTOR_BODY_CRIT_EDGE]] ]
; CHECK-NEXT:    [[DOTPHI21:%.*]] = phi float* [ [[DOT017]], [[VECTOR_PH]] ], [ [[DOT119:%.*]], [[VECTOR_BODY_VECTOR_BODY_CRIT_EDGE]] ]
; CHECK-NEXT:    [[DOTPHI22:%.*]] = phi i32* [ [[DOT0]], [[VECTOR_PH]] ], [ [[DOT1:%.*]], [[VECTOR_BODY_VECTOR_BODY_CRIT_EDGE]] ]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast i32* [[DOTPHI22]] to <4 x i32>*
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, <4 x i32>* [[TMP2]], align 4, !alias.scope !8
; CHECK-NEXT:    [[TMP3:%.*]] = icmp eq <4 x i32> [[WIDE_LOAD]], <i32 20, i32 20, i32 20, i32 20>
; CHECK-NEXT:    [[TMP4:%.*]] = bitcast float* [[DOTPHI21]] to <4 x float>*
; CHECK-NEXT:    [[WIDE_LOAD14:%.*]] = load <4 x float>, <4 x float>* [[TMP4]], align 4, !alias.scope !11
; CHECK-NEXT:    [[TMP5:%.*]] = fmul <4 x float> [[WIDE_LOAD14]], [[BROADCAST_SPLAT]]
; CHECK-NEXT:    [[TMP6:%.*]] = bitcast float* [[DOTPHI]] to <4 x float>*
; CHECK-NEXT:    [[WIDE_LOAD15:%.*]] = load <4 x float>, <4 x float>* [[TMP6]], align 4, !alias.scope !13, !noalias !15
; CHECK-NEXT:    [[TMP7:%.*]] = fadd <4 x float> [[TMP5]], [[WIDE_LOAD15]]
; CHECK-NEXT:    [[PREDPHI:%.*]] = select <4 x i1> [[TMP3]], <4 x float> [[TMP5]], <4 x float> [[TMP7]]
; CHECK-NEXT:    [[TMP8:%.*]] = bitcast float* [[DOTPHI]] to <4 x float>*
; CHECK-NEXT:    store <4 x float> [[PREDPHI]], <4 x float>* [[TMP8]], align 4, !alias.scope !13, !noalias !15
; CHECK-NEXT:    [[TMP9:%.*]] = icmp eq i64 [[INDEX_NEXT_PHI]], 10000
; CHECK-NEXT:    br i1 [[TMP9]], label [[EXIT:%.*]], label [[VECTOR_BODY_VECTOR_BODY_CRIT_EDGE]], !llvm.loop [[LOOP16:![0-9]+]]
; CHECK:       vector.body.vector.body_crit_edge:
; CHECK-NEXT:    [[DOT1]] = getelementptr inbounds i32, i32* [[C]], i64 [[INDEX_NEXT_PHI]]
; CHECK-NEXT:    [[DOT119]] = getelementptr inbounds float, float* [[A]], i64 [[INDEX_NEXT_PHI]]
; CHECK-NEXT:    [[DOT120]] = getelementptr inbounds float, float* [[B]], i64 [[INDEX_NEXT_PHI]]
; CHECK-NEXT:    [[INDEX_NEXT_1]] = add i64 [[INDEX_NEXT_PHI]], 4
; CHECK-NEXT:    br label [[VECTOR_BODY]]
; CHECK:       loop.body:
; CHECK-NEXT:    [[IV1:%.*]] = phi i64 [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[C_GEP:%.*]] = getelementptr inbounds i32, i32* [[C]], i64 [[IV1]]
; CHECK-NEXT:    [[C_LV:%.*]] = load i32, i32* [[C_GEP]], align 4
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C_LV]], 20
; CHECK-NEXT:    [[A_GEP_0:%.*]] = getelementptr inbounds float, float* [[A]], i64 [[IV1]]
; CHECK-NEXT:    [[A_LV_0:%.*]] = load float, float* [[A_GEP_0]], align 4
; CHECK-NEXT:    [[MUL2_I81_I:%.*]] = fmul float [[A_LV_0]], [[X]]
; CHECK-NEXT:    [[B_GEP_0:%.*]] = getelementptr inbounds float, float* [[B]], i64 [[IV1]]
; CHECK-NEXT:    br i1 [[CMP]], label [[LOOP_LATCH]], label [[ELSE:%.*]]
; CHECK:       else:
; CHECK-NEXT:    [[B_LV:%.*]] = load float, float* [[B_GEP_0]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = fadd float [[MUL2_I81_I]], [[B_LV]]
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[ADD_SINK:%.*]] = phi float [ [[ADD]], [[ELSE]] ], [ [[MUL2_I81_I]], [[LOOP_BODY]] ]
; CHECK-NEXT:    store float [[ADD_SINK]], float* [[B_GEP_0]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV1]], 1
; CHECK-NEXT:    [[CMP_0:%.*]] = icmp ult i64 [[IV1]], 9999
; CHECK-NEXT:    br i1 [[CMP_0]], label [[LOOP_BODY]], label [[EXIT]], !llvm.loop [[LOOP17:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i64 [ %iv.next, %loop.latch ], [ 0, %entry ]
  %cmp.0 = icmp ult i64 %iv, 10000
  br i1 %cmp.0, label %loop.body, label %exit

loop.body:
  %C.gep = getelementptr inbounds i32, i32* %C, i64 %iv
  %C.lv = load i32, i32* %C.gep
  %cmp = icmp eq i32 %C.lv, 20
  br i1 %cmp, label %then, label %else

then:
  %A.gep.0 = getelementptr inbounds float, float* %A, i64 %iv
  %A.lv.0 = load float, float* %A.gep.0, align 4
  %mul2.i81.i = fmul float %A.lv.0, %x
  %B.gep.0 = getelementptr inbounds float, float* %B, i64 %iv
  store float %mul2.i81.i, float* %B.gep.0, align 4
  br label %loop.latch

else:
  %A.gep.1 = getelementptr inbounds float, float* %A, i64 %iv
  %A.lv.1 = load float, float* %A.gep.1, align 4
  %mul2 = fmul float %A.lv.1, %x
  %B.gep.1 = getelementptr inbounds float, float* %B, i64 %iv
  %B.lv = load float, float* %B.gep.1, align 4
  %add = fadd float %mul2, %B.lv
  store float %add, float* %B.gep.1, align 4
  br label %loop.latch

loop.latch:
  %iv.next = add nuw nsw i64 %iv, 1
  br label %loop.header

exit:
  ret void
}

declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture)

declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture)
