; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -mtriple=x86_64-unknown -mattr=+avx -slp-vectorizer | FileCheck %s

@array = external global [20 x [13 x i32]]

define void @hoge(i64 %idx, <4 x i32>* %sink) {
; CHECK-LABEL: @hoge(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds [20 x [13 x i32]], [20 x [13 x i32]]* @array, i64 0, i64 [[IDX:%.*]], i64 5
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds [20 x [13 x i32]], [20 x [13 x i32]]* @array, i64 0, i64 [[IDX]], i64 6
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [20 x [13 x i32]], [20 x [13 x i32]]* @array, i64 0, i64 [[IDX]], i64 7
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds [20 x [13 x i32]], [20 x [13 x i32]]* @array, i64 0, i64 [[IDX]], i64 8
; CHECK-NEXT:    [[TMP4:%.*]] = bitcast i32* [[TMP0]] to <4 x i32>*
; CHECK-NEXT:    [[TMP5:%.*]] = load <4 x i32>, <4 x i32>* [[TMP4]], align 4
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <4 x i32> [[TMP5]], <4 x i32> poison, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
; CHECK-NEXT:    store <4 x i32> [[SHUFFLE]], <4 x i32>* [[SINK:%.*]], align 16
; CHECK-NEXT:    ret void
;
bb:
  %0 = getelementptr inbounds [20 x [13 x i32]], [20 x [13 x i32]]* @array, i64 0, i64 %idx, i64 5
  %1 = getelementptr inbounds [20 x [13 x i32]], [20 x [13 x i32]]* @array, i64 0, i64 %idx, i64 6
  %2 = getelementptr inbounds [20 x [13 x i32]], [20 x [13 x i32]]* @array, i64 0, i64 %idx, i64 7
  %3 = getelementptr inbounds [20 x [13 x i32]], [20 x [13 x i32]]* @array, i64 0, i64 %idx, i64 8
  %4 = load i32, i32* %1, align 4
  %5 = insertelement <4 x i32> undef, i32 %4, i32 0
  %6 = load i32, i32* %2, align 4
  %7 = insertelement <4 x i32> %5, i32 %6, i32 1
  %8 = load i32, i32* %3, align 4
  %9 = insertelement <4 x i32> %7, i32 %8, i32 2
  %10 = load i32, i32* %0, align 4
  %11 = insertelement <4 x i32> %9, i32 %10, i32 3
  store <4 x i32> %11, <4 x i32>* %sink
  ret void
}

