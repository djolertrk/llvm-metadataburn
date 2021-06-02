; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes='asan-pipeline' -asan-use-after-return=0 -S | FileCheck %s --check-prefixes=CHECK,NEVER
; RUN: opt < %s -passes='asan-pipeline' -asan-use-after-return=1 -S | FileCheck %s --check-prefixes=CHECK,RUNTIME
; RUN: opt < %s -passes='asan-pipeline' -asan-use-after-return=2 -S | FileCheck %s --check-prefixes=CHECK,ALWAYS
target datalayout = "e-i64:64-f80:128-s:64-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @Foo(i8*)

define void @Empty() uwtable sanitize_address {
; CHECK-LABEL: @Empty(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret void
;
entry:
  ret void
}

define void @Simple() uwtable sanitize_address {
; NEVER-LABEL: @Simple(
; NEVER-NEXT:  entry:
; NEVER-NEXT:    [[MYALLOCA:%.*]] = alloca i8, i64 64, align 32
; NEVER-NEXT:    [[TMP0:%.*]] = ptrtoint i8* [[MYALLOCA]] to i64
; NEVER-NEXT:    [[TMP1:%.*]] = add i64 [[TMP0]], 32
; NEVER-NEXT:    [[TMP2:%.*]] = inttoptr i64 [[TMP1]] to i8*
; NEVER-NEXT:    [[TMP3:%.*]] = inttoptr i64 [[TMP0]] to i64*
; NEVER-NEXT:    store i64 1102416563, i64* [[TMP3]], align 8
; NEVER-NEXT:    [[TMP4:%.*]] = add i64 [[TMP0]], 8
; NEVER-NEXT:    [[TMP5:%.*]] = inttoptr i64 [[TMP4]] to i64*
; NEVER-NEXT:    store i64 ptrtoint ([11 x i8]* @___asan_gen_ to i64), i64* [[TMP5]], align 8
; NEVER-NEXT:    [[TMP6:%.*]] = add i64 [[TMP0]], 16
; NEVER-NEXT:    [[TMP7:%.*]] = inttoptr i64 [[TMP6]] to i64*
; NEVER-NEXT:    store i64 ptrtoint (void ()* @Simple to i64), i64* [[TMP7]], align 8
; NEVER-NEXT:    [[TMP8:%.*]] = lshr i64 [[TMP0]], 3
; NEVER-NEXT:    [[TMP9:%.*]] = add i64 [[TMP8]], 2147450880
; NEVER-NEXT:    [[TMP10:%.*]] = add i64 [[TMP9]], 0
; NEVER-NEXT:    [[TMP11:%.*]] = inttoptr i64 [[TMP10]] to i64*
; NEVER-NEXT:    store i64 -868083113472691727, i64* [[TMP11]], align 1
; NEVER-NEXT:    call void @Foo(i8* [[TMP2]])
; NEVER-NEXT:    store i64 1172321806, i64* [[TMP3]], align 8
; NEVER-NEXT:    [[TMP12:%.*]] = add i64 [[TMP9]], 0
; NEVER-NEXT:    [[TMP13:%.*]] = inttoptr i64 [[TMP12]] to i64*
; NEVER-NEXT:    store i64 0, i64* [[TMP13]], align 1
; NEVER-NEXT:    ret void
;
; RUNTIME-LABEL: @Simple(
; RUNTIME-NEXT:  entry:
; RUNTIME-NEXT:    [[ASAN_LOCAL_STACK_BASE:%.*]] = alloca i64, align 8
; RUNTIME-NEXT:    [[TMP0:%.*]] = load i32, i32* @__asan_option_detect_stack_use_after_return, align 4
; RUNTIME-NEXT:    [[TMP1:%.*]] = icmp ne i32 [[TMP0]], 0
; RUNTIME-NEXT:    br i1 [[TMP1]], label [[TMP2:%.*]], label [[TMP4:%.*]]
; RUNTIME:       2:
; RUNTIME-NEXT:    [[TMP3:%.*]] = call i64 @__asan_stack_malloc_0(i64 64)
; RUNTIME-NEXT:    br label [[TMP4]]
; RUNTIME:       4:
; RUNTIME-NEXT:    [[TMP5:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[TMP3]], [[TMP2]] ]
; RUNTIME-NEXT:    [[TMP6:%.*]] = icmp eq i64 [[TMP5]], 0
; RUNTIME-NEXT:    br i1 [[TMP6]], label [[TMP7:%.*]], label [[TMP9:%.*]]
; RUNTIME:       7:
; RUNTIME-NEXT:    [[MYALLOCA:%.*]] = alloca i8, i64 64, align 32
; RUNTIME-NEXT:    [[TMP8:%.*]] = ptrtoint i8* [[MYALLOCA]] to i64
; RUNTIME-NEXT:    br label [[TMP9]]
; RUNTIME:       9:
; RUNTIME-NEXT:    [[TMP10:%.*]] = phi i64 [ [[TMP5]], [[TMP4]] ], [ [[TMP8]], [[TMP7]] ]
; RUNTIME-NEXT:    store i64 [[TMP10]], i64* [[ASAN_LOCAL_STACK_BASE]], align 8
; RUNTIME-NEXT:    [[TMP11:%.*]] = add i64 [[TMP10]], 32
; RUNTIME-NEXT:    [[TMP12:%.*]] = inttoptr i64 [[TMP11]] to i8*
; RUNTIME-NEXT:    [[TMP13:%.*]] = inttoptr i64 [[TMP10]] to i64*
; RUNTIME-NEXT:    store i64 1102416563, i64* [[TMP13]], align 8
; RUNTIME-NEXT:    [[TMP14:%.*]] = add i64 [[TMP10]], 8
; RUNTIME-NEXT:    [[TMP15:%.*]] = inttoptr i64 [[TMP14]] to i64*
; RUNTIME-NEXT:    store i64 ptrtoint ([11 x i8]* @___asan_gen_ to i64), i64* [[TMP15]], align 8
; RUNTIME-NEXT:    [[TMP16:%.*]] = add i64 [[TMP10]], 16
; RUNTIME-NEXT:    [[TMP17:%.*]] = inttoptr i64 [[TMP16]] to i64*
; RUNTIME-NEXT:    store i64 ptrtoint (void ()* @Simple to i64), i64* [[TMP17]], align 8
; RUNTIME-NEXT:    [[TMP18:%.*]] = lshr i64 [[TMP10]], 3
; RUNTIME-NEXT:    [[TMP19:%.*]] = add i64 [[TMP18]], 2147450880
; RUNTIME-NEXT:    [[TMP20:%.*]] = add i64 [[TMP19]], 0
; RUNTIME-NEXT:    [[TMP21:%.*]] = inttoptr i64 [[TMP20]] to i64*
; RUNTIME-NEXT:    store i64 -868083113472691727, i64* [[TMP21]], align 1
; RUNTIME-NEXT:    call void @Foo(i8* [[TMP12]])
; RUNTIME-NEXT:    store i64 1172321806, i64* [[TMP13]], align 8
; RUNTIME-NEXT:    [[TMP22:%.*]] = icmp ne i64 [[TMP5]], 0
; RUNTIME-NEXT:    br i1 [[TMP22]], label [[TMP23:%.*]], label [[TMP30:%.*]]
; RUNTIME:       23:
; RUNTIME-NEXT:    [[TMP24:%.*]] = add i64 [[TMP19]], 0
; RUNTIME-NEXT:    [[TMP25:%.*]] = inttoptr i64 [[TMP24]] to i64*
; RUNTIME-NEXT:    store i64 -723401728380766731, i64* [[TMP25]], align 1
; RUNTIME-NEXT:    [[TMP26:%.*]] = add i64 [[TMP5]], 56
; RUNTIME-NEXT:    [[TMP27:%.*]] = inttoptr i64 [[TMP26]] to i64*
; RUNTIME-NEXT:    [[TMP28:%.*]] = load i64, i64* [[TMP27]], align 8
; RUNTIME-NEXT:    [[TMP29:%.*]] = inttoptr i64 [[TMP28]] to i8*
; RUNTIME-NEXT:    store i8 0, i8* [[TMP29]], align 1
; RUNTIME-NEXT:    br label [[TMP33:%.*]]
; RUNTIME:       30:
; RUNTIME-NEXT:    [[TMP31:%.*]] = add i64 [[TMP19]], 0
; RUNTIME-NEXT:    [[TMP32:%.*]] = inttoptr i64 [[TMP31]] to i64*
; RUNTIME-NEXT:    store i64 0, i64* [[TMP32]], align 1
; RUNTIME-NEXT:    br label [[TMP33]]
; RUNTIME:       33:
; RUNTIME-NEXT:    ret void
;
; ALWAYS-LABEL: @Simple(
; ALWAYS-NEXT:  entry:
; ALWAYS-NEXT:    [[ASAN_LOCAL_STACK_BASE:%.*]] = alloca i64, align 8
; ALWAYS-NEXT:    [[TMP0:%.*]] = call i64 @__asan_stack_malloc_0(i64 64)
; ALWAYS-NEXT:    [[TMP1:%.*]] = icmp eq i64 [[TMP0]], 0
; ALWAYS-NEXT:    br i1 [[TMP1]], label [[TMP2:%.*]], label [[TMP4:%.*]]
; ALWAYS:       2:
; ALWAYS-NEXT:    [[MYALLOCA:%.*]] = alloca i8, i64 64, align 32
; ALWAYS-NEXT:    [[TMP3:%.*]] = ptrtoint i8* [[MYALLOCA]] to i64
; ALWAYS-NEXT:    br label [[TMP4]]
; ALWAYS:       4:
; ALWAYS-NEXT:    [[TMP5:%.*]] = phi i64 [ [[TMP0]], [[ENTRY:%.*]] ], [ [[TMP3]], [[TMP2]] ]
; ALWAYS-NEXT:    store i64 [[TMP5]], i64* [[ASAN_LOCAL_STACK_BASE]], align 8
; ALWAYS-NEXT:    [[TMP6:%.*]] = add i64 [[TMP5]], 32
; ALWAYS-NEXT:    [[TMP7:%.*]] = inttoptr i64 [[TMP6]] to i8*
; ALWAYS-NEXT:    [[TMP8:%.*]] = inttoptr i64 [[TMP5]] to i64*
; ALWAYS-NEXT:    store i64 1102416563, i64* [[TMP8]], align 8
; ALWAYS-NEXT:    [[TMP9:%.*]] = add i64 [[TMP5]], 8
; ALWAYS-NEXT:    [[TMP10:%.*]] = inttoptr i64 [[TMP9]] to i64*
; ALWAYS-NEXT:    store i64 ptrtoint ([11 x i8]* @___asan_gen_ to i64), i64* [[TMP10]], align 8
; ALWAYS-NEXT:    [[TMP11:%.*]] = add i64 [[TMP5]], 16
; ALWAYS-NEXT:    [[TMP12:%.*]] = inttoptr i64 [[TMP11]] to i64*
; ALWAYS-NEXT:    store i64 ptrtoint (void ()* @Simple to i64), i64* [[TMP12]], align 8
; ALWAYS-NEXT:    [[TMP13:%.*]] = lshr i64 [[TMP5]], 3
; ALWAYS-NEXT:    [[TMP14:%.*]] = add i64 [[TMP13]], 2147450880
; ALWAYS-NEXT:    [[TMP15:%.*]] = add i64 [[TMP14]], 0
; ALWAYS-NEXT:    [[TMP16:%.*]] = inttoptr i64 [[TMP15]] to i64*
; ALWAYS-NEXT:    store i64 -868083113472691727, i64* [[TMP16]], align 1
; ALWAYS-NEXT:    call void @Foo(i8* [[TMP7]])
; ALWAYS-NEXT:    store i64 1172321806, i64* [[TMP8]], align 8
; ALWAYS-NEXT:    [[TMP17:%.*]] = icmp ne i64 [[TMP0]], 0
; ALWAYS-NEXT:    br i1 [[TMP17]], label [[TMP18:%.*]], label [[TMP25:%.*]]
; ALWAYS:       18:
; ALWAYS-NEXT:    [[TMP19:%.*]] = add i64 [[TMP14]], 0
; ALWAYS-NEXT:    [[TMP20:%.*]] = inttoptr i64 [[TMP19]] to i64*
; ALWAYS-NEXT:    store i64 -723401728380766731, i64* [[TMP20]], align 1
; ALWAYS-NEXT:    [[TMP21:%.*]] = add i64 [[TMP0]], 56
; ALWAYS-NEXT:    [[TMP22:%.*]] = inttoptr i64 [[TMP21]] to i64*
; ALWAYS-NEXT:    [[TMP23:%.*]] = load i64, i64* [[TMP22]], align 8
; ALWAYS-NEXT:    [[TMP24:%.*]] = inttoptr i64 [[TMP23]] to i8*
; ALWAYS-NEXT:    store i8 0, i8* [[TMP24]], align 1
; ALWAYS-NEXT:    br label [[TMP28:%.*]]
; ALWAYS:       25:
; ALWAYS-NEXT:    [[TMP26:%.*]] = add i64 [[TMP14]], 0
; ALWAYS-NEXT:    [[TMP27:%.*]] = inttoptr i64 [[TMP26]] to i64*
; ALWAYS-NEXT:    store i64 0, i64* [[TMP27]], align 1
; ALWAYS-NEXT:    br label [[TMP28]]
; ALWAYS:       28:
; ALWAYS-NEXT:    ret void
;
entry:
  %x = alloca i8, align 16
  call void @Foo(i8* %x)
  ret void
}

define void @Huge() uwtable sanitize_address {
; CHECK-LABEL: @Huge(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MYALLOCA:%.*]] = alloca i8, i64 100288, align 32
; CHECK-NEXT:    [[TMP0:%.*]] = ptrtoint i8* [[MYALLOCA]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[TMP0]], 32
; CHECK-NEXT:    [[TMP2:%.*]] = inttoptr i64 [[TMP1]] to [100000 x i8]*
; CHECK-NEXT:    [[TMP3:%.*]] = inttoptr i64 [[TMP0]] to i64*
; CHECK-NEXT:    store i64 1102416563, i64* [[TMP3]], align 8
; CHECK-NEXT:    [[TMP4:%.*]] = add i64 [[TMP0]], 8
; CHECK-NEXT:    [[TMP5:%.*]] = inttoptr i64 [[TMP4]] to i64*
; CHECK-NEXT:    store i64 ptrtoint ([16 x i8]* @___asan_gen_.1 to i64), i64* [[TMP5]], align 8
; CHECK-NEXT:    [[TMP6:%.*]] = add i64 [[TMP0]], 16
; CHECK-NEXT:    [[TMP7:%.*]] = inttoptr i64 [[TMP6]] to i64*
; CHECK-NEXT:    store i64 ptrtoint (void ()* @Huge to i64), i64* [[TMP7]], align 8
; CHECK-NEXT:    [[TMP8:%.*]] = lshr i64 [[TMP0]], 3
; CHECK-NEXT:    [[TMP9:%.*]] = add i64 [[TMP8]], 2147450880
; CHECK-NEXT:    [[TMP10:%.*]] = add i64 [[TMP9]], 0
; CHECK-NEXT:    [[TMP11:%.*]] = inttoptr i64 [[TMP10]] to i32*
; CHECK-NEXT:    store i32 -235802127, i32* [[TMP11]], align 1
; CHECK-NEXT:    [[TMP12:%.*]] = add i64 [[TMP9]], 12504
; CHECK-NEXT:    [[TMP13:%.*]] = inttoptr i64 [[TMP12]] to i64*
; CHECK-NEXT:    store i64 -868082074056920077, i64* [[TMP13]], align 1
; CHECK-NEXT:    [[TMP14:%.*]] = add i64 [[TMP9]], 12512
; CHECK-NEXT:    [[TMP15:%.*]] = inttoptr i64 [[TMP14]] to i64*
; CHECK-NEXT:    store i64 -868082074056920077, i64* [[TMP15]], align 1
; CHECK-NEXT:    [[TMP16:%.*]] = add i64 [[TMP9]], 12520
; CHECK-NEXT:    [[TMP17:%.*]] = inttoptr i64 [[TMP16]] to i64*
; CHECK-NEXT:    store i64 -868082074056920077, i64* [[TMP17]], align 1
; CHECK-NEXT:    [[TMP18:%.*]] = add i64 [[TMP9]], 12528
; CHECK-NEXT:    [[TMP19:%.*]] = inttoptr i64 [[TMP18]] to i64*
; CHECK-NEXT:    store i64 -868082074056920077, i64* [[TMP19]], align 1
; CHECK-NEXT:    [[XX:%.*]] = getelementptr inbounds [100000 x i8], [100000 x i8]* [[TMP2]], i64 0, i64 0
; CHECK-NEXT:    call void @Foo(i8* [[XX]])
; CHECK-NEXT:    store i64 1172321806, i64* [[TMP3]], align 8
; CHECK-NEXT:    [[TMP20:%.*]] = add i64 [[TMP9]], 0
; CHECK-NEXT:    [[TMP21:%.*]] = inttoptr i64 [[TMP20]] to i32*
; CHECK-NEXT:    store i32 0, i32* [[TMP21]], align 1
; CHECK-NEXT:    [[TMP22:%.*]] = add i64 [[TMP9]], 12504
; CHECK-NEXT:    [[TMP23:%.*]] = inttoptr i64 [[TMP22]] to i64*
; CHECK-NEXT:    store i64 0, i64* [[TMP23]], align 1
; CHECK-NEXT:    [[TMP24:%.*]] = add i64 [[TMP9]], 12512
; CHECK-NEXT:    [[TMP25:%.*]] = inttoptr i64 [[TMP24]] to i64*
; CHECK-NEXT:    store i64 0, i64* [[TMP25]], align 1
; CHECK-NEXT:    [[TMP26:%.*]] = add i64 [[TMP9]], 12520
; CHECK-NEXT:    [[TMP27:%.*]] = inttoptr i64 [[TMP26]] to i64*
; CHECK-NEXT:    store i64 0, i64* [[TMP27]], align 1
; CHECK-NEXT:    [[TMP28:%.*]] = add i64 [[TMP9]], 12528
; CHECK-NEXT:    [[TMP29:%.*]] = inttoptr i64 [[TMP28]] to i64*
; CHECK-NEXT:    store i64 0, i64* [[TMP29]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %x = alloca [100000 x i8], align 16
  %xx = getelementptr inbounds [100000 x i8], [100000 x i8]* %x, i64 0, i64 0
  call void @Foo(i8* %xx)
  ret void
}