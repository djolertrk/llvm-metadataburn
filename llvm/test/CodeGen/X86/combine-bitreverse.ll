; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown -mattr=+sse2 | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+avx | FileCheck %s --check-prefix=X64

; These tests just check that the plumbing is in place for @llvm.bitreverse. The
; actual output is massive at the moment as llvm.bitreverse is not yet legal.

declare i32 @llvm.bitreverse.i32(i32) readnone
declare <4 x i32> @llvm.bitreverse.v4i32(<4 x i32>) readnone

; fold (bitreverse undef) -> undef
define i32 @test_undef() nounwind {
; X86-LABEL: test_undef:
; X86:       # %bb.0:
; X86-NEXT:    retl
;
; X64-LABEL: test_undef:
; X64:       # %bb.0:
; X64-NEXT:    retq
  %b = call i32 @llvm.bitreverse.i32(i32 undef)
  ret i32 %b
}

; fold (bitreverse (bitreverse x)) -> x
define i32 @test_bitreverse_bitreverse(i32 %a0) nounwind {
; X86-LABEL: test_bitreverse_bitreverse:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    retl
;
; X64-LABEL: test_bitreverse_bitreverse:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    retq
  %b = call i32 @llvm.bitreverse.i32(i32 %a0)
  %c = call i32 @llvm.bitreverse.i32(i32 %b)
  ret i32 %c
}

define <4 x i32> @test_demandedbits_bitreverse(<4 x i32> %a0) nounwind {
; X86-LABEL: test_demandedbits_bitreverse:
; X86:       # %bb.0:
; X86-NEXT:    pxor %xmm1, %xmm1
; X86-NEXT:    movdqa %xmm0, %xmm2
; X86-NEXT:    punpckhbw {{.*#+}} xmm2 = xmm2[8],xmm1[8],xmm2[9],xmm1[9],xmm2[10],xmm1[10],xmm2[11],xmm1[11],xmm2[12],xmm1[12],xmm2[13],xmm1[13],xmm2[14],xmm1[14],xmm2[15],xmm1[15]
; X86-NEXT:    pshuflw {{.*#+}} xmm2 = xmm2[3,2,1,0,4,5,6,7]
; X86-NEXT:    pshufhw {{.*#+}} xmm2 = xmm2[0,1,2,3,7,6,5,4]
; X86-NEXT:    punpcklbw {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
; X86-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[3,2,1,0,4,5,6,7]
; X86-NEXT:    pshufhw {{.*#+}} xmm0 = xmm0[0,1,2,3,7,6,5,4]
; X86-NEXT:    packuswb %xmm2, %xmm0
; X86-NEXT:    movdqa %xmm0, %xmm1
; X86-NEXT:    psllw $4, %xmm1
; X86-NEXT:    pand {{\.LCPI[0-9]+_[0-9]+}}, %xmm1
; X86-NEXT:    psrlw $4, %xmm0
; X86-NEXT:    pand {{\.LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-NEXT:    por %xmm1, %xmm0
; X86-NEXT:    movdqa {{.*#+}} xmm1 = [51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51]
; X86-NEXT:    pand %xmm0, %xmm1
; X86-NEXT:    psllw $2, %xmm1
; X86-NEXT:    pand {{\.LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-NEXT:    psrlw $2, %xmm0
; X86-NEXT:    por %xmm1, %xmm0
; X86-NEXT:    movdqa {{.*#+}} xmm1 = [85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85]
; X86-NEXT:    pand %xmm0, %xmm1
; X86-NEXT:    paddb %xmm1, %xmm1
; X86-NEXT:    pand {{\.LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-NEXT:    psrlw $1, %xmm0
; X86-NEXT:    por %xmm1, %xmm0
; X86-NEXT:    pand {{\.LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: test_demandedbits_bitreverse:
; X64:       # %bb.0:
; X64-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12]
; X64-NEXT:    vmovdqa {{.*#+}} xmm1 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
; X64-NEXT:    vpand %xmm1, %xmm0, %xmm2
; X64-NEXT:    vmovdqa {{.*#+}} xmm3 = [0,128,64,192,32,160,96,224,16,144,80,208,48,176,112,240]
; X64-NEXT:    vpshufb %xmm2, %xmm3, %xmm2
; X64-NEXT:    vpsrlw $4, %xmm0, %xmm0
; X64-NEXT:    vpand %xmm1, %xmm0, %xmm0
; X64-NEXT:    vmovdqa {{.*#+}} xmm1 = [0,8,4,12,2,10,6,14,1,9,5,13,3,11,7,15]
; X64-NEXT:    vpshufb %xmm0, %xmm1, %xmm0
; X64-NEXT:    vpor %xmm0, %xmm2, %xmm0
; X64-NEXT:    vpand {{.*}}(%rip), %xmm0, %xmm0
; X64-NEXT:    retq
  %b = or <4 x i32> %a0, <i32 2147483648, i32 2147483648, i32 2147483648, i32 2147483648>
  %c = call <4 x i32> @llvm.bitreverse.v4i32(<4 x i32> %b)
  %d = and <4 x i32> %c, <i32 -2, i32 -2, i32 -2, i32 -2>
  ret <4 x i32> %d
}
