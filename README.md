# llvm-metadataburn [PROPOSAL]
## Reduce metadata in LLVM tests

Writing minimal test cases by reproducing some bugs found in compiler is very challenging these days (as well as always, I guess) and there are tools trying to solve that problem, e.g., [0] and [1]. If the compiler bug is comming from Debug Info area, the test cases on the IR/MIR (almost) always include LLVM DI Metadata (a piece of the info can be fount at [2]), which makes the tests much longer than non-debug ones (since there is description of the Module(s) by representing the file, functions, src lines, etc.). The tools I've mentioned above do not reduce the metadata very effectively, so this utility tool focuses (almost only) to reducing LLVM DI Metadata.

During patch reviews on the LLVM Phabricator [3], reviewers very frequently ask patch submitter for a reduced test case in terms of DI Metadata. There are some tricks that developers perform manually (by hand writting) in order to reduce amount of DI Metadata in the .ll (or .mir) file, so I think it could be become an autimate process (implemented as a utility tool like this). I will show one example of the test case (I've written and committed on to LLVM main -- https://reviews.llvm.org/D100844):

    $ cat llvm/test/Transforms/ADCE/adce-salvage-dbg-value.ll
    ; ModuleID = 'test.ll'
    source_filename = "test.ll"
    
    ; Function Attrs: nounwind readnone
    declare void @may_not_return(i32) #0
    
    ; Function Attrs: nounwind readnone willreturn
    declare void @will_return(i32) #1
    
    define void @test(i32 %a) !dbg !6 {
    ; CHECK-LABEL: @test(
    ; CHECK-NEXT:    [[B:%.*]] = add i32 [[A:%.*]], 1
    ; CHECK-NEXT:    call void @llvm.dbg.value(metadata i32 [[B]]
    ; CHECK-NEXT:    call void @may_not_return(i32 [[B]])
    ; CHECK-NEXT:    call void @llvm.dbg.value(metadata i32 [[B]], {{.*}}DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)
    ; CHECK-NEXT:    ret void
    ;
    %b = add i32 %a, 1, !dbg !12
    call void @llvm.dbg.value(metadata i32 %b, metadata !9, metadata !DIExpression()), !dbg !12
    call void @may_not_return(i32 %b), !dbg !13
    %c = add i32 %b, 1, !dbg !14
    call void @llvm.dbg.value(metadata i32 %c, metadata !11, metadata !DIExpression()), !dbg !14
    call void @will_return(i32 %c), !dbg !15
    ret void, !dbg !16
    }
    
    declare void @llvm.dbg.value(metadata, metadata, metadata)
    
    attributes #0 = { nounwind readnone }
    attributes #1 = { nounwind readnone willreturn }
    
    !llvm.dbg.cu = !{!0}
    !llvm.debugify = !{!3, !4}
    !llvm.module.flags = !{!5}
    
    !0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "debugify", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
    !1 = !DIFile(filename: "test.ll", directory: "/")
    !2 = !{}
    !3 = !{i32 5}
    !4 = !{i32 2}
    !5 = !{i32 2, !"Debug Info Version", i32 3}
    !6 = distinct !DISubprogram(name: "test", linkageName: "test", scope: null, file: !1, line: 1, type: !7, scopeLine: 1, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !8)
    !7 = !DISubroutineType(types: !2)
    !8 = !{!9, !11}
    !9 = !DILocalVariable(name: "1", scope: !6, file: !1, line: 1, type: !10)
    !10 = !DIBasicType(name: "ty32", size: 32, encoding: DW_ATE_unsigned)
    !11 = !DILocalVariable(name: "2", scope: !6, file: !1, line: 3, type: !10)
    !12 = !DILocation(line: 1, column: 1, scope: !6)
    !13 = !DILocation(line: 2, column: 1, scope: !6)
    !14 = !DILocation(line: 3, column: 1, scope: !6)
    !15 = !DILocation(line: 4, column: 1, scope: !6)
    !16 = !DILocation(line: 5, column: 1, scope: !6)

This test case should be intereted in checking if the ADCE Transformation preserves (more preciselly "salvages") debug info for var "1", so having all these !DILocation isn't neccessery, so we can attach only one !DILocation onto all the IR instructions from the test as follows:

    $ git diff
    ...
    %b = add i32 %a, 1, !dbg !12
    call void @llvm.dbg.value(metadata i32 %b, metadata !9, metadata !DIExpression()), !dbg !12
    -  call void @may_not_return(i32 %b), !dbg !13
    -  %c = add i32 %b, 1, !dbg !14
    -  call void @llvm.dbg.value(metadata i32 %c, metadata !11, metadata !DIExpression()), !dbg !14
    -  call void @will_return(i32 %c), !dbg !15
    -  ret void, !dbg !16
    +  call void @may_not_return(i32 %b), !dbg !12
    +  %c = add i32 %b, 1, !dbg !12
    +  call void @llvm.dbg.value(metadata i32 %c, metadata !11, metadata !DIExpression()), !dbg !12
    +  call void @will_return(i32 %c), !dbg !12
    +  ret void, !dbg !12
     }
 
     declare void @llvm.dbg.value(metadata, metadata, metadata)
    @@ -49,7 +49,3 @@ attributes #1 = { nounwind readnone willreturn }
     !10 = !DIBasicType(name: "ty32", size: 32, encoding: DW_ATE_unsigned)
     !11 = !DILocalVariable(name: "2", scope: !6, file: !1, line: 3, type: !10)
     !12 = !DILocation(line: 1, column: 1, scope: !6)
    -!13 = !DILocation(line: 2, column: 1, scope: !6)
    -!14 = !DILocation(line: 3, column: 1, scope: !6)
    -!15 = !DILocation(line: 4, column: 1, scope: !6)
    -!16 = !DILocation(line: 5, column: 1, scope: !6)

And the test still passes:

    $ ./bin/llvm-lit ../llvm-metadataburn/llvm/test/Transforms/ADCE/adce-salvage-dbg-value.ll
    -- Testing: 1 tests, 1 workers --
    PASS: LLVM :: Transforms/ADCE/adce-salvage-dbg-value.ll (1 of 1)
    
    Testing Time: 0.11s
      Passed: 1

Why don't we automate all this (if possible)?

## Building && Using the tool

### Build steps

    $ git clone git@github.com:djolertrk/llvm-metadataburn.git
    $ mkdir build && cd build
    $ cmake -G "Ninja" -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS="llvm;" -DLLVM_ENABLE_LIBCXX=ON ../llvm-project/llvm -DLLVM_CCACHE_BUILD=True -DCMAKE_CXX_COMPILER=clang++-10 -DCMAKE_C_COMPILER=clang-10
    $ ninja && ninja check-llvm
    
### Usage
NOTE: The tool needs llvm-lit that is being used for the testing and the test file itself (-override means we are allowed to rewrite the original test file).

    $ ./bin/llvm-meteadataburn ../llvm-metadataburn/llvm/test/Transforms/ADCE/adce-salvage-dbg-value.ll -lit=./bin/llvm-lit -override
    === LLVM metadata burn ===
    Reduced file generated: ../llvm-metadataburn/llvm/test/Transforms/ADCE/adce-salvage-dbg-value.ll

NOTE: This handles IR level tests only for now, but MIR tests can be handled as well.

[0] https://llvm.org/docs/CommandGuide/bugpoint.html
[1] https://blog.regehr.org/archives/2109

[2] https://llvm.org/docs/SourceLevelDebugging.html
[3] https://reviews.llvm.org/
