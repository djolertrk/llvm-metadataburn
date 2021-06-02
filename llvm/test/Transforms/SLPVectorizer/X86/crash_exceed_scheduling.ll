; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -slp-vectorizer -slp-min-tree-size=2 -slp-threshold=-1000 -slp-max-look-ahead-depth=1 -slp-look-ahead-users-budget=1 -slp-schedule-budget=27 -S -mtriple=x86_64-unknown-linux-gnu | FileCheck %s

define void @exceed(double %0, double %1) {
; CHECK-LABEL: @exceed(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <2 x double> poison, double [[TMP0:%.*]], i32 0
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <2 x double> [[TMP2]], double [[TMP0]], i32 1
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <2 x double> poison, double [[TMP1:%.*]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <2 x double> [[TMP4]], double [[TMP1]], i32 1
; CHECK-NEXT:    [[TMP6:%.*]] = fdiv fast <2 x double> [[TMP3]], [[TMP5]]
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <2 x double> [[TMP6]], i32 1
; CHECK-NEXT:    [[IX:%.*]] = fmul double [[TMP7]], undef
; CHECK-NEXT:    [[IXX0:%.*]] = fsub double undef, undef
; CHECK-NEXT:    [[IXX1:%.*]] = fsub double undef, undef
; CHECK-NEXT:    [[IXX2:%.*]] = fsub double undef, undef
; CHECK-NEXT:    [[IXX3:%.*]] = fsub double undef, undef
; CHECK-NEXT:    [[IXX4:%.*]] = fsub double undef, undef
; CHECK-NEXT:    [[IXX5:%.*]] = fsub double undef, undef
; CHECK-NEXT:    [[IX1:%.*]] = fmul double [[TMP7]], undef
; CHECK-NEXT:    [[IXX10:%.*]] = fsub double undef, undef
; CHECK-NEXT:    [[IXX11:%.*]] = fsub double undef, undef
; CHECK-NEXT:    [[IXX12:%.*]] = fsub double undef, undef
; CHECK-NEXT:    [[IXX13:%.*]] = fsub double undef, undef
; CHECK-NEXT:    [[IXX14:%.*]] = fsub double undef, undef
; CHECK-NEXT:    [[IXX15:%.*]] = fsub double undef, undef
; CHECK-NEXT:    [[IXX20:%.*]] = fsub double undef, undef
; CHECK-NEXT:    [[IXX21:%.*]] = fsub double undef, undef
; CHECK-NEXT:    [[IXX22:%.*]] = fsub double undef, undef
; CHECK-NEXT:    [[TMP8:%.*]] = extractelement <2 x double> [[TMP6]], i32 0
; CHECK-NEXT:    [[IX2:%.*]] = fmul double [[TMP8]], [[TMP8]]
; CHECK-NEXT:    [[TMP9:%.*]] = insertelement <2 x double> [[TMP2]], double [[TMP1]], i32 1
; CHECK-NEXT:    [[TMP10:%.*]] = fadd fast <2 x double> [[TMP6]], [[TMP9]]
; CHECK-NEXT:    [[TMP11:%.*]] = fadd fast <2 x double> [[TMP3]], [[TMP5]]
; CHECK-NEXT:    [[TMP12:%.*]] = fmul fast <2 x double> [[TMP10]], [[TMP11]]
; CHECK-NEXT:    [[IXX101:%.*]] = fsub double undef, undef
; CHECK-NEXT:    [[TMP13:%.*]] = insertelement <2 x double> poison, double [[TMP7]], i32 0
; CHECK-NEXT:    [[TMP14:%.*]] = insertelement <2 x double> [[TMP13]], double undef, i32 1
; CHECK-NEXT:    [[TMP15:%.*]] = insertelement <2 x double> <double undef, double poison>, double [[TMP1]], i32 1
; CHECK-NEXT:    [[TMP16:%.*]] = fmul fast <2 x double> [[TMP14]], [[TMP15]]
; CHECK-NEXT:    switch i32 undef, label [[BB1:%.*]] [
; CHECK-NEXT:    i32 0, label [[BB2:%.*]]
; CHECK-NEXT:    ]
; CHECK:       bb1:
; CHECK-NEXT:    br label [[LABEL:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    br label [[LABEL]]
; CHECK:       label:
; CHECK-NEXT:    [[TMP17:%.*]] = phi <2 x double> [ [[TMP12]], [[BB1]] ], [ [[TMP16]], [[BB2]] ]
; CHECK-NEXT:    ret void
;
entry:
  %i10 = fdiv fast double %0, %1
  %ix = fmul double %i10, undef
  %ixx0 = fsub double undef, undef
  %ixx1 = fsub double undef, undef
  %ixx2 = fsub double undef, undef
  %ixx3 = fsub double undef, undef
  %ixx4 = fsub double undef, undef
  %ixx5 = fsub double undef, undef
  %ix1 = fmul double %i10, undef
  %ixx10 = fsub double undef, undef
  %ixx11 = fsub double undef, undef
  %ixx12 = fsub double undef, undef
  %ixx13 = fsub double undef, undef
  %ixx14 = fsub double undef, undef
  %ixx15 = fsub double undef, undef
  %ixx20 = fsub double undef, undef
  %ixx21 = fsub double undef, undef
  %ixx22 = fsub double undef, undef
  %i11 = fdiv fast double %0, %1
  %ix2 = fmul double %i11, %i11
  %tmp1 = fadd fast double %i11, %0
  %tmp2 = fadd fast double %0, %1
  %tmp5 = fmul fast double %tmp1, %tmp2
  %tmp15 = fadd fast double %i10, %1
  %tmp25 = fadd fast double %0, %1
  %tmp6 = fmul fast double %tmp15, %tmp25
  %tmp555 = fmul fast double %i10, undef
  %ixx101 = fsub double undef, undef
  %tmp666 = fmul fast double %1, undef
  switch i32 undef, label %bb1 [
  i32 0, label %bb2
  ]

bb1:                                              ; preds = %entry
  br label %label

bb2:                                              ; preds = %entry
  br label %label

label:                                            ; preds = %bb2, %bb1
  %phi1 = phi double [ %tmp5, %bb1 ], [ %tmp555, %bb2 ]
  %phi2 = phi double [ %tmp6, %bb1 ], [ %tmp666, %bb2 ]
  ret void
}
