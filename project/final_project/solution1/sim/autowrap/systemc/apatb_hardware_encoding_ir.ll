; ModuleID = '/mnt/castor/seas_home/l/lize1/ese532_final/project/final_project/solution1/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

; Function Attrs: noinline
define void @apatb_hardware_encoding_ir(i8* %s1, i16* %output) local_unnamed_addr #0 {
entry:
  %malloccall = tail call i8* @malloc(i64 32776)
  %s1_copy = bitcast i8* %malloccall to [32776 x i8]*
  %malloccall1 = tail call i8* @malloc(i64 65544)
  %output_copy = bitcast i8* %malloccall1 to [32772 x i16]*
  %0 = bitcast i8* %s1 to [32776 x i8]*
  %1 = bitcast i16* %output to [32772 x i16]*
  call fastcc void @copy_in([32776 x i8]* %0, [32776 x i8]* %s1_copy, [32772 x i16]* %1, [32772 x i16]* %output_copy)
  %2 = getelementptr inbounds [32772 x i16], [32772 x i16]* %output_copy, i32 0, i32 0
  call void @apatb_hardware_encoding_hw(i8* %malloccall, i16* %2)
  call fastcc void @copy_out([32776 x i8]* %0, [32776 x i8]* %s1_copy, [32772 x i16]* %1, [32772 x i16]* %output_copy)
  tail call void @free(i8* %malloccall)
  tail call void @free(i8* %malloccall1)
  ret void
}

declare noalias i8* @malloc(i64) local_unnamed_addr

; Function Attrs: argmemonly noinline
define internal fastcc void @copy_in([32776 x i8]* readonly, [32776 x i8]* noalias, [32772 x i16]* readonly, [32772 x i16]* noalias) unnamed_addr #1 {
entry:
  call fastcc void @onebyonecpy_hls.p0a32776i8([32776 x i8]* %1, [32776 x i8]* %0)
  call fastcc void @onebyonecpy_hls.p0a32772i16([32772 x i16]* %3, [32772 x i16]* %2)
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @onebyonecpy_hls.p0a32776i8([32776 x i8]* noalias, [32776 x i8]* noalias readonly) unnamed_addr #2 {
entry:
  %2 = icmp eq [32776 x i8]* %0, null
  %3 = icmp eq [32776 x i8]* %1, null
  %4 = or i1 %2, %3
  br i1 %4, label %ret, label %copy

copy:                                             ; preds = %entry
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %copy
  %for.loop.idx1 = phi i64 [ 0, %copy ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [32776 x i8], [32776 x i8]* %0, i64 0, i64 %for.loop.idx1
  %src.addr = getelementptr [32776 x i8], [32776 x i8]* %1, i64 0, i64 %for.loop.idx1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %dst.addr, i8* align 1 %src.addr, i64 1, i1 false)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx1, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, 32776
  br i1 %exitcond, label %for.loop, label %ret

ret:                                              ; preds = %for.loop, %entry
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #3

; Function Attrs: argmemonly noinline
define internal fastcc void @onebyonecpy_hls.p0a32772i16([32772 x i16]* noalias, [32772 x i16]* noalias readonly) unnamed_addr #2 {
entry:
  %2 = icmp eq [32772 x i16]* %0, null
  %3 = icmp eq [32772 x i16]* %1, null
  %4 = or i1 %2, %3
  br i1 %4, label %ret, label %copy

copy:                                             ; preds = %entry
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %copy
  %for.loop.idx3 = phi i64 [ 0, %copy ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr.gep1 = getelementptr [32772 x i16], [32772 x i16]* %0, i64 0, i64 %for.loop.idx3
  %5 = bitcast i16* %dst.addr.gep1 to i8*
  %src.addr.gep2 = getelementptr [32772 x i16], [32772 x i16]* %1, i64 0, i64 %for.loop.idx3
  %6 = bitcast i16* %src.addr.gep2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %5, i8* align 1 %6, i64 2, i1 false)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx3, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, 32772
  br i1 %exitcond, label %for.loop, label %ret

ret:                                              ; preds = %for.loop, %entry
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @copy_out([32776 x i8]*, [32776 x i8]* noalias readonly, [32772 x i16]*, [32772 x i16]* noalias readonly) unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0a32776i8([32776 x i8]* %0, [32776 x i8]* %1)
  call fastcc void @onebyonecpy_hls.p0a32772i16([32772 x i16]* %2, [32772 x i16]* %3)
  ret void
}

declare void @free(i8*) local_unnamed_addr

declare void @apatb_hardware_encoding_hw(i8*, i16*)

define void @hardware_encoding_hw_stub_wrapper(i8*, i16*) #5 {
entry:
  %2 = bitcast i8* %0 to [32776 x i8]*
  %3 = bitcast i16* %1 to [32772 x i16]*
  call void @copy_out([32776 x i8]* null, [32776 x i8]* %2, [32772 x i16]* null, [32772 x i16]* %3)
  %4 = bitcast [32776 x i8]* %2 to i8*
  %5 = bitcast [32772 x i16]* %3 to i16*
  call void @hardware_encoding_hw_stub(i8* %4, i16* %5)
  call void @copy_in([32776 x i8]* null, [32776 x i8]* %2, [32772 x i16]* null, [32772 x i16]* %3)
  ret void
}

declare void @hardware_encoding_hw_stub(i8*, i16*)

attributes #0 = { noinline "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { argmemonly noinline "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}