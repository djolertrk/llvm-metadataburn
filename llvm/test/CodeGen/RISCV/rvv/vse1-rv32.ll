; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+experimental-v -verify-machineinstrs \
; RUN:   < %s | FileCheck %s

declare void @llvm.riscv.vse1.nxv1i1(<vscale x 1 x i1>, <vscale x 1 x i1>*, i32);

define void @intrinsic_vse1_v_nxv1i1(<vscale x 1 x i1> %0, <vscale x 1 x i1>* %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vse1_v_nxv1i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8,mf8,ta,mu
; CHECK-NEXT:    vse1.v v0, (a0)
; CHECK-NEXT:    ret
entry:
  call void @llvm.riscv.vse1.nxv1i1(<vscale x 1 x i1> %0, <vscale x 1 x i1>* %1, i32 %2)
  ret void
}

declare void @llvm.riscv.vse1.nxv2i1(<vscale x 2 x i1>, <vscale x 2 x i1>*, i32);

define void @intrinsic_vse1_v_nxv2i1(<vscale x 2 x i1> %0, <vscale x 2 x i1>* %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vse1_v_nxv2i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8,mf4,ta,mu
; CHECK-NEXT:    vse1.v v0, (a0)
; CHECK-NEXT:    ret
entry:
  call void @llvm.riscv.vse1.nxv2i1(<vscale x 2 x i1> %0, <vscale x 2 x i1>* %1, i32 %2)
  ret void
}

declare void @llvm.riscv.vse1.nxv4i1(<vscale x 4 x i1>, <vscale x 4 x i1>*, i32);

define void @intrinsic_vse1_v_nxv4i1(<vscale x 4 x i1> %0, <vscale x 4 x i1>* %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vse1_v_nxv4i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8,mf2,ta,mu
; CHECK-NEXT:    vse1.v v0, (a0)
; CHECK-NEXT:    ret
entry:
  call void @llvm.riscv.vse1.nxv4i1(<vscale x 4 x i1> %0, <vscale x 4 x i1>* %1, i32 %2)
  ret void
}

declare void @llvm.riscv.vse1.nxv8i1(<vscale x 8 x i1>, <vscale x 8 x i1>*, i32);

define void @intrinsic_vse1_v_nxv8i1(<vscale x 8 x i1> %0, <vscale x 8 x i1>* %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vse1_v_nxv8i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8,m1,ta,mu
; CHECK-NEXT:    vse1.v v0, (a0)
; CHECK-NEXT:    ret
entry:
  call void @llvm.riscv.vse1.nxv8i1(<vscale x 8 x i1> %0, <vscale x 8 x i1>* %1, i32 %2)
  ret void
}

declare void @llvm.riscv.vse1.nxv16i1(<vscale x 16 x i1>, <vscale x 16 x i1>*, i32);

define void @intrinsic_vse1_v_nxv16i1(<vscale x 16 x i1> %0, <vscale x 16 x i1>* %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vse1_v_nxv16i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8,m2,ta,mu
; CHECK-NEXT:    vse1.v v0, (a0)
; CHECK-NEXT:    ret
entry:
  call void @llvm.riscv.vse1.nxv16i1(<vscale x 16 x i1> %0, <vscale x 16 x i1>* %1, i32 %2)
  ret void
}

declare void @llvm.riscv.vse1.nxv32i1(<vscale x 32 x i1>, <vscale x 32 x i1>*, i32);

define void @intrinsic_vse1_v_nxv32i1(<vscale x 32 x i1> %0, <vscale x 32 x i1>* %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vse1_v_nxv32i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8,m4,ta,mu
; CHECK-NEXT:    vse1.v v0, (a0)
; CHECK-NEXT:    ret
entry:
  call void @llvm.riscv.vse1.nxv32i1(<vscale x 32 x i1> %0, <vscale x 32 x i1>* %1, i32 %2)
  ret void
}

declare void @llvm.riscv.vse1.nxv64i1(<vscale x 64 x i1>, <vscale x 64 x i1>*, i32);

define void @intrinsic_vse1_v_nxv64i1(<vscale x 64 x i1> %0, <vscale x 64 x i1>* %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vse1_v_nxv64i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8,m8,ta,mu
; CHECK-NEXT:    vse1.v v0, (a0)
; CHECK-NEXT:    ret
entry:
  call void @llvm.riscv.vse1.nxv64i1(<vscale x 64 x i1> %0, <vscale x 64 x i1>* %1, i32 %2)
  ret void
}
