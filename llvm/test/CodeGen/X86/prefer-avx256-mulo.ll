; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vl,+prefer-256-bit | FileCheck %s --check-prefix=AVX256
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vl,-prefer-256-bit | FileCheck %s --check-prefix=AVX512

define <16 x i1> @smulo_v16i8(<16 x i8> %a0, <16 x i8> %a1, <16 x i8>* %p2) nounwind {
; AVX256-LABEL: smulo_v16i8:
; AVX256:       # %bb.0:
; AVX256-NEXT:    vpmovsxbw %xmm1, %ymm1
; AVX256-NEXT:    vpmovsxbw %xmm0, %ymm0
; AVX256-NEXT:    vpmullw %ymm1, %ymm0, %ymm0
; AVX256-NEXT:    vpsrlw $8, %ymm0, %ymm1
; AVX256-NEXT:    vextracti128 $1, %ymm1, %xmm2
; AVX256-NEXT:    vpackuswb %xmm2, %xmm1, %xmm1
; AVX256-NEXT:    vpand {{.*}}(%rip), %ymm0, %ymm0
; AVX256-NEXT:    vextracti128 $1, %ymm0, %xmm2
; AVX256-NEXT:    vpackuswb %xmm2, %xmm0, %xmm0
; AVX256-NEXT:    vpxor %xmm2, %xmm2, %xmm2
; AVX256-NEXT:    vpcmpgtb %xmm0, %xmm2, %xmm2
; AVX256-NEXT:    vpcmpeqb %xmm1, %xmm2, %xmm1
; AVX256-NEXT:    vpternlogq $15, %xmm1, %xmm1, %xmm1
; AVX256-NEXT:    vpshufd {{.*#+}} xmm2 = xmm1[2,3,2,3]
; AVX256-NEXT:    vpmovsxbd %xmm2, %ymm2
; AVX256-NEXT:    vptestmd %ymm2, %ymm2, %k1
; AVX256-NEXT:    vpmovsxbd %xmm1, %ymm1
; AVX256-NEXT:    vptestmd %ymm1, %ymm1, %k2
; AVX256-NEXT:    vmovdqa %xmm0, (%rdi)
; AVX256-NEXT:    vpcmpeqd %ymm0, %ymm0, %ymm0
; AVX256-NEXT:    vmovdqa32 %ymm0, %ymm1 {%k2} {z}
; AVX256-NEXT:    vpmovdw %ymm1, %xmm1
; AVX256-NEXT:    vmovdqa32 %ymm0, %ymm0 {%k1} {z}
; AVX256-NEXT:    vpmovdw %ymm0, %xmm0
; AVX256-NEXT:    vpacksswb %xmm0, %xmm1, %xmm0
; AVX256-NEXT:    vzeroupper
; AVX256-NEXT:    retq
;
; AVX512-LABEL: smulo_v16i8:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpmovsxbw %xmm1, %ymm1
; AVX512-NEXT:    vpmovsxbw %xmm0, %ymm0
; AVX512-NEXT:    vpmullw %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsraw $8, %ymm0, %ymm1
; AVX512-NEXT:    vpmovsxwd %ymm1, %zmm1
; AVX512-NEXT:    vpsllw $8, %ymm0, %ymm2
; AVX512-NEXT:    vpsraw $15, %ymm2, %ymm2
; AVX512-NEXT:    vpmovsxwd %ymm2, %zmm2
; AVX512-NEXT:    vpcmpneqd %zmm1, %zmm2, %k1
; AVX512-NEXT:    vpmovzxwd {{.*#+}} zmm0 = ymm0[0],zero,ymm0[1],zero,ymm0[2],zero,ymm0[3],zero,ymm0[4],zero,ymm0[5],zero,ymm0[6],zero,ymm0[7],zero,ymm0[8],zero,ymm0[9],zero,ymm0[10],zero,ymm0[11],zero,ymm0[12],zero,ymm0[13],zero,ymm0[14],zero,ymm0[15],zero
; AVX512-NEXT:    vpmovdb %zmm0, (%rdi)
; AVX512-NEXT:    vpternlogd $255, %zmm0, %zmm0, %zmm0 {%k1} {z}
; AVX512-NEXT:    vpmovdb %zmm0, %xmm0
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %t = call {<16 x i8>, <16 x i1>} @llvm.smul.with.overflow.v16i8(<16 x i8> %a0, <16 x i8> %a1)
  %val = extractvalue {<16 x i8>, <16 x i1>} %t, 0
  %obit = extractvalue {<16 x i8>, <16 x i1>} %t, 1
  store <16 x i8> %val, <16 x i8>* %p2
  ret <16 x i1> %obit
}
declare {<16 x i8>, <16 x i1>} @llvm.smul.with.overflow.v16i8(<16 x i8>, <16 x i8>)

define <16 x i1> @umulo_v16i8(<16 x i8> %a0, <16 x i8> %a1, <16 x i8>* %p2) nounwind {
; AVX256-LABEL: umulo_v16i8:
; AVX256:       # %bb.0:
; AVX256-NEXT:    vpmovzxbw {{.*#+}} ymm1 = xmm1[0],zero,xmm1[1],zero,xmm1[2],zero,xmm1[3],zero,xmm1[4],zero,xmm1[5],zero,xmm1[6],zero,xmm1[7],zero,xmm1[8],zero,xmm1[9],zero,xmm1[10],zero,xmm1[11],zero,xmm1[12],zero,xmm1[13],zero,xmm1[14],zero,xmm1[15],zero
; AVX256-NEXT:    vpmovzxbw {{.*#+}} ymm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero,xmm0[8],zero,xmm0[9],zero,xmm0[10],zero,xmm0[11],zero,xmm0[12],zero,xmm0[13],zero,xmm0[14],zero,xmm0[15],zero
; AVX256-NEXT:    vpmullw %ymm1, %ymm0, %ymm0
; AVX256-NEXT:    vpsrlw $8, %ymm0, %ymm1
; AVX256-NEXT:    vextracti128 $1, %ymm1, %xmm2
; AVX256-NEXT:    vpackuswb %xmm2, %xmm1, %xmm1
; AVX256-NEXT:    vpxor %xmm2, %xmm2, %xmm2
; AVX256-NEXT:    vpcmpeqb %xmm2, %xmm1, %xmm1
; AVX256-NEXT:    vpternlogq $15, %xmm1, %xmm1, %xmm1
; AVX256-NEXT:    vpshufd {{.*#+}} xmm2 = xmm1[2,3,2,3]
; AVX256-NEXT:    vpmovsxbd %xmm2, %ymm2
; AVX256-NEXT:    vptestmd %ymm2, %ymm2, %k1
; AVX256-NEXT:    vpmovsxbd %xmm1, %ymm1
; AVX256-NEXT:    vptestmd %ymm1, %ymm1, %k2
; AVX256-NEXT:    vpand {{.*}}(%rip), %ymm0, %ymm0
; AVX256-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX256-NEXT:    vpackuswb %xmm1, %xmm0, %xmm0
; AVX256-NEXT:    vmovdqa %xmm0, (%rdi)
; AVX256-NEXT:    vpcmpeqd %ymm0, %ymm0, %ymm0
; AVX256-NEXT:    vmovdqa32 %ymm0, %ymm1 {%k2} {z}
; AVX256-NEXT:    vpmovdw %ymm1, %xmm1
; AVX256-NEXT:    vmovdqa32 %ymm0, %ymm0 {%k1} {z}
; AVX256-NEXT:    vpmovdw %ymm0, %xmm0
; AVX256-NEXT:    vpacksswb %xmm0, %xmm1, %xmm0
; AVX256-NEXT:    vzeroupper
; AVX256-NEXT:    retq
;
; AVX512-LABEL: umulo_v16i8:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpmovzxbw {{.*#+}} ymm1 = xmm1[0],zero,xmm1[1],zero,xmm1[2],zero,xmm1[3],zero,xmm1[4],zero,xmm1[5],zero,xmm1[6],zero,xmm1[7],zero,xmm1[8],zero,xmm1[9],zero,xmm1[10],zero,xmm1[11],zero,xmm1[12],zero,xmm1[13],zero,xmm1[14],zero,xmm1[15],zero
; AVX512-NEXT:    vpmovzxbw {{.*#+}} ymm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero,xmm0[8],zero,xmm0[9],zero,xmm0[10],zero,xmm0[11],zero,xmm0[12],zero,xmm0[13],zero,xmm0[14],zero,xmm0[15],zero
; AVX512-NEXT:    vpmullw %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vpsrlw $8, %ymm0, %ymm1
; AVX512-NEXT:    vpmovzxwd {{.*#+}} zmm1 = ymm1[0],zero,ymm1[1],zero,ymm1[2],zero,ymm1[3],zero,ymm1[4],zero,ymm1[5],zero,ymm1[6],zero,ymm1[7],zero,ymm1[8],zero,ymm1[9],zero,ymm1[10],zero,ymm1[11],zero,ymm1[12],zero,ymm1[13],zero,ymm1[14],zero,ymm1[15],zero
; AVX512-NEXT:    vptestmd %zmm1, %zmm1, %k1
; AVX512-NEXT:    vpmovzxwd {{.*#+}} zmm0 = ymm0[0],zero,ymm0[1],zero,ymm0[2],zero,ymm0[3],zero,ymm0[4],zero,ymm0[5],zero,ymm0[6],zero,ymm0[7],zero,ymm0[8],zero,ymm0[9],zero,ymm0[10],zero,ymm0[11],zero,ymm0[12],zero,ymm0[13],zero,ymm0[14],zero,ymm0[15],zero
; AVX512-NEXT:    vpmovdb %zmm0, (%rdi)
; AVX512-NEXT:    vpternlogd $255, %zmm0, %zmm0, %zmm0 {%k1} {z}
; AVX512-NEXT:    vpmovdb %zmm0, %xmm0
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %t = call {<16 x i8>, <16 x i1>} @llvm.umul.with.overflow.v16i8(<16 x i8> %a0, <16 x i8> %a1)
  %val = extractvalue {<16 x i8>, <16 x i1>} %t, 0
  %obit = extractvalue {<16 x i8>, <16 x i1>} %t, 1
  store <16 x i8> %val, <16 x i8>* %p2
  ret <16 x i1> %obit
}
declare {<16 x i8>, <16 x i1>} @llvm.umul.with.overflow.v16i8(<16 x i8>, <16 x i8>)
