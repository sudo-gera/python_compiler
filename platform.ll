; ModuleID = 'platform.cpp'
source_filename = "platform.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx14.0.0"

%"class.std::__1::basic_ostream" = type { ptr, %"class.std::__1::basic_ios.base" }
%"class.std::__1::basic_ios.base" = type <{ %"class.std::__1::ios_base", ptr, i32 }>
%"class.std::__1::ios_base" = type { ptr, i32, i64, i64, i32, i32, ptr, ptr, ptr, ptr, i64, i64, ptr, i64, i64, ptr, i64, i64 }
%"class.std::__1::locale::id" = type <{ %"struct.std::__1::once_flag", i32, [4 x i8] }>
%"struct.std::__1::once_flag" = type { i64 }
%"class.std::__1::basic_string" = type { %"class.std::__1::__compressed_pair" }
%"class.std::__1::__compressed_pair" = type { %"struct.std::__1::__compressed_pair_elem" }
%"struct.std::__1::__compressed_pair_elem" = type { %"struct.std::__1::basic_string<char>::__rep" }
%"struct.std::__1::basic_string<char>::__rep" = type { %union.anon }
%union.anon = type { %"struct.std::__1::basic_string<char>::__long" }
%"struct.std::__1::basic_string<char>::__long" = type { ptr, i64, i64 }
%"class.std::__1::__wrap_iter" = type { ptr }
%"struct.std::__1::__default_init_tag" = type { i8 }
%"struct.std::__1::basic_string<char>::__short" = type { [23 x i8], [0 x i8], i8 }
%"struct.std::__1::random_access_iterator_tag" = type { i8 }
%"struct.std::__1::__allocation_result" = type { ptr, i64 }
%"class.std::__1::basic_ostream<char>::sentry" = type { i8, ptr }
%"class.std::__1::ostreambuf_iterator" = type { ptr }
%"class.std::__1::basic_ios" = type <{ %"class.std::__1::ios_base", ptr, i32, [4 x i8] }>
%"class.std::__1::locale" = type { ptr }

@_ZNSt3__14coutE = external global %"class.std::__1::basic_ostream", align 8
@__PRETTY_FUNCTION__._Z7strtypeIFPvmmEENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEEv = private unnamed_addr constant [65 x i8] c"std::string strtype() [T = void *(unsigned long, unsigned long)]\00", align 1
@.str = private unnamed_addr constant [13 x i8] c"basic_string\00", align 1
@_ZTISt12length_error = external constant ptr
@_ZTVSt12length_error = external unnamed_addr constant { [5 x ptr] }, align 8
@_ZTISt20bad_array_new_length = external constant ptr
@_ZNSt3__15ctypeIcE2idE = external global %"class.std::__1::locale::id", align 8

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define void @f() #0 {
  ret void
}

; Function Attrs: mustprogress noinline norecurse optnone ssp uwtable(sync)
define i32 @main() #1 personality ptr @__gxx_personality_v0 {
  %1 = alloca %"class.std::__1::basic_string", align 8
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  call void @_Z7strtypeIFPvmmEENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEERKT_(ptr sret(%"class.std::__1::basic_string") align 8 %1, ptr noundef nonnull @calloc)
  %4 = invoke noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__1lsB8ue170006IcNS_11char_traitsIcEENS_9allocatorIcEEEERNS_13basic_ostreamIT_T0_EES9_RKNS_12basic_stringIS6_S7_T1_EE(ptr noundef nonnull align 8 dereferenceable(8) @_ZNSt3__14coutE, ptr noundef nonnull align 8 dereferenceable(24) %1)
          to label %5 unwind label %9

5:                                                ; preds = %0
  %6 = invoke noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsB8ue170006EPFRS3_S4_E(ptr noundef %4, ptr noundef @_ZNSt3__14endlB8ue170006IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_)
          to label %7 unwind label %9

7:                                                ; preds = %5
  %8 = call ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(ptr noundef %1) #13
  ret i32 0

9:                                                ; preds = %5, %0
  %10 = landingpad { ptr, i32 }
          cleanup
  %11 = extractvalue { ptr, i32 } %10, 0
  store ptr %11, ptr %2, align 8
  %12 = extractvalue { ptr, i32 } %10, 1
  store i32 %12, ptr %3, align 4
  %13 = call ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(ptr noundef %1) #13
  br label %14

14:                                               ; preds = %9
  %15 = load ptr, ptr %2, align 8
  %16 = load i32, ptr %3, align 4
  %17 = insertvalue { ptr, i32 } undef, ptr %15, 0
  %18 = insertvalue { ptr, i32 } %17, i32 %16, 1
  resume { ptr, i32 } %18
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__1lsB8ue170006IcNS_11char_traitsIcEENS_9allocatorIcEEEERNS_13basic_ostreamIT_T0_EES9_RKNS_12basic_stringIS6_S7_T1_EE(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef nonnull align 8 dereferenceable(24) %1) #2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = call ptr @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataB8ue170006Ev(ptr noundef %6) #13
  %8 = load ptr, ptr %4, align 8
  %9 = call i64 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4sizeB8ue170006Ev(ptr noundef %8) #13
  %10 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__124__put_character_sequenceB8ue170006IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m(ptr noundef nonnull align 8 dereferenceable(8) %5, ptr noundef %7, i64 noundef %9)
  ret ptr %10
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr void @_Z7strtypeIFPvmmEENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEERKT_(ptr noalias sret(%"class.std::__1::basic_string") align 8 %0, ptr noundef nonnull %1) #2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  call void @_Z7strtypeIFPvmmEENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEEv(ptr sret(%"class.std::__1::basic_string") align 8 %0)
  ret void
}

; Function Attrs: allocsize(0,1)
declare ptr @calloc(i64 noundef, i64 noundef) #3

declare i32 @__gxx_personality_v0(...)

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsB8ue170006EPFRS3_S4_E(ptr noundef %0, ptr noundef %1) #2 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = call noundef nonnull align 8 dereferenceable(8) ptr %6(ptr noundef nonnull align 8 dereferenceable(8) %5)
  ret ptr %7
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__14endlB8ue170006IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_(ptr noundef nonnull align 8 dereferenceable(8) %0) #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  %5 = load ptr, ptr %4, align 8
  %6 = getelementptr i8, ptr %5, i64 -24
  %7 = load i64, ptr %6, align 8
  %8 = getelementptr inbounds i8, ptr %4, i64 %7
  %9 = call signext i8 @_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenB8ue170006Ec(ptr noundef %8, i8 noundef signext 10)
  %10 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc(ptr noundef %3, i8 noundef signext %9)
  %11 = load ptr, ptr %2, align 8
  %12 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv(ptr noundef %11)
  %13 = load ptr, ptr %2, align 8
  ret ptr %13
}

; Function Attrs: nounwind
declare ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(ptr noundef returned) unnamed_addr #4

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr void @_Z7strtypeIFPvmmEENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEEv(ptr noalias sret(%"class.std::__1::basic_string") align 8 %0) #2 personality ptr @__gxx_personality_v0 {
  %2 = alloca ptr, align 8
  %3 = alloca %"class.std::__1::basic_string", align 8
  %4 = alloca %"class.std::__1::__wrap_iter", align 8
  %5 = alloca %"class.std::__1::__wrap_iter", align 8
  %6 = alloca %"class.std::__1::__wrap_iter", align 8
  %7 = alloca %"class.std::__1::__wrap_iter", align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %10 = call ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1B8ue170006ILi0EEEPKc(ptr noundef %3, ptr noundef @__PRETTY_FUNCTION__._Z7strtypeIFPvmmEENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEEv)
  %11 = call i64 @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5beginB8ue170006Ev(ptr noundef %3) #13
  %12 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %5, i32 0, i32 0
  %13 = inttoptr i64 %11 to ptr
  store ptr %13, ptr %12, align 8
  %14 = call i64 @_ZNKSt3__111__wrap_iterIPcEplB8ue170006El(ptr noundef %5, i64 noundef 27) #13
  %15 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %4, i32 0, i32 0
  %16 = inttoptr i64 %14 to ptr
  store ptr %16, ptr %15, align 8
  %17 = call i64 @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE3endB8ue170006Ev(ptr noundef %3) #13
  %18 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %7, i32 0, i32 0
  %19 = inttoptr i64 %17 to ptr
  store ptr %19, ptr %18, align 8
  %20 = call i64 @_ZNKSt3__111__wrap_iterIPcEmiB8ue170006El(ptr noundef %7, i64 noundef 1) #13
  %21 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %6, i32 0, i32 0
  %22 = inttoptr i64 %20 to ptr
  store ptr %22, ptr %21, align 8
  %23 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %4, i32 0, i32 0
  %24 = load ptr, ptr %23, align 8
  %25 = ptrtoint ptr %24 to i64
  %26 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %6, i32 0, i32 0
  %27 = load ptr, ptr %26, align 8
  %28 = ptrtoint ptr %27 to i64
  %29 = invoke ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1B8ue170006INS_11__wrap_iterIPcEELi0EEET_SA_(ptr noundef %0, i64 %25, i64 %28)
          to label %30 unwind label %32

30:                                               ; preds = %1
  %31 = call ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(ptr noundef %3) #13
  ret void

32:                                               ; preds = %1
  %33 = landingpad { ptr, i32 }
          cleanup
  %34 = extractvalue { ptr, i32 } %33, 0
  store ptr %34, ptr %8, align 8
  %35 = extractvalue { ptr, i32 } %33, 1
  store i32 %35, ptr %9, align 4
  %36 = call ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(ptr noundef %3) #13
  br label %37

37:                                               ; preds = %32
  %38 = load ptr, ptr %8, align 8
  %39 = load i32, ptr %9, align 4
  %40 = insertvalue { ptr, i32 } undef, ptr %38, 0
  %41 = insertvalue { ptr, i32 } %40, i32 %39, 1
  resume { ptr, i32 } %41
}

; Function Attrs: noinline optnone ssp uwtable(sync)
define linkonce_odr ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1B8ue170006ILi0EEEPKc(ptr noundef returned %0, ptr noundef %1) unnamed_addr #5 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = call ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2B8ue170006ILi0EEEPKc(ptr noundef %5, ptr noundef %6)
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5beginB8ue170006Ev(ptr noundef %0) #0 align 2 personality ptr @__gxx_personality_v0 {
  %2 = alloca %"class.std::__1::__wrap_iter", align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  %5 = call ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13__get_pointerB8ue170006Ev(ptr noundef %4) #13
  %6 = invoke i64 @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE15__make_iteratorB8ue170006EPc(ptr noundef %4, ptr noundef %5)
          to label %7 unwind label %13

7:                                                ; preds = %1
  %8 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %2, i32 0, i32 0
  %9 = inttoptr i64 %6 to ptr
  store ptr %9, ptr %8, align 8
  %10 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %2, i32 0, i32 0
  %11 = load ptr, ptr %10, align 8
  %12 = ptrtoint ptr %11 to i64
  ret i64 %12

13:                                               ; preds = %1
  %14 = landingpad { ptr, i32 }
          catch ptr null
  %15 = extractvalue { ptr, i32 } %14, 0
  call void @__clang_call_terminate(ptr %15) #14
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNKSt3__111__wrap_iterIPcEplB8ue170006El(ptr noundef %0, i64 noundef %1) #0 align 2 {
  %3 = alloca %"class.std::__1::__wrap_iter", align 8
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  %6 = load ptr, ptr %4, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %3, ptr align 8 %6, i64 8, i1 false)
  %7 = load i64, ptr %5, align 8
  %8 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__111__wrap_iterIPcEpLB8ue170006El(ptr noundef %3, i64 noundef %7) #13
  %9 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %3, i32 0, i32 0
  %10 = load ptr, ptr %9, align 8
  %11 = ptrtoint ptr %10 to i64
  ret i64 %11
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE3endB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca %"class.std::__1::__wrap_iter", align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  %5 = call ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13__get_pointerB8ue170006Ev(ptr noundef %4) #13
  %6 = call i64 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4sizeB8ue170006Ev(ptr noundef %4) #13
  %7 = getelementptr inbounds i8, ptr %5, i64 %6
  %8 = call i64 @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE15__make_iteratorB8ue170006EPc(ptr noundef %4, ptr noundef %7)
  %9 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %2, i32 0, i32 0
  %10 = inttoptr i64 %8 to ptr
  store ptr %10, ptr %9, align 8
  %11 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %2, i32 0, i32 0
  %12 = load ptr, ptr %11, align 8
  %13 = ptrtoint ptr %12 to i64
  ret i64 %13
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNKSt3__111__wrap_iterIPcEmiB8ue170006El(ptr noundef %0, i64 noundef %1) #0 align 2 {
  %3 = alloca %"class.std::__1::__wrap_iter", align 8
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = load i64, ptr %5, align 8
  %8 = sub nsw i64 0, %7
  %9 = call i64 @_ZNKSt3__111__wrap_iterIPcEplB8ue170006El(ptr noundef %6, i64 noundef %8) #13
  %10 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %3, i32 0, i32 0
  %11 = inttoptr i64 %9 to ptr
  store ptr %11, ptr %10, align 8
  %12 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %3, i32 0, i32 0
  %13 = load ptr, ptr %12, align 8
  %14 = ptrtoint ptr %13 to i64
  ret i64 %14
}

; Function Attrs: noinline optnone ssp uwtable(sync)
define linkonce_odr ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1B8ue170006INS_11__wrap_iterIPcEELi0EEET_SA_(ptr noundef returned %0, i64 %1, i64 %2) unnamed_addr #5 align 2 {
  %4 = alloca %"class.std::__1::__wrap_iter", align 8
  %5 = alloca %"class.std::__1::__wrap_iter", align 8
  %6 = alloca ptr, align 8
  %7 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %4, i32 0, i32 0
  %8 = inttoptr i64 %1 to ptr
  store ptr %8, ptr %7, align 8
  %9 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %5, i32 0, i32 0
  %10 = inttoptr i64 %2 to ptr
  store ptr %10, ptr %9, align 8
  store ptr %0, ptr %6, align 8
  %11 = load ptr, ptr %6, align 8
  %12 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %4, i32 0, i32 0
  %13 = load ptr, ptr %12, align 8
  %14 = ptrtoint ptr %13 to i64
  %15 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %5, i32 0, i32 0
  %16 = load ptr, ptr %15, align 8
  %17 = ptrtoint ptr %16 to i64
  %18 = call ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2B8ue170006INS_11__wrap_iterIPcEELi0EEET_SA_(ptr noundef %11, i64 %14, i64 %17)
  ret ptr %11
}

; Function Attrs: noinline optnone ssp uwtable(sync)
define linkonce_odr ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2B8ue170006ILi0EEEPKc(ptr noundef returned %0, ptr noundef %1) unnamed_addr #5 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca %"struct.std::__1::__default_init_tag", align 1
  %6 = alloca %"struct.std::__1::__default_init_tag", align 1
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %7 = load ptr, ptr %3, align 8
  %8 = getelementptr inbounds %"class.std::__1::basic_string", ptr %7, i32 0, i32 0
  %9 = call ptr @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC1B8ue170006INS_18__default_init_tagESA_EEOT_OT0_(ptr noundef %8, ptr noundef nonnull align 1 dereferenceable(1) %5, ptr noundef nonnull align 1 dereferenceable(1) %6)
  %10 = load ptr, ptr %4, align 8
  %11 = load ptr, ptr %4, align 8
  %12 = call i64 @_ZNSt3__111char_traitsIcE6lengthB8ue170006EPKc(ptr noundef %11) #13
  call void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6__initEPKcm(ptr noundef %7, ptr noundef %10, i64 noundef %12)
  ret ptr %7
}

; Function Attrs: noinline optnone ssp uwtable(sync)
define linkonce_odr ptr @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC1B8ue170006INS_18__default_init_tagESA_EEOT_OT0_(ptr noundef returned %0, ptr noundef nonnull align 1 dereferenceable(1) %1, ptr noundef nonnull align 1 dereferenceable(1) %2) unnamed_addr #5 align 2 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = call ptr @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC2B8ue170006INS_18__default_init_tagESA_EEOT_OT0_(ptr noundef %7, ptr noundef nonnull align 1 dereferenceable(1) %8, ptr noundef nonnull align 1 dereferenceable(1) %9)
  ret ptr %7
}

declare void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6__initEPKcm(ptr noundef, ptr noundef, i64 noundef) #6

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNSt3__111char_traitsIcE6lengthB8ue170006EPKc(ptr noundef %0) #0 align 2 personality ptr @__gxx_personality_v0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = invoke i64 @_ZNSt3__118__constexpr_strlenB8ue170006EPKc(ptr noundef %3)
          to label %5 unwind label %6

5:                                                ; preds = %1
  ret i64 %4

6:                                                ; preds = %1
  %7 = landingpad { ptr, i32 }
          catch ptr null
  %8 = extractvalue { ptr, i32 } %7, 0
  call void @__clang_call_terminate(ptr %8) #14
  unreachable
}

; Function Attrs: noinline optnone ssp uwtable(sync)
define linkonce_odr ptr @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC2B8ue170006INS_18__default_init_tagESA_EEOT_OT0_(ptr noundef returned %0, ptr noundef nonnull align 1 dereferenceable(1) %1, ptr noundef nonnull align 1 dereferenceable(1) %2) unnamed_addr #5 align 2 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca %"struct.std::__1::__default_init_tag", align 1
  %8 = alloca %"struct.std::__1::__default_init_tag", align 1
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %9 = load ptr, ptr %4, align 8
  %10 = load ptr, ptr %5, align 8
  %11 = call ptr @_ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EEC2B8ue170006ENS_18__default_init_tagE(ptr noundef %9)
  %12 = load ptr, ptr %6, align 8
  %13 = call ptr @_ZNSt3__122__compressed_pair_elemINS_9allocatorIcEELi1ELb1EEC2B8ue170006ENS_18__default_init_tagE(ptr noundef %9)
  ret ptr %9
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EEC2B8ue170006ENS_18__default_init_tagE(ptr noundef returned %0) unnamed_addr #7 align 2 {
  %2 = alloca %"struct.std::__1::__default_init_tag", align 1
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  %5 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %4, i32 0, i32 0
  ret ptr %4
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__122__compressed_pair_elemINS_9allocatorIcEELi1ELb1EEC2B8ue170006ENS_18__default_init_tagE(ptr noundef returned %0) unnamed_addr #7 align 2 {
  %2 = alloca %"struct.std::__1::__default_init_tag", align 1
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  %5 = call ptr @_ZNSt3__19allocatorIcEC2B8ue170006Ev(ptr noundef %4) #13
  ret ptr %4
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__19allocatorIcEC2B8ue170006Ev(ptr noundef returned %0) unnamed_addr #7 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call ptr @_ZNSt3__116__non_trivial_ifILb1ENS_9allocatorIcEEEC2B8ue170006Ev(ptr noundef %3) #13
  ret ptr %3
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__116__non_trivial_ifILb1ENS_9allocatorIcEEEC2B8ue170006Ev(ptr noundef returned %0) unnamed_addr #7 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNSt3__118__constexpr_strlenB8ue170006EPKc(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call i64 @strlen(ptr noundef %3) #13
  ret i64 %4
}

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(ptr %0) #8 {
  %2 = call ptr @__cxa_begin_catch(ptr %0) #13
  call void @_ZSt9terminatev() #14
  unreachable
}

declare ptr @__cxa_begin_catch(ptr)

declare void @_ZSt9terminatev()

; Function Attrs: nounwind
declare i64 @strlen(ptr noundef) #4

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE15__make_iteratorB8ue170006EPc(ptr noundef %0, ptr noundef %1) #0 align 2 {
  %3 = alloca %"class.std::__1::__wrap_iter", align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = load ptr, ptr %5, align 8
  %8 = call ptr @_ZNSt3__111__wrap_iterIPcEC1B8ue170006ES1_(ptr noundef %3, ptr noundef %7) #13
  %9 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %3, i32 0, i32 0
  %10 = load ptr, ptr %9, align 8
  %11 = ptrtoint ptr %10 to i64
  ret i64 %11
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13__get_pointerB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call zeroext i1 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9__is_longB8ue170006Ev(ptr noundef %3) #13
  br i1 %4, label %5, label %7

5:                                                ; preds = %1
  %6 = call ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE18__get_long_pointerB8ue170006Ev(ptr noundef %3) #13
  br label %9

7:                                                ; preds = %1
  %8 = call ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE19__get_short_pointerB8ue170006Ev(ptr noundef %3) #13
  br label %9

9:                                                ; preds = %7, %5
  %10 = phi ptr [ %6, %5 ], [ %8, %7 ]
  ret ptr %10
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__111__wrap_iterIPcEC1B8ue170006ES1_(ptr noundef returned %0, ptr noundef %1) unnamed_addr #7 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = call ptr @_ZNSt3__111__wrap_iterIPcEC2B8ue170006ES1_(ptr noundef %5, ptr noundef %6) #13
  ret ptr %5
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__111__wrap_iterIPcEC2B8ue170006ES1_(ptr noundef returned %0, ptr noundef %1) unnamed_addr #7 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %5, i32 0, i32 0
  %7 = load ptr, ptr %4, align 8
  store ptr %7, ptr %6, align 8
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden zeroext i1 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9__is_longB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::basic_string", ptr %3, i32 0, i32 0
  %5 = call noundef nonnull align 8 dereferenceable(24) ptr @_ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ue170006Ev(ptr noundef %4) #13
  %6 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", ptr %5, i32 0, i32 0
  %7 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__short", ptr %6, i32 0, i32 2
  %8 = load i8, ptr %7, align 1
  %9 = lshr i8 %8, 7
  %10 = icmp ne i8 %9, 0
  ret i1 %10
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE18__get_long_pointerB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::basic_string", ptr %3, i32 0, i32 0
  %5 = call noundef nonnull align 8 dereferenceable(24) ptr @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ue170006Ev(ptr noundef %4) #13
  %6 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", ptr %5, i32 0, i32 0
  %7 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__long", ptr %6, i32 0, i32 0
  %8 = load ptr, ptr %7, align 8
  ret ptr %8
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE19__get_short_pointerB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::basic_string", ptr %3, i32 0, i32 0
  %5 = call noundef nonnull align 8 dereferenceable(24) ptr @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ue170006Ev(ptr noundef %4) #13
  %6 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", ptr %5, i32 0, i32 0
  %7 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__short", ptr %6, i32 0, i32 0
  %8 = getelementptr inbounds [23 x i8], ptr %7, i64 0, i64 0
  %9 = call ptr @_ZNSt3__114pointer_traitsIPcE10pointer_toB8ue170006ERc(ptr noundef nonnull align 1 dereferenceable(1) %8) #13
  ret ptr %9
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(24) ptr @_ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef nonnull align 8 dereferenceable(24) ptr @_ZNKSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getB8ue170006Ev(ptr noundef %3) #13
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(24) ptr @_ZNKSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %3, i32 0, i32 0
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(24) ptr @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef nonnull align 8 dereferenceable(24) ptr @_ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getB8ue170006Ev(ptr noundef %3) #13
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(24) ptr @_ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", ptr %3, i32 0, i32 0
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__114pointer_traitsIPcE10pointer_toB8ue170006ERc(ptr noundef nonnull align 1 dereferenceable(1) %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: argmemonly nocallback nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #9

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__111__wrap_iterIPcEpLB8ue170006El(ptr noundef %0, i64 noundef %1) #0 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  store ptr %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load i64, ptr %4, align 8
  %7 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %5, i32 0, i32 0
  %8 = load ptr, ptr %7, align 8
  %9 = getelementptr inbounds i8, ptr %8, i64 %6
  store ptr %9, ptr %7, align 8
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4sizeB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call zeroext i1 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9__is_longB8ue170006Ev(ptr noundef %3) #13
  br i1 %4, label %5, label %7

5:                                                ; preds = %1
  %6 = call i64 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE15__get_long_sizeB8ue170006Ev(ptr noundef %3) #13
  br label %9

7:                                                ; preds = %1
  %8 = call i64 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE16__get_short_sizeB8ue170006Ev(ptr noundef %3) #13
  br label %9

9:                                                ; preds = %7, %5
  %10 = phi i64 [ %6, %5 ], [ %8, %7 ]
  ret i64 %10
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE15__get_long_sizeB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::basic_string", ptr %3, i32 0, i32 0
  %5 = call noundef nonnull align 8 dereferenceable(24) ptr @_ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ue170006Ev(ptr noundef %4) #13
  %6 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", ptr %5, i32 0, i32 0
  %7 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__long", ptr %6, i32 0, i32 1
  %8 = load i64, ptr %7, align 8
  ret i64 %8
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE16__get_short_sizeB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::basic_string", ptr %3, i32 0, i32 0
  %5 = call noundef nonnull align 8 dereferenceable(24) ptr @_ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ue170006Ev(ptr noundef %4) #13
  %6 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", ptr %5, i32 0, i32 0
  %7 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__short", ptr %6, i32 0, i32 2
  %8 = load i8, ptr %7, align 1
  %9 = and i8 %8, 127
  %10 = zext i8 %9 to i64
  ret i64 %10
}

; Function Attrs: noinline optnone ssp uwtable(sync)
define linkonce_odr ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2B8ue170006INS_11__wrap_iterIPcEELi0EEET_SA_(ptr noundef returned %0, i64 %1, i64 %2) unnamed_addr #5 align 2 {
  %4 = alloca %"class.std::__1::__wrap_iter", align 8
  %5 = alloca %"class.std::__1::__wrap_iter", align 8
  %6 = alloca ptr, align 8
  %7 = alloca %"struct.std::__1::__default_init_tag", align 1
  %8 = alloca %"struct.std::__1::__default_init_tag", align 1
  %9 = alloca %"class.std::__1::__wrap_iter", align 8
  %10 = alloca %"class.std::__1::__wrap_iter", align 8
  %11 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %4, i32 0, i32 0
  %12 = inttoptr i64 %1 to ptr
  store ptr %12, ptr %11, align 8
  %13 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %5, i32 0, i32 0
  %14 = inttoptr i64 %2 to ptr
  store ptr %14, ptr %13, align 8
  store ptr %0, ptr %6, align 8
  %15 = load ptr, ptr %6, align 8
  %16 = getelementptr inbounds %"class.std::__1::basic_string", ptr %15, i32 0, i32 0
  %17 = call ptr @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC1B8ue170006INS_18__default_init_tagESA_EEOT_OT0_(ptr noundef %16, ptr noundef nonnull align 1 dereferenceable(1) %7, ptr noundef nonnull align 1 dereferenceable(1) %8)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %9, ptr align 8 %4, i64 8, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %10, ptr align 8 %5, i64 8, i1 false)
  %18 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %9, i32 0, i32 0
  %19 = load ptr, ptr %18, align 8
  %20 = ptrtoint ptr %19 to i64
  %21 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %10, i32 0, i32 0
  %22 = load ptr, ptr %21, align 8
  %23 = ptrtoint ptr %22 to i64
  call void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6__initINS_11__wrap_iterIPcEELi0EEEvT_SA_(ptr noundef %15, i64 %20, i64 %23)
  ret ptr %15
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6__initINS_11__wrap_iterIPcEELi0EEEvT_SA_(ptr noundef %0, i64 %1, i64 %2) #2 align 2 {
  %4 = alloca %"class.std::__1::__wrap_iter", align 8
  %5 = alloca %"class.std::__1::__wrap_iter", align 8
  %6 = alloca ptr, align 8
  %7 = alloca i64, align 8
  %8 = alloca %"class.std::__1::__wrap_iter", align 8
  %9 = alloca %"class.std::__1::__wrap_iter", align 8
  %10 = alloca %"class.std::__1::__wrap_iter", align 8
  %11 = alloca %"class.std::__1::__wrap_iter", align 8
  %12 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %4, i32 0, i32 0
  %13 = inttoptr i64 %1 to ptr
  store ptr %13, ptr %12, align 8
  %14 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %5, i32 0, i32 0
  %15 = inttoptr i64 %2 to ptr
  store ptr %15, ptr %14, align 8
  store ptr %0, ptr %6, align 8
  %16 = load ptr, ptr %6, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %8, ptr align 8 %4, i64 8, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %9, ptr align 8 %5, i64 8, i1 false)
  %17 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %8, i32 0, i32 0
  %18 = load ptr, ptr %17, align 8
  %19 = ptrtoint ptr %18 to i64
  %20 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %9, i32 0, i32 0
  %21 = load ptr, ptr %20, align 8
  %22 = ptrtoint ptr %21 to i64
  %23 = call i64 @_ZNSt3__18distanceB8ue170006INS_11__wrap_iterIPcEEEENS_15iterator_traitsIT_E15difference_typeES5_S5_(i64 %19, i64 %22)
  store i64 %23, ptr %7, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %10, ptr align 8 %4, i64 8, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %11, ptr align 8 %5, i64 8, i1 false)
  %24 = load i64, ptr %7, align 8
  %25 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %10, i32 0, i32 0
  %26 = load ptr, ptr %25, align 8
  %27 = ptrtoint ptr %26 to i64
  %28 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %11, i32 0, i32 0
  %29 = load ptr, ptr %28, align 8
  %30 = ptrtoint ptr %29 to i64
  call void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE16__init_with_sizeB8ue170006INS_11__wrap_iterIPcEES9_EEvT_T0_m(ptr noundef %16, i64 %27, i64 %30, i64 noundef %24)
  ret void
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNSt3__18distanceB8ue170006INS_11__wrap_iterIPcEEEENS_15iterator_traitsIT_E15difference_typeES5_S5_(i64 %0, i64 %1) #2 {
  %3 = alloca %"class.std::__1::__wrap_iter", align 8
  %4 = alloca %"class.std::__1::__wrap_iter", align 8
  %5 = alloca %"class.std::__1::__wrap_iter", align 8
  %6 = alloca %"class.std::__1::__wrap_iter", align 8
  %7 = alloca %"struct.std::__1::random_access_iterator_tag", align 1
  %8 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %3, i32 0, i32 0
  %9 = inttoptr i64 %0 to ptr
  store ptr %9, ptr %8, align 8
  %10 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %4, i32 0, i32 0
  %11 = inttoptr i64 %1 to ptr
  store ptr %11, ptr %10, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %5, ptr align 8 %3, i64 8, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %6, ptr align 8 %4, i64 8, i1 false)
  %12 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %5, i32 0, i32 0
  %13 = load ptr, ptr %12, align 8
  %14 = ptrtoint ptr %13 to i64
  %15 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %6, i32 0, i32 0
  %16 = load ptr, ptr %15, align 8
  %17 = ptrtoint ptr %16 to i64
  %18 = call i64 @_ZNSt3__110__distanceB8ue170006INS_11__wrap_iterIPcEEEENS_15iterator_traitsIT_E15difference_typeES5_S5_NS_26random_access_iterator_tagE(i64 %14, i64 %17)
  ret i64 %18
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE16__init_with_sizeB8ue170006INS_11__wrap_iterIPcEES9_EEvT_T0_m(ptr noundef %0, i64 %1, i64 %2, i64 noundef %3) #2 align 2 {
  %5 = alloca %"class.std::__1::__wrap_iter", align 8
  %6 = alloca %"class.std::__1::__wrap_iter", align 8
  %7 = alloca ptr, align 8
  %8 = alloca i64, align 8
  %9 = alloca ptr, align 8
  %10 = alloca %"struct.std::__1::__allocation_result", align 8
  %11 = alloca i8, align 1
  %12 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %5, i32 0, i32 0
  %13 = inttoptr i64 %1 to ptr
  store ptr %13, ptr %12, align 8
  %14 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %6, i32 0, i32 0
  %15 = inttoptr i64 %2 to ptr
  store ptr %15, ptr %14, align 8
  store ptr %0, ptr %7, align 8
  store i64 %3, ptr %8, align 8
  %16 = load ptr, ptr %7, align 8
  %17 = load i64, ptr %8, align 8
  %18 = call i64 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE8max_sizeB8ue170006Ev(ptr noundef %16) #13
  %19 = icmp ugt i64 %17, %18
  br i1 %19, label %20, label %21

20:                                               ; preds = %4
  call void @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ue170006Ev(ptr noundef %16) #15
  unreachable

21:                                               ; preds = %4
  %22 = load i64, ptr %8, align 8
  %23 = call zeroext i1 @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13__fits_in_ssoB8ue170006Em(i64 noundef %22)
  br i1 %23, label %24, label %27

24:                                               ; preds = %21
  %25 = load i64, ptr %8, align 8
  call void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE16__set_short_sizeB8ue170006Em(ptr noundef %16, i64 noundef %25) #13
  %26 = call ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE19__get_short_pointerB8ue170006Ev(ptr noundef %16) #13
  store ptr %26, ptr %9, align 8
  br label %42

27:                                               ; preds = %21
  %28 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7__allocB8ue170006Ev(ptr noundef %16) #13
  %29 = load i64, ptr %8, align 8
  %30 = call i64 @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE11__recommendB8ue170006Em(i64 noundef %29) #13
  %31 = add i64 %30, 1
  %32 = call [2 x i64] @_ZNSt3__119__allocate_at_leastB8ue170006INS_9allocatorIcEEEENS_19__allocation_resultINS_16allocator_traitsIT_E7pointerEEERS5_m(ptr noundef nonnull align 1 dereferenceable(1) %28, i64 noundef %31)
  store [2 x i64] %32, ptr %10, align 8
  %33 = getelementptr inbounds %"struct.std::__1::__allocation_result", ptr %10, i32 0, i32 0
  %34 = load ptr, ptr %33, align 8
  store ptr %34, ptr %9, align 8
  %35 = load ptr, ptr %9, align 8
  %36 = getelementptr inbounds %"struct.std::__1::__allocation_result", ptr %10, i32 0, i32 1
  %37 = load i64, ptr %36, align 8
  call void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE16__begin_lifetimeB8ue170006EPcm(ptr noundef %35, i64 noundef %37)
  %38 = load ptr, ptr %9, align 8
  call void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE18__set_long_pointerB8ue170006EPc(ptr noundef %16, ptr noundef %38) #13
  %39 = getelementptr inbounds %"struct.std::__1::__allocation_result", ptr %10, i32 0, i32 1
  %40 = load i64, ptr %39, align 8
  call void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE14__set_long_capB8ue170006Em(ptr noundef %16, i64 noundef %40) #13
  %41 = load i64, ptr %8, align 8
  call void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE15__set_long_sizeB8ue170006Em(ptr noundef %16, i64 noundef %41) #13
  br label %42

42:                                               ; preds = %27, %24
  br label %43

43:                                               ; preds = %48, %42
  %44 = call zeroext i1 @_ZNSt3__1neB8ue170006IPcEEbRKNS_11__wrap_iterIT_EES6_(ptr noundef nonnull align 8 dereferenceable(8) %5, ptr noundef nonnull align 8 dereferenceable(8) %6) #13
  br i1 %44, label %45, label %52

45:                                               ; preds = %43
  %46 = load ptr, ptr %9, align 8
  %47 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNKSt3__111__wrap_iterIPcEdeB8ue170006Ev(ptr noundef %5) #13
  call void @_ZNSt3__111char_traitsIcE6assignB8ue170006ERcRKc(ptr noundef nonnull align 1 dereferenceable(1) %46, ptr noundef nonnull align 1 dereferenceable(1) %47) #13
  br label %48

48:                                               ; preds = %45
  %49 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__111__wrap_iterIPcEppB8ue170006Ev(ptr noundef %5) #13
  %50 = load ptr, ptr %9, align 8
  %51 = getelementptr inbounds i8, ptr %50, i32 1
  store ptr %51, ptr %9, align 8
  br label %43, !llvm.loop !6

52:                                               ; preds = %43
  %53 = load ptr, ptr %9, align 8
  store i8 0, ptr %11, align 1
  call void @_ZNSt3__111char_traitsIcE6assignB8ue170006ERcRKc(ptr noundef nonnull align 1 dereferenceable(1) %53, ptr noundef nonnull align 1 dereferenceable(1) %11) #13
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNSt3__110__distanceB8ue170006INS_11__wrap_iterIPcEEEENS_15iterator_traitsIT_E15difference_typeES5_S5_NS_26random_access_iterator_tagE(i64 %0, i64 %1) #0 {
  %3 = alloca %"class.std::__1::__wrap_iter", align 8
  %4 = alloca %"class.std::__1::__wrap_iter", align 8
  %5 = alloca %"struct.std::__1::random_access_iterator_tag", align 1
  %6 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %3, i32 0, i32 0
  %7 = inttoptr i64 %0 to ptr
  store ptr %7, ptr %6, align 8
  %8 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %4, i32 0, i32 0
  %9 = inttoptr i64 %1 to ptr
  store ptr %9, ptr %8, align 8
  %10 = call i64 @_ZNSt3__1miB8ue170006IPcS1_EEDTmicldtfp_4baseEcldtfp0_4baseEERKNS_11__wrap_iterIT_EERKNS3_IT0_EE(ptr noundef nonnull align 8 dereferenceable(8) %4, ptr noundef nonnull align 8 dereferenceable(8) %3) #13
  ret i64 %10
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNSt3__1miB8ue170006IPcS1_EEDTmicldtfp_4baseEcldtfp0_4baseEERKNS_11__wrap_iterIT_EERKNS3_IT0_EE(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef nonnull align 8 dereferenceable(8) %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = call ptr @_ZNKSt3__111__wrap_iterIPcE4baseB8ue170006Ev(ptr noundef %5) #13
  %7 = load ptr, ptr %4, align 8
  %8 = call ptr @_ZNKSt3__111__wrap_iterIPcE4baseB8ue170006Ev(ptr noundef %7) #13
  %9 = ptrtoint ptr %6 to i64
  %10 = ptrtoint ptr %8 to i64
  %11 = sub i64 %9, %10
  ret i64 %11
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNKSt3__111__wrap_iterIPcE4baseB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %3, i32 0, i32 0
  %5 = load ptr, ptr %4, align 8
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE8max_sizeB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca i64, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  %5 = alloca i8, align 1
  store ptr %0, ptr %3, align 8
  %6 = load ptr, ptr %3, align 8
  %7 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7__allocB8ue170006Ev(ptr noundef %6) #13
  %8 = call i64 @_ZNSt3__116allocator_traitsINS_9allocatorIcEEE8max_sizeB8ue170006IS2_vvEEmRKS2_(ptr noundef nonnull align 1 dereferenceable(1) %7) #13
  store i64 %8, ptr %4, align 8
  %9 = load i64, ptr %4, align 8
  %10 = call i64 @_ZNSt3__114numeric_limitsImE3maxB8ue170006Ev() #13
  %11 = udiv i64 %10, 2
  %12 = icmp ule i64 %9, %11
  br i1 %12, label %13, label %16

13:                                               ; preds = %1
  %14 = load i64, ptr %4, align 8
  %15 = sub i64 %14, 16
  store i64 %15, ptr %2, align 8
  br label %28

16:                                               ; preds = %1
  store i8 0, ptr %5, align 1
  %17 = load i8, ptr %5, align 1
  %18 = trunc i8 %17 to i1
  br i1 %18, label %19, label %22

19:                                               ; preds = %16
  %20 = load i64, ptr %4, align 8
  %21 = sub i64 %20, 16
  br label %26

22:                                               ; preds = %16
  %23 = load i64, ptr %4, align 8
  %24 = udiv i64 %23, 2
  %25 = sub i64 %24, 16
  br label %26

26:                                               ; preds = %22, %19
  %27 = phi i64 [ %21, %19 ], [ %25, %22 ]
  store i64 %27, ptr %2, align 8
  br label %28

28:                                               ; preds = %26, %13
  %29 = load i64, ptr %2, align 8
  ret i64 %29
}

; Function Attrs: mustprogress noinline noreturn optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ue170006Ev(ptr noundef %0) #10 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  call void @_ZNSt3__120__throw_length_errorB8ue170006EPKc(ptr noundef @.str) #15
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden zeroext i1 @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13__fits_in_ssoB8ue170006Em(i64 noundef %0) #0 align 2 {
  %2 = alloca i64, align 8
  store i64 %0, ptr %2, align 8
  %3 = load i64, ptr %2, align 8
  %4 = icmp ult i64 %3, 23
  ret i1 %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE16__set_short_sizeB8ue170006Em(ptr noundef %0, i64 noundef %1) #0 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  store ptr %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load i64, ptr %4, align 8
  %7 = trunc i64 %6 to i8
  %8 = getelementptr inbounds %"class.std::__1::basic_string", ptr %5, i32 0, i32 0
  %9 = call noundef nonnull align 8 dereferenceable(24) ptr @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ue170006Ev(ptr noundef %8) #13
  %10 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", ptr %9, i32 0, i32 0
  %11 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__short", ptr %10, i32 0, i32 2
  %12 = load i8, ptr %11, align 1
  %13 = and i8 %7, 127
  %14 = and i8 %12, -128
  %15 = or i8 %14, %13
  store i8 %15, ptr %11, align 1
  %16 = getelementptr inbounds %"class.std::__1::basic_string", ptr %5, i32 0, i32 0
  %17 = call noundef nonnull align 8 dereferenceable(24) ptr @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ue170006Ev(ptr noundef %16) #13
  %18 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", ptr %17, i32 0, i32 0
  %19 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__short", ptr %18, i32 0, i32 2
  %20 = load i8, ptr %19, align 1
  %21 = and i8 %20, 127
  %22 = or i8 %21, 0
  store i8 %22, ptr %19, align 1
  ret void
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden [2 x i64] @_ZNSt3__119__allocate_at_leastB8ue170006INS_9allocatorIcEEEENS_19__allocation_resultINS_16allocator_traitsIT_E7pointerEEERS5_m(ptr noundef nonnull align 1 dereferenceable(1) %0, i64 noundef %1) #2 {
  %3 = alloca %"struct.std::__1::__allocation_result", align 8
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  %6 = getelementptr inbounds %"struct.std::__1::__allocation_result", ptr %3, i32 0, i32 0
  %7 = load ptr, ptr %4, align 8
  %8 = load i64, ptr %5, align 8
  %9 = call ptr @_ZNSt3__19allocatorIcE8allocateB8ue170006Em(ptr noundef %7, i64 noundef %8)
  store ptr %9, ptr %6, align 8
  %10 = getelementptr inbounds %"struct.std::__1::__allocation_result", ptr %3, i32 0, i32 1
  %11 = load i64, ptr %5, align 8
  store i64 %11, ptr %10, align 8
  %12 = load [2 x i64], ptr %3, align 8
  ret [2 x i64] %12
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7__allocB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::basic_string", ptr %3, i32 0, i32 0
  %5 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E6secondB8ue170006Ev(ptr noundef %4) #13
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE11__recommendB8ue170006Em(i64 noundef %0) #0 align 2 {
  %2 = alloca i64, align 8
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, ptr %3, align 8
  %5 = load i64, ptr %3, align 8
  %6 = icmp ult i64 %5, 23
  br i1 %6, label %7, label %8

7:                                                ; preds = %1
  store i64 22, ptr %2, align 8
  br label %20

8:                                                ; preds = %1
  %9 = load i64, ptr %3, align 8
  %10 = add i64 %9, 1
  %11 = call i64 @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE10__align_itB8ue170006ILm16EEEmm(i64 noundef %10) #13
  %12 = sub i64 %11, 1
  store i64 %12, ptr %4, align 8
  %13 = load i64, ptr %4, align 8
  %14 = icmp eq i64 %13, 23
  br i1 %14, label %15, label %18

15:                                               ; preds = %8
  %16 = load i64, ptr %4, align 8
  %17 = add i64 %16, 1
  store i64 %17, ptr %4, align 8
  br label %18

18:                                               ; preds = %15, %8
  %19 = load i64, ptr %4, align 8
  store i64 %19, ptr %2, align 8
  br label %20

20:                                               ; preds = %18, %7
  %21 = load i64, ptr %2, align 8
  ret i64 %21
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE16__begin_lifetimeB8ue170006EPcm(ptr noundef %0, i64 noundef %1) #0 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  store ptr %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE18__set_long_pointerB8ue170006EPc(ptr noundef %0, ptr noundef %1) #0 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = getelementptr inbounds %"class.std::__1::basic_string", ptr %5, i32 0, i32 0
  %8 = call noundef nonnull align 8 dereferenceable(24) ptr @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ue170006Ev(ptr noundef %7) #13
  %9 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", ptr %8, i32 0, i32 0
  %10 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__long", ptr %9, i32 0, i32 0
  store ptr %6, ptr %10, align 8
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE14__set_long_capB8ue170006Em(ptr noundef %0, i64 noundef %1) #0 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  store ptr %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load i64, ptr %4, align 8
  %7 = udiv i64 %6, 1
  %8 = getelementptr inbounds %"class.std::__1::basic_string", ptr %5, i32 0, i32 0
  %9 = call noundef nonnull align 8 dereferenceable(24) ptr @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ue170006Ev(ptr noundef %8) #13
  %10 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", ptr %9, i32 0, i32 0
  %11 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__long", ptr %10, i32 0, i32 2
  %12 = load i64, ptr %11, align 8
  %13 = and i64 %7, 9223372036854775807
  %14 = and i64 %12, -9223372036854775808
  %15 = or i64 %14, %13
  store i64 %15, ptr %11, align 8
  %16 = getelementptr inbounds %"class.std::__1::basic_string", ptr %5, i32 0, i32 0
  %17 = call noundef nonnull align 8 dereferenceable(24) ptr @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ue170006Ev(ptr noundef %16) #13
  %18 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", ptr %17, i32 0, i32 0
  %19 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__long", ptr %18, i32 0, i32 2
  %20 = load i64, ptr %19, align 8
  %21 = and i64 %20, 9223372036854775807
  %22 = or i64 %21, -9223372036854775808
  store i64 %22, ptr %19, align 8
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE15__set_long_sizeB8ue170006Em(ptr noundef %0, i64 noundef %1) #0 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  store ptr %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load i64, ptr %4, align 8
  %7 = getelementptr inbounds %"class.std::__1::basic_string", ptr %5, i32 0, i32 0
  %8 = call noundef nonnull align 8 dereferenceable(24) ptr @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ue170006Ev(ptr noundef %7) #13
  %9 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", ptr %8, i32 0, i32 0
  %10 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__long", ptr %9, i32 0, i32 1
  store i64 %6, ptr %10, align 8
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden zeroext i1 @_ZNSt3__1neB8ue170006IPcEEbRKNS_11__wrap_iterIT_EES6_(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef nonnull align 8 dereferenceable(8) %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = call zeroext i1 @_ZNSt3__1eqB8ue170006IPcEEbRKNS_11__wrap_iterIT_EES6_(ptr noundef nonnull align 8 dereferenceable(8) %5, ptr noundef nonnull align 8 dereferenceable(8) %6) #13
  %8 = xor i1 %7, true
  ret i1 %8
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__111char_traitsIcE6assignB8ue170006ERcRKc(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef nonnull align 1 dereferenceable(1) %1) #0 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %4, align 8
  %6 = load i8, ptr %5, align 1
  %7 = load ptr, ptr %3, align 8
  store i8 %6, ptr %7, align 1
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) ptr @_ZNKSt3__111__wrap_iterIPcEdeB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %3, i32 0, i32 0
  %5 = load ptr, ptr %4, align 8
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__111__wrap_iterIPcEppB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::__wrap_iter", ptr %3, i32 0, i32 0
  %5 = load ptr, ptr %4, align 8
  %6 = getelementptr inbounds i8, ptr %5, i32 1
  store ptr %6, ptr %4, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr i64 @_ZNSt3__116allocator_traitsINS_9allocatorIcEEE8max_sizeB8ue170006IS2_vvEEmRKS2_(ptr noundef nonnull align 1 dereferenceable(1) %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = call i64 @_ZNSt3__114numeric_limitsImE3maxB8ue170006Ev() #13
  %4 = udiv i64 %3, 1
  ret i64 %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) ptr @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7__allocB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::basic_string", ptr %3, i32 0, i32 0
  %5 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E6secondB8ue170006Ev(ptr noundef %4) #13
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNSt3__114numeric_limitsImE3maxB8ue170006Ev() #0 align 2 {
  %1 = call i64 @_ZNSt3__123__libcpp_numeric_limitsImLb1EE3maxB8ue170006Ev() #13
  ret i64 %1
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) ptr @_ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E6secondB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNKSt3__122__compressed_pair_elemINS_9allocatorIcEELi1ELb1EE5__getB8ue170006Ev(ptr noundef %3) #13
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) ptr @_ZNKSt3__122__compressed_pair_elemINS_9allocatorIcEELi1ELb1EE5__getB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNSt3__123__libcpp_numeric_limitsImLb1EE3maxB8ue170006Ev() #0 align 2 {
  ret i64 -1
}

; Function Attrs: mustprogress noinline noreturn optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__120__throw_length_errorB8ue170006EPKc(ptr noundef %0) #10 personality ptr @__gxx_personality_v0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %5 = call ptr @__cxa_allocate_exception(i64 16) #13
  %6 = load ptr, ptr %2, align 8
  %7 = invoke ptr @_ZNSt12length_errorC1B8ue170006EPKc(ptr noundef %5, ptr noundef %6)
          to label %8 unwind label %9

8:                                                ; preds = %1
  call void @__cxa_throw(ptr %5, ptr @_ZTISt12length_error, ptr @_ZNSt12length_errorD1Ev) #15
  unreachable

9:                                                ; preds = %1
  %10 = landingpad { ptr, i32 }
          cleanup
  %11 = extractvalue { ptr, i32 } %10, 0
  store ptr %11, ptr %3, align 8
  %12 = extractvalue { ptr, i32 } %10, 1
  store i32 %12, ptr %4, align 4
  call void @__cxa_free_exception(ptr %5) #13
  br label %13

13:                                               ; preds = %9
  %14 = load ptr, ptr %3, align 8
  %15 = load i32, ptr %4, align 4
  %16 = insertvalue { ptr, i32 } undef, ptr %14, 0
  %17 = insertvalue { ptr, i32 } %16, i32 %15, 1
  resume { ptr, i32 } %17
}

declare ptr @__cxa_allocate_exception(i64)

; Function Attrs: noinline optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt12length_errorC1B8ue170006EPKc(ptr noundef returned %0, ptr noundef %1) unnamed_addr #5 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = call ptr @_ZNSt12length_errorC2B8ue170006EPKc(ptr noundef %5, ptr noundef %6)
  ret ptr %5
}

declare void @__cxa_free_exception(ptr)

; Function Attrs: nounwind
declare ptr @_ZNSt12length_errorD1Ev(ptr noundef returned) unnamed_addr #4

declare void @__cxa_throw(ptr, ptr, ptr)

; Function Attrs: noinline optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt12length_errorC2B8ue170006EPKc(ptr noundef returned %0, ptr noundef %1) unnamed_addr #5 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = call ptr @_ZNSt11logic_errorC2EPKc(ptr noundef %5, ptr noundef %6)
  store ptr getelementptr inbounds ({ [5 x ptr] }, ptr @_ZTVSt12length_error, i32 0, inrange i32 0, i32 2), ptr %5, align 8
  ret ptr %5
}

declare ptr @_ZNSt11logic_errorC2EPKc(ptr noundef returned, ptr noundef) unnamed_addr #6

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__19allocatorIcE8allocateB8ue170006Em(ptr noundef %0, i64 noundef %1) #2 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  store ptr %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load i64, ptr %4, align 8
  %7 = call i64 @_ZNSt3__116allocator_traitsINS_9allocatorIcEEE8max_sizeB8ue170006IS2_vvEEmRKS2_(ptr noundef nonnull align 1 dereferenceable(1) %5) #13
  %8 = icmp ugt i64 %6, %7
  br i1 %8, label %9, label %10

9:                                                ; preds = %2
  call void @_ZSt28__throw_bad_array_new_lengthB8ue170006v() #15
  unreachable

10:                                               ; preds = %2
  %11 = load i64, ptr %4, align 8
  %12 = mul i64 %11, 1
  %13 = call ptr @_ZNSt3__117__libcpp_allocateB8ue170006Emm(i64 noundef %12, i64 noundef 1)
  ret ptr %13
}

; Function Attrs: mustprogress noinline noreturn optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZSt28__throw_bad_array_new_lengthB8ue170006v() #10 {
  %1 = call ptr @__cxa_allocate_exception(i64 8) #13
  %2 = call ptr @_ZNSt20bad_array_new_lengthC1Ev(ptr noundef %1) #13
  call void @__cxa_throw(ptr %1, ptr @_ZTISt20bad_array_new_length, ptr @_ZNSt20bad_array_new_lengthD1Ev) #15
  unreachable
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__117__libcpp_allocateB8ue170006Emm(i64 noundef %0, i64 noundef %1) #2 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  store i64 %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  %7 = load i64, ptr %5, align 8
  %8 = call zeroext i1 @_ZNSt3__124__is_overaligned_for_newB8ue170006Em(i64 noundef %7) #13
  br i1 %8, label %9, label %14

9:                                                ; preds = %2
  %10 = load i64, ptr %5, align 8
  store i64 %10, ptr %6, align 8
  %11 = load i64, ptr %4, align 8
  %12 = load i64, ptr %6, align 8
  %13 = call ptr @_ZNSt3__121__libcpp_operator_newB8ue170006IJmSt11align_val_tEEEPvDpT_(i64 noundef %11, i64 noundef %12)
  store ptr %13, ptr %3, align 8
  br label %17

14:                                               ; preds = %2
  %15 = load i64, ptr %4, align 8
  %16 = call ptr @_ZNSt3__121__libcpp_operator_newB8ue170006IJmEEEPvDpT_(i64 noundef %15)
  store ptr %16, ptr %3, align 8
  br label %17

17:                                               ; preds = %14, %9
  %18 = load ptr, ptr %3, align 8
  ret ptr %18
}

; Function Attrs: nounwind
declare ptr @_ZNSt20bad_array_new_lengthC1Ev(ptr noundef returned) unnamed_addr #4

; Function Attrs: nounwind
declare ptr @_ZNSt20bad_array_new_lengthD1Ev(ptr noundef returned) unnamed_addr #4

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden zeroext i1 @_ZNSt3__124__is_overaligned_for_newB8ue170006Em(i64 noundef %0) #0 {
  %2 = alloca i64, align 8
  store i64 %0, ptr %2, align 8
  %3 = load i64, ptr %2, align 8
  %4 = icmp ugt i64 %3, 16
  ret i1 %4
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__121__libcpp_operator_newB8ue170006IJmSt11align_val_tEEEPvDpT_(i64 noundef %0, i64 noundef %1) #2 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  %5 = load i64, ptr %3, align 8
  %6 = load i64, ptr %4, align 8
  %7 = call noalias nonnull ptr @_ZnwmSt11align_val_t(i64 noundef %5, i64 noundef %6) #16
  call void @llvm.assume(i1 true) [ "align"(ptr %7, i64 %6) ]
  ret ptr %7
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__121__libcpp_operator_newB8ue170006IJmEEEPvDpT_(i64 noundef %0) #2 {
  %2 = alloca i64, align 8
  store i64 %0, ptr %2, align 8
  %3 = load i64, ptr %2, align 8
  %4 = call noalias nonnull ptr @_Znwm(i64 noundef %3) #16
  ret ptr %4
}

; Function Attrs: nobuiltin allocsize(0)
declare nonnull ptr @_ZnwmSt11align_val_t(i64 noundef, i64 noundef) #11

; Function Attrs: inaccessiblememonly nocallback nofree nosync nounwind willreturn
declare void @llvm.assume(i1 noundef) #12

; Function Attrs: nobuiltin allocsize(0)
declare nonnull ptr @_Znwm(i64 noundef) #11

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E6secondB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__122__compressed_pair_elemINS_9allocatorIcEELi1ELb1EE5__getB8ue170006Ev(ptr noundef %3) #13
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) ptr @_ZNSt3__122__compressed_pair_elemINS_9allocatorIcEELi1ELb1EE5__getB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr i64 @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE10__align_itB8ue170006ILm16EEEmm(i64 noundef %0) #0 align 2 {
  %2 = alloca i64, align 8
  store i64 %0, ptr %2, align 8
  %3 = load i64, ptr %2, align 8
  %4 = add i64 %3, 15
  %5 = and i64 %4, -16
  ret i64 %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden zeroext i1 @_ZNSt3__1eqB8ue170006IPcEEbRKNS_11__wrap_iterIT_EES6_(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef nonnull align 8 dereferenceable(8) %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = call ptr @_ZNKSt3__111__wrap_iterIPcE4baseB8ue170006Ev(ptr noundef %5) #13
  %7 = load ptr, ptr %4, align 8
  %8 = call ptr @_ZNKSt3__111__wrap_iterIPcE4baseB8ue170006Ev(ptr noundef %7) #13
  %9 = icmp eq ptr %6, %8
  ret i1 %9
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__124__put_character_sequenceB8ue170006IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef %1, i64 noundef %2) #2 personality ptr @__gxx_personality_v0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  %7 = alloca %"class.std::__1::basic_ostream<char>::sentry", align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca %"class.std::__1::ostreambuf_iterator", align 8
  %11 = alloca %"class.std::__1::ostreambuf_iterator", align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i64 %2, ptr %6, align 8
  %12 = load ptr, ptr %4, align 8
  %13 = invoke ptr @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryC1ERS3_(ptr noundef %7, ptr noundef nonnull align 8 dereferenceable(8) %12)
          to label %14 unwind label %68

14:                                               ; preds = %3
  %15 = invoke zeroext i1 @_ZNKSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentrycvbB8ue170006Ev(ptr noundef %7)
          to label %16 unwind label %72

16:                                               ; preds = %14
  br i1 %15, label %17, label %89

17:                                               ; preds = %16
  %18 = load ptr, ptr %4, align 8
  %19 = call ptr @_ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC1B8ue170006ERNS_13basic_ostreamIcS2_EE(ptr noundef %11, ptr noundef nonnull align 8 dereferenceable(8) %18) #13
  %20 = load ptr, ptr %5, align 8
  %21 = load ptr, ptr %4, align 8
  %22 = load ptr, ptr %21, align 8
  %23 = getelementptr i8, ptr %22, i64 -24
  %24 = load i64, ptr %23, align 8
  %25 = getelementptr inbounds i8, ptr %21, i64 %24
  %26 = invoke i32 @_ZNKSt3__18ios_base5flagsB8ue170006Ev(ptr noundef %25)
          to label %27 unwind label %72

27:                                               ; preds = %17
  %28 = and i32 %26, 176
  %29 = icmp eq i32 %28, 32
  br i1 %29, label %30, label %34

30:                                               ; preds = %27
  %31 = load ptr, ptr %5, align 8
  %32 = load i64, ptr %6, align 8
  %33 = getelementptr inbounds i8, ptr %31, i64 %32
  br label %36

34:                                               ; preds = %27
  %35 = load ptr, ptr %5, align 8
  br label %36

36:                                               ; preds = %34, %30
  %37 = phi ptr [ %33, %30 ], [ %35, %34 ]
  %38 = load ptr, ptr %5, align 8
  %39 = load i64, ptr %6, align 8
  %40 = getelementptr inbounds i8, ptr %38, i64 %39
  %41 = load ptr, ptr %4, align 8
  %42 = load ptr, ptr %41, align 8
  %43 = getelementptr i8, ptr %42, i64 -24
  %44 = load i64, ptr %43, align 8
  %45 = getelementptr inbounds i8, ptr %41, i64 %44
  %46 = load ptr, ptr %4, align 8
  %47 = load ptr, ptr %46, align 8
  %48 = getelementptr i8, ptr %47, i64 -24
  %49 = load i64, ptr %48, align 8
  %50 = getelementptr inbounds i8, ptr %46, i64 %49
  %51 = invoke signext i8 @_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE4fillB8ue170006Ev(ptr noundef %50)
          to label %52 unwind label %72

52:                                               ; preds = %36
  %53 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", ptr %11, i32 0, i32 0
  %54 = load ptr, ptr %53, align 8
  %55 = ptrtoint ptr %54 to i64
  %56 = invoke i64 @_ZNSt3__116__pad_and_outputB8ue170006IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_(i64 %55, ptr noundef %20, ptr noundef %37, ptr noundef %40, ptr noundef nonnull align 8 dereferenceable(136) %45, i8 noundef signext %51)
          to label %57 unwind label %72

57:                                               ; preds = %52
  %58 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", ptr %10, i32 0, i32 0
  %59 = inttoptr i64 %56 to ptr
  store ptr %59, ptr %58, align 8
  %60 = call zeroext i1 @_ZNKSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEE6failedB8ue170006Ev(ptr noundef %10) #13
  br i1 %60, label %61, label %88

61:                                               ; preds = %57
  %62 = load ptr, ptr %4, align 8
  %63 = load ptr, ptr %62, align 8
  %64 = getelementptr i8, ptr %63, i64 -24
  %65 = load i64, ptr %64, align 8
  %66 = getelementptr inbounds i8, ptr %62, i64 %65
  invoke void @_ZNSt3__19basic_iosIcNS_11char_traitsIcEEE8setstateB8ue170006Ej(ptr noundef %66, i32 noundef 5)
          to label %67 unwind label %72

67:                                               ; preds = %61
  br label %88

68:                                               ; preds = %3
  %69 = landingpad { ptr, i32 }
          catch ptr null
  %70 = extractvalue { ptr, i32 } %69, 0
  store ptr %70, ptr %8, align 8
  %71 = extractvalue { ptr, i32 } %69, 1
  store i32 %71, ptr %9, align 4
  br label %77

72:                                               ; preds = %61, %52, %36, %17, %14
  %73 = landingpad { ptr, i32 }
          catch ptr null
  %74 = extractvalue { ptr, i32 } %73, 0
  store ptr %74, ptr %8, align 8
  %75 = extractvalue { ptr, i32 } %73, 1
  store i32 %75, ptr %9, align 4
  %76 = call ptr @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev(ptr noundef %7) #13
  br label %77

77:                                               ; preds = %72, %68
  %78 = load ptr, ptr %8, align 8
  %79 = call ptr @__cxa_begin_catch(ptr %78) #13
  %80 = load ptr, ptr %4, align 8
  %81 = load ptr, ptr %80, align 8
  %82 = getelementptr i8, ptr %81, i64 -24
  %83 = load i64, ptr %82, align 8
  %84 = getelementptr inbounds i8, ptr %80, i64 %83
  invoke void @_ZNSt3__18ios_base33__set_badbit_and_consider_rethrowEv(ptr noundef %84)
          to label %85 unwind label %91

85:                                               ; preds = %77
  call void @__cxa_end_catch()
  br label %86

86:                                               ; preds = %85, %89
  %87 = load ptr, ptr %4, align 8
  ret ptr %87

88:                                               ; preds = %67, %57
  br label %89

89:                                               ; preds = %88, %16
  %90 = call ptr @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev(ptr noundef %7) #13
  br label %86

91:                                               ; preds = %77
  %92 = landingpad { ptr, i32 }
          cleanup
  %93 = extractvalue { ptr, i32 } %92, 0
  store ptr %93, ptr %8, align 8
  %94 = extractvalue { ptr, i32 } %92, 1
  store i32 %94, ptr %9, align 4
  invoke void @__cxa_end_catch()
          to label %95 unwind label %101

95:                                               ; preds = %91
  br label %96

96:                                               ; preds = %95
  %97 = load ptr, ptr %8, align 8
  %98 = load i32, ptr %9, align 4
  %99 = insertvalue { ptr, i32 } undef, ptr %97, 0
  %100 = insertvalue { ptr, i32 } %99, i32 %98, 1
  resume { ptr, i32 } %100

101:                                              ; preds = %91
  %102 = landingpad { ptr, i32 }
          catch ptr null
  %103 = extractvalue { ptr, i32 } %102, 0
  call void @__clang_call_terminate(ptr %103) #14
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call ptr @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13__get_pointerB8ue170006Ev(ptr noundef %3) #13
  %5 = call ptr @_ZNSt3__112__to_addressB8ue170006IKcEEPT_S3_(ptr noundef %4) #13
  ret ptr %5
}

declare ptr @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryC1ERS3_(ptr noundef returned, ptr noundef nonnull align 8 dereferenceable(8)) unnamed_addr #6

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden zeroext i1 @_ZNKSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentrycvbB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::basic_ostream<char>::sentry", ptr %3, i32 0, i32 0
  %5 = load i8, ptr %4, align 8
  %6 = trunc i8 %5 to i1
  ret i1 %6
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNSt3__116__pad_and_outputB8ue170006IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_(i64 %0, ptr noundef %1, ptr noundef %2, ptr noundef %3, ptr noundef nonnull align 8 dereferenceable(136) %4, i8 noundef signext %5) #2 personality ptr @__gxx_personality_v0 {
  %7 = alloca %"class.std::__1::ostreambuf_iterator", align 8
  %8 = alloca %"class.std::__1::ostreambuf_iterator", align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca i8, align 1
  %14 = alloca i64, align 8
  %15 = alloca i64, align 8
  %16 = alloca i64, align 8
  %17 = alloca %"class.std::__1::basic_string", align 8
  %18 = alloca ptr, align 8
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", ptr %8, i32 0, i32 0
  %22 = inttoptr i64 %0 to ptr
  store ptr %22, ptr %21, align 8
  store ptr %1, ptr %9, align 8
  store ptr %2, ptr %10, align 8
  store ptr %3, ptr %11, align 8
  store ptr %4, ptr %12, align 8
  store i8 %5, ptr %13, align 1
  %23 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", ptr %8, i32 0, i32 0
  %24 = load ptr, ptr %23, align 8
  %25 = icmp eq ptr %24, null
  br i1 %25, label %26, label %27

26:                                               ; preds = %6
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %7, ptr align 8 %8, i64 8, i1 false)
  br label %111

27:                                               ; preds = %6
  %28 = load ptr, ptr %11, align 8
  %29 = load ptr, ptr %9, align 8
  %30 = ptrtoint ptr %28 to i64
  %31 = ptrtoint ptr %29 to i64
  %32 = sub i64 %30, %31
  store i64 %32, ptr %14, align 8
  %33 = load ptr, ptr %12, align 8
  %34 = call i64 @_ZNKSt3__18ios_base5widthB8ue170006Ev(ptr noundef %33)
  store i64 %34, ptr %15, align 8
  %35 = load i64, ptr %15, align 8
  %36 = load i64, ptr %14, align 8
  %37 = icmp sgt i64 %35, %36
  br i1 %37, label %38, label %42

38:                                               ; preds = %27
  %39 = load i64, ptr %14, align 8
  %40 = load i64, ptr %15, align 8
  %41 = sub nsw i64 %40, %39
  store i64 %41, ptr %15, align 8
  br label %43

42:                                               ; preds = %27
  store i64 0, ptr %15, align 8
  br label %43

43:                                               ; preds = %42, %38
  %44 = load ptr, ptr %10, align 8
  %45 = load ptr, ptr %9, align 8
  %46 = ptrtoint ptr %44 to i64
  %47 = ptrtoint ptr %45 to i64
  %48 = sub i64 %46, %47
  store i64 %48, ptr %16, align 8
  %49 = load i64, ptr %16, align 8
  %50 = icmp sgt i64 %49, 0
  br i1 %50, label %51, label %62

51:                                               ; preds = %43
  %52 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", ptr %8, i32 0, i32 0
  %53 = load ptr, ptr %52, align 8
  %54 = load ptr, ptr %9, align 8
  %55 = load i64, ptr %16, align 8
  %56 = call i64 @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnB8ue170006EPKcl(ptr noundef %53, ptr noundef %54, i64 noundef %55)
  %57 = load i64, ptr %16, align 8
  %58 = icmp ne i64 %56, %57
  br i1 %58, label %59, label %61

59:                                               ; preds = %51
  %60 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", ptr %8, i32 0, i32 0
  store ptr null, ptr %60, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %7, ptr align 8 %8, i64 8, i1 false)
  br label %111

61:                                               ; preds = %51
  br label %62

62:                                               ; preds = %61, %43
  %63 = load i64, ptr %15, align 8
  %64 = icmp sgt i64 %63, 0
  br i1 %64, label %65, label %89

65:                                               ; preds = %62
  %66 = load i64, ptr %15, align 8
  %67 = load i8, ptr %13, align 1
  %68 = call ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1B8ue170006Emc(ptr noundef %17, i64 noundef %66, i8 noundef signext %67)
  %69 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", ptr %8, i32 0, i32 0
  %70 = load ptr, ptr %69, align 8
  %71 = call ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataB8ue170006Ev(ptr noundef %17) #13
  %72 = load i64, ptr %15, align 8
  %73 = invoke i64 @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnB8ue170006EPKcl(ptr noundef %70, ptr noundef %71, i64 noundef %72)
          to label %74 unwind label %79

74:                                               ; preds = %65
  %75 = load i64, ptr %15, align 8
  %76 = icmp ne i64 %73, %75
  br i1 %76, label %77, label %84

77:                                               ; preds = %74
  %78 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", ptr %8, i32 0, i32 0
  store ptr null, ptr %78, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %7, ptr align 8 %8, i64 8, i1 false)
  store i32 1, ptr %20, align 4
  br label %85

79:                                               ; preds = %65
  %80 = landingpad { ptr, i32 }
          cleanup
  %81 = extractvalue { ptr, i32 } %80, 0
  store ptr %81, ptr %18, align 8
  %82 = extractvalue { ptr, i32 } %80, 1
  store i32 %82, ptr %19, align 4
  %83 = call ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(ptr noundef %17) #13
  br label %115

84:                                               ; preds = %74
  store i32 0, ptr %20, align 4
  br label %85

85:                                               ; preds = %84, %77
  %86 = call ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(ptr noundef %17) #13
  %87 = load i32, ptr %20, align 4
  switch i32 %87, label %120 [
    i32 0, label %88
    i32 1, label %111
  ]

88:                                               ; preds = %85
  br label %89

89:                                               ; preds = %88, %62
  %90 = load ptr, ptr %11, align 8
  %91 = load ptr, ptr %10, align 8
  %92 = ptrtoint ptr %90 to i64
  %93 = ptrtoint ptr %91 to i64
  %94 = sub i64 %92, %93
  store i64 %94, ptr %16, align 8
  %95 = load i64, ptr %16, align 8
  %96 = icmp sgt i64 %95, 0
  br i1 %96, label %97, label %108

97:                                               ; preds = %89
  %98 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", ptr %8, i32 0, i32 0
  %99 = load ptr, ptr %98, align 8
  %100 = load ptr, ptr %10, align 8
  %101 = load i64, ptr %16, align 8
  %102 = call i64 @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnB8ue170006EPKcl(ptr noundef %99, ptr noundef %100, i64 noundef %101)
  %103 = load i64, ptr %16, align 8
  %104 = icmp ne i64 %102, %103
  br i1 %104, label %105, label %107

105:                                              ; preds = %97
  %106 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", ptr %8, i32 0, i32 0
  store ptr null, ptr %106, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %7, ptr align 8 %8, i64 8, i1 false)
  br label %111

107:                                              ; preds = %97
  br label %108

108:                                              ; preds = %107, %89
  %109 = load ptr, ptr %12, align 8
  %110 = call i64 @_ZNSt3__18ios_base5widthB8ue170006El(ptr noundef %109, i64 noundef 0)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %7, ptr align 8 %8, i64 8, i1 false)
  br label %111

111:                                              ; preds = %108, %105, %85, %59, %26
  %112 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", ptr %7, i32 0, i32 0
  %113 = load ptr, ptr %112, align 8
  %114 = ptrtoint ptr %113 to i64
  ret i64 %114

115:                                              ; preds = %79
  %116 = load ptr, ptr %18, align 8
  %117 = load i32, ptr %19, align 4
  %118 = insertvalue { ptr, i32 } undef, ptr %116, 0
  %119 = insertvalue { ptr, i32 } %118, i32 %117, 1
  resume { ptr, i32 } %119

120:                                              ; preds = %85
  unreachable
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC1B8ue170006ERNS_13basic_ostreamIcS2_EE(ptr noundef returned %0, ptr noundef nonnull align 8 dereferenceable(8) %1) unnamed_addr #7 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = call ptr @_ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC2B8ue170006ERNS_13basic_ostreamIcS2_EE(ptr noundef %5, ptr noundef nonnull align 8 dereferenceable(8) %6) #13
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden i32 @_ZNKSt3__18ios_base5flagsB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::ios_base", ptr %3, i32 0, i32 1
  %5 = load i32, ptr %4, align 8
  ret i32 %5
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden signext i8 @_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE4fillB8ue170006Ev(ptr noundef %0) #2 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call i32 @_ZNSt3__111char_traitsIcE3eofB8ue170006Ev() #13
  %5 = getelementptr inbounds %"class.std::__1::basic_ios", ptr %3, i32 0, i32 2
  %6 = load i32, ptr %5, align 8
  %7 = call zeroext i1 @_ZNSt3__111char_traitsIcE11eq_int_typeB8ue170006Eii(i32 noundef %4, i32 noundef %6) #13
  br i1 %7, label %8, label %12

8:                                                ; preds = %1
  %9 = call signext i8 @_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenB8ue170006Ec(ptr noundef %3, i8 noundef signext 32)
  %10 = sext i8 %9 to i32
  %11 = getelementptr inbounds %"class.std::__1::basic_ios", ptr %3, i32 0, i32 2
  store i32 %10, ptr %11, align 8
  br label %12

12:                                               ; preds = %8, %1
  %13 = getelementptr inbounds %"class.std::__1::basic_ios", ptr %3, i32 0, i32 2
  %14 = load i32, ptr %13, align 8
  %15 = trunc i32 %14 to i8
  ret i8 %15
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden zeroext i1 @_ZNKSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEE6failedB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", ptr %3, i32 0, i32 0
  %5 = load ptr, ptr %4, align 8
  %6 = icmp eq ptr %5, null
  ret i1 %6
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__19basic_iosIcNS_11char_traitsIcEEE8setstateB8ue170006Ej(ptr noundef %0, i32 noundef %1) #2 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %5 = load ptr, ptr %3, align 8
  %6 = load i32, ptr %4, align 4
  call void @_ZNSt3__18ios_base8setstateB8ue170006Ej(ptr noundef %5, i32 noundef %6)
  ret void
}

; Function Attrs: nounwind
declare ptr @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev(ptr noundef returned) unnamed_addr #4

declare void @_ZNSt3__18ios_base33__set_badbit_and_consider_rethrowEv(ptr noundef) #6

declare void @__cxa_end_catch()

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNKSt3__18ios_base5widthB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::ios_base", ptr %3, i32 0, i32 3
  %5 = load i64, ptr %4, align 8
  ret i64 %5
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnB8ue170006EPKcl(ptr noundef %0, ptr noundef %1, i64 noundef %2) #2 align 2 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i64 %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load i64, ptr %6, align 8
  %10 = load ptr, ptr %7, align 8
  %11 = getelementptr inbounds ptr, ptr %10, i64 12
  %12 = load ptr, ptr %11, align 8
  %13 = call i64 %12(ptr noundef %7, ptr noundef %8, i64 noundef %9)
  ret i64 %13
}

; Function Attrs: noinline optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1B8ue170006Emc(ptr noundef returned %0, i64 noundef %1, i8 noundef signext %2) unnamed_addr #5 align 2 {
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca i8, align 1
  store ptr %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  store i8 %2, ptr %6, align 1
  %7 = load ptr, ptr %4, align 8
  %8 = load i64, ptr %5, align 8
  %9 = load i8, ptr %6, align 1
  %10 = call ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2B8ue170006Emc(ptr noundef %7, i64 noundef %8, i8 noundef signext %9)
  ret ptr %7
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13__get_pointerB8ue170006Ev(ptr noundef %3) #13
  %5 = call ptr @_ZNSt3__112__to_addressB8ue170006IcEEPT_S2_(ptr noundef %4) #13
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden i64 @_ZNSt3__18ios_base5widthB8ue170006El(ptr noundef %0, i64 noundef %1) #0 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  store ptr %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  %6 = load ptr, ptr %3, align 8
  %7 = getelementptr inbounds %"class.std::__1::ios_base", ptr %6, i32 0, i32 3
  %8 = load i64, ptr %7, align 8
  store i64 %8, ptr %5, align 8
  %9 = load i64, ptr %4, align 8
  %10 = getelementptr inbounds %"class.std::__1::ios_base", ptr %6, i32 0, i32 3
  store i64 %9, ptr %10, align 8
  %11 = load i64, ptr %5, align 8
  ret i64 %11
}

; Function Attrs: noinline optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2B8ue170006Emc(ptr noundef returned %0, i64 noundef %1, i8 noundef signext %2) unnamed_addr #5 align 2 {
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca i8, align 1
  %7 = alloca %"struct.std::__1::__default_init_tag", align 1
  %8 = alloca %"struct.std::__1::__default_init_tag", align 1
  store ptr %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  store i8 %2, ptr %6, align 1
  %9 = load ptr, ptr %4, align 8
  %10 = getelementptr inbounds %"class.std::__1::basic_string", ptr %9, i32 0, i32 0
  %11 = call ptr @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC1B8ue170006INS_18__default_init_tagESA_EEOT_OT0_(ptr noundef %10, ptr noundef nonnull align 1 dereferenceable(1) %7, ptr noundef nonnull align 1 dereferenceable(1) %8)
  %12 = load i64, ptr %5, align 8
  %13 = load i8, ptr %6, align 1
  call void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6__initEmc(ptr noundef %9, i64 noundef %12, i8 noundef signext %13)
  ret ptr %9
}

declare void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6__initEmc(ptr noundef, i64 noundef, i8 noundef signext) #6

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__112__to_addressB8ue170006IcEEPT_S2_(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC2B8ue170006ERNS_13basic_ostreamIcS2_EE(ptr noundef returned %0, ptr noundef nonnull align 8 dereferenceable(8) %1) unnamed_addr #7 align 2 personality ptr @__gxx_personality_v0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", ptr %5, i32 0, i32 0
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %7, align 8
  %9 = getelementptr i8, ptr %8, i64 -24
  %10 = load i64, ptr %9, align 8
  %11 = getelementptr inbounds i8, ptr %7, i64 %10
  %12 = invoke ptr @_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5rdbufB8ue170006Ev(ptr noundef %11)
          to label %13 unwind label %14

13:                                               ; preds = %2
  store ptr %12, ptr %6, align 8
  ret ptr %5

14:                                               ; preds = %2
  %15 = landingpad { ptr, i32 }
          catch ptr null
  %16 = extractvalue { ptr, i32 } %15, 0
  call void @__clang_call_terminate(ptr %16) #14
  unreachable
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5rdbufB8ue170006Ev(ptr noundef %0) #2 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call ptr @_ZNKSt3__18ios_base5rdbufB8ue170006Ev(ptr noundef %3)
  ret ptr %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNKSt3__18ios_base5rdbufB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::ios_base", ptr %3, i32 0, i32 6
  %5 = load ptr, ptr %4, align 8
  ret ptr %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden zeroext i1 @_ZNSt3__111char_traitsIcE11eq_int_typeB8ue170006Eii(i32 noundef %0, i32 noundef %1) #0 align 2 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = icmp eq i32 %5, %6
  ret i1 %7
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden i32 @_ZNSt3__111char_traitsIcE3eofB8ue170006Ev() #0 align 2 {
  ret i32 -1
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden signext i8 @_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenB8ue170006Ec(ptr noundef %0, i8 noundef signext %1) #2 align 2 personality ptr @__gxx_personality_v0 {
  %3 = alloca ptr, align 8
  %4 = alloca i8, align 1
  %5 = alloca %"class.std::__1::locale", align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i8 %1, ptr %4, align 1
  %8 = load ptr, ptr %3, align 8
  call void @_ZNKSt3__18ios_base6getlocEv(ptr sret(%"class.std::__1::locale") align 8 %5, ptr noundef %8)
  %9 = invoke noundef nonnull align 8 dereferenceable(25) ptr @_ZNSt3__19use_facetB8ue170006INS_5ctypeIcEEEERKT_RKNS_6localeE(ptr noundef nonnull align 8 dereferenceable(8) %5)
          to label %10 unwind label %15

10:                                               ; preds = %2
  %11 = load i8, ptr %4, align 1
  %12 = invoke signext i8 @_ZNKSt3__15ctypeIcE5widenB8ue170006Ec(ptr noundef %9, i8 noundef signext %11)
          to label %13 unwind label %15

13:                                               ; preds = %10
  %14 = call ptr @_ZNSt3__16localeD1Ev(ptr noundef %5) #13
  ret i8 %12

15:                                               ; preds = %10, %2
  %16 = landingpad { ptr, i32 }
          cleanup
  %17 = extractvalue { ptr, i32 } %16, 0
  store ptr %17, ptr %6, align 8
  %18 = extractvalue { ptr, i32 } %16, 1
  store i32 %18, ptr %7, align 4
  %19 = call ptr @_ZNSt3__16localeD1Ev(ptr noundef %5) #13
  br label %20

20:                                               ; preds = %15
  %21 = load ptr, ptr %6, align 8
  %22 = load i32, ptr %7, align 4
  %23 = insertvalue { ptr, i32 } undef, ptr %21, 0
  %24 = insertvalue { ptr, i32 } %23, i32 %22, 1
  resume { ptr, i32 } %24
}

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(25) ptr @_ZNSt3__19use_facetB8ue170006INS_5ctypeIcEEEERKT_RKNS_6localeE(ptr noundef nonnull align 8 dereferenceable(8) %0) #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call ptr @_ZNKSt3__16locale9use_facetERNS0_2idE(ptr noundef %3, ptr noundef nonnull align 8 dereferenceable(12) @_ZNSt3__15ctypeIcE2idE)
  ret ptr %4
}

declare void @_ZNKSt3__18ios_base6getlocEv(ptr sret(%"class.std::__1::locale") align 8, ptr noundef) #6

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden signext i8 @_ZNKSt3__15ctypeIcE5widenB8ue170006Ec(ptr noundef %0, i8 noundef signext %1) #2 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca i8, align 1
  store ptr %0, ptr %3, align 8
  store i8 %1, ptr %4, align 1
  %5 = load ptr, ptr %3, align 8
  %6 = load i8, ptr %4, align 1
  %7 = load ptr, ptr %5, align 8
  %8 = getelementptr inbounds ptr, ptr %7, i64 7
  %9 = load ptr, ptr %8, align 8
  %10 = call signext i8 %9(ptr noundef %5, i8 noundef signext %6)
  ret i8 %10
}

; Function Attrs: nounwind
declare ptr @_ZNSt3__16localeD1Ev(ptr noundef returned) unnamed_addr #4

declare ptr @_ZNKSt3__16locale9use_facetERNS0_2idE(ptr noundef, ptr noundef nonnull align 8 dereferenceable(12)) #6

; Function Attrs: mustprogress noinline optnone ssp uwtable(sync)
define linkonce_odr hidden void @_ZNSt3__18ios_base8setstateB8ue170006Ej(ptr noundef %0, i32 noundef %1) #2 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %"class.std::__1::ios_base", ptr %5, i32 0, i32 4
  %7 = load i32, ptr %6, align 8
  %8 = load i32, ptr %4, align 4
  %9 = or i32 %7, %8
  call void @_ZNSt3__18ios_base5clearEj(ptr noundef %5, i32 noundef %9)
  ret void
}

declare void @_ZNSt3__18ios_base5clearEj(ptr noundef, i32 noundef) #6

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__112__to_addressB8ue170006IKcEEPT_S3_(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13__get_pointerB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call zeroext i1 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9__is_longB8ue170006Ev(ptr noundef %3) #13
  br i1 %4, label %5, label %7

5:                                                ; preds = %1
  %6 = call ptr @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE18__get_long_pointerB8ue170006Ev(ptr noundef %3) #13
  br label %9

7:                                                ; preds = %1
  %8 = call ptr @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE19__get_short_pointerB8ue170006Ev(ptr noundef %3) #13
  br label %9

9:                                                ; preds = %7, %5
  %10 = phi ptr [ %6, %5 ], [ %8, %7 ]
  ret ptr %10
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE18__get_long_pointerB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::basic_string", ptr %3, i32 0, i32 0
  %5 = call noundef nonnull align 8 dereferenceable(24) ptr @_ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ue170006Ev(ptr noundef %4) #13
  %6 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", ptr %5, i32 0, i32 0
  %7 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__long", ptr %6, i32 0, i32 0
  %8 = load ptr, ptr %7, align 8
  ret ptr %8
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE19__get_short_pointerB8ue170006Ev(ptr noundef %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::basic_string", ptr %3, i32 0, i32 0
  %5 = call noundef nonnull align 8 dereferenceable(24) ptr @_ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ue170006Ev(ptr noundef %4) #13
  %6 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", ptr %5, i32 0, i32 0
  %7 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__short", ptr %6, i32 0, i32 0
  %8 = getelementptr inbounds [23 x i8], ptr %7, i64 0, i64 0
  %9 = call ptr @_ZNSt3__114pointer_traitsIPKcE10pointer_toB8ue170006ERS1_(ptr noundef nonnull align 1 dereferenceable(1) %8) #13
  ret ptr %9
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable(sync)
define linkonce_odr hidden ptr @_ZNSt3__114pointer_traitsIPKcE10pointer_toB8ue170006ERS1_(ptr noundef nonnull align 1 dereferenceable(1) %0) #0 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

declare noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc(ptr noundef, i8 noundef signext) #6

declare noundef nonnull align 8 dereferenceable(8) ptr @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv(ptr noundef) #6

attributes #0 = { mustprogress noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { mustprogress noinline norecurse optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #2 = { mustprogress noinline optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #3 = { allocsize(0,1) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #4 = { nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #5 = { noinline optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #6 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #7 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #8 = { noinline noreturn nounwind }
attributes #9 = { argmemonly nocallback nofree nounwind willreturn }
attributes #10 = { mustprogress noinline noreturn optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #11 = { nobuiltin allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #12 = { inaccessiblememonly nocallback nofree nosync nounwind willreturn }
attributes #13 = { nounwind }
attributes #14 = { noreturn nounwind }
attributes #15 = { noreturn }
attributes #16 = { builtin allocsize(0) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 14, i32 4]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Apple clang version 15.0.0 (clang-1500.3.9.4)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
