; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=amdgcn -mcpu=gfx900 -verify-machineinstrs -amdgpu-spill-sgpr-to-vgpr=true < %s | FileCheck -check-prefix=SPILL-TO-VGPR %s
; RUN: llc -march=amdgcn -mcpu=gfx900 -verify-machineinstrs -amdgpu-spill-sgpr-to-vgpr=false < %s | FileCheck -check-prefix=NO-SPILL-TO-VGPR %s

; Check frame setup where SGPR spills to VGPRs are disabled or enabled.

declare hidden void @external_void_func_void() #0

define void @callee_with_stack_and_call() #0 {
; SPILL-TO-VGPR-LABEL: callee_with_stack_and_call:
; SPILL-TO-VGPR:       ; %bb.0:
; SPILL-TO-VGPR-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; SPILL-TO-VGPR-NEXT:    s_or_saveexec_b64 s[4:5], -1
; SPILL-TO-VGPR-NEXT:    buffer_store_dword v40, off, s[0:3], s32 offset:4 ; 4-byte Folded Spill
; SPILL-TO-VGPR-NEXT:    s_mov_b64 exec, s[4:5]
; SPILL-TO-VGPR-NEXT:    v_writelane_b32 v40, s33, 2
; SPILL-TO-VGPR-NEXT:    v_writelane_b32 v40, s30, 0
; SPILL-TO-VGPR-NEXT:    s_mov_b32 s33, s32
; SPILL-TO-VGPR-NEXT:    s_add_u32 s32, s32, 0x400
; SPILL-TO-VGPR-NEXT:    v_mov_b32_e32 v0, 0
; SPILL-TO-VGPR-NEXT:    s_getpc_b64 s[4:5]
; SPILL-TO-VGPR-NEXT:    s_add_u32 s4, s4, external_void_func_void@rel32@lo+4
; SPILL-TO-VGPR-NEXT:    s_addc_u32 s5, s5, external_void_func_void@rel32@hi+12
; SPILL-TO-VGPR-NEXT:    v_writelane_b32 v40, s31, 1
; SPILL-TO-VGPR-NEXT:    buffer_store_dword v0, off, s[0:3], s33
; SPILL-TO-VGPR-NEXT:    s_waitcnt vmcnt(0)
; SPILL-TO-VGPR-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; SPILL-TO-VGPR-NEXT:    v_readlane_b32 s4, v40, 0
; SPILL-TO-VGPR-NEXT:    v_readlane_b32 s5, v40, 1
; SPILL-TO-VGPR-NEXT:    s_sub_u32 s32, s32, 0x400
; SPILL-TO-VGPR-NEXT:    v_readlane_b32 s33, v40, 2
; SPILL-TO-VGPR-NEXT:    s_or_saveexec_b64 s[6:7], -1
; SPILL-TO-VGPR-NEXT:    buffer_load_dword v40, off, s[0:3], s32 offset:4 ; 4-byte Folded Reload
; SPILL-TO-VGPR-NEXT:    s_mov_b64 exec, s[6:7]
; SPILL-TO-VGPR-NEXT:    s_waitcnt vmcnt(0)
; SPILL-TO-VGPR-NEXT:    s_setpc_b64 s[4:5]
;
; NO-SPILL-TO-VGPR-LABEL: callee_with_stack_and_call:
; NO-SPILL-TO-VGPR:       ; %bb.0:
; NO-SPILL-TO-VGPR-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; NO-SPILL-TO-VGPR-NEXT:    v_mov_b32_e32 v0, s33
; NO-SPILL-TO-VGPR-NEXT:    buffer_store_dword v0, off, s[0:3], s32 offset:12 ; 4-byte Folded Spill
; NO-SPILL-TO-VGPR-NEXT:    s_mov_b32 s33, s32
; NO-SPILL-TO-VGPR-NEXT:    s_add_u32 s32, s32, 0x800
; NO-SPILL-TO-VGPR-NEXT:    s_mov_b64 s[6:7], exec
; NO-SPILL-TO-VGPR-NEXT:    s_mov_b64 exec, 3
; NO-SPILL-TO-VGPR-NEXT:    buffer_store_dword v1, off, s[0:3], s33 offset:16
; NO-SPILL-TO-VGPR-NEXT:    v_writelane_b32 v1, s30, 0
; NO-SPILL-TO-VGPR-NEXT:    v_writelane_b32 v1, s31, 1
; NO-SPILL-TO-VGPR-NEXT:    buffer_store_dword v1, off, s[0:3], s33 offset:4 ; 4-byte Folded Spill
; NO-SPILL-TO-VGPR-NEXT:    buffer_load_dword v1, off, s[0:3], s33 offset:16
; NO-SPILL-TO-VGPR-NEXT:    s_waitcnt vmcnt(0)
; NO-SPILL-TO-VGPR-NEXT:    s_mov_b64 exec, s[6:7]
; NO-SPILL-TO-VGPR-NEXT:    v_mov_b32_e32 v0, 0
; NO-SPILL-TO-VGPR-NEXT:    s_getpc_b64 s[4:5]
; NO-SPILL-TO-VGPR-NEXT:    s_add_u32 s4, s4, external_void_func_void@rel32@lo+4
; NO-SPILL-TO-VGPR-NEXT:    s_addc_u32 s5, s5, external_void_func_void@rel32@hi+12
; NO-SPILL-TO-VGPR-NEXT:    buffer_store_dword v0, off, s[0:3], s33
; NO-SPILL-TO-VGPR-NEXT:    s_waitcnt vmcnt(0)
; NO-SPILL-TO-VGPR-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; NO-SPILL-TO-VGPR-NEXT:    s_mov_b64 s[6:7], exec
; NO-SPILL-TO-VGPR-NEXT:    s_mov_b64 exec, 3
; NO-SPILL-TO-VGPR-NEXT:    buffer_store_dword v1, off, s[0:3], s33 offset:16
; NO-SPILL-TO-VGPR-NEXT:    buffer_load_dword v1, off, s[0:3], s33 offset:4 ; 4-byte Folded Reload
; NO-SPILL-TO-VGPR-NEXT:    s_waitcnt vmcnt(0)
; NO-SPILL-TO-VGPR-NEXT:    v_readlane_b32 s4, v1, 0
; NO-SPILL-TO-VGPR-NEXT:    v_readlane_b32 s5, v1, 1
; NO-SPILL-TO-VGPR-NEXT:    buffer_load_dword v1, off, s[0:3], s33 offset:16
; NO-SPILL-TO-VGPR-NEXT:    s_waitcnt vmcnt(0)
; NO-SPILL-TO-VGPR-NEXT:    s_mov_b64 exec, s[6:7]
; NO-SPILL-TO-VGPR-NEXT:    s_sub_u32 s32, s32, 0x800
; NO-SPILL-TO-VGPR-NEXT:    buffer_load_dword v0, off, s[0:3], s32 offset:12 ; 4-byte Folded Reload
; NO-SPILL-TO-VGPR-NEXT:    s_waitcnt vmcnt(0)
; NO-SPILL-TO-VGPR-NEXT:    v_readfirstlane_b32 s33, v0
; NO-SPILL-TO-VGPR-NEXT:    s_setpc_b64 s[4:5]
  %alloca = alloca i32, addrspace(5)
  store volatile i32 0, i32 addrspace(5)* %alloca
  call void @external_void_func_void()
  ret void
}

attributes #0 = { nounwind }
