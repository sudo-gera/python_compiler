; ModuleID = ""
target triple = ""
target datalayout = ""

declare i8* @"calloc"(i64 %".1", i64 %".2")

declare i32 @"getchar"()

declare i32 @"putchar"(i32 %".1")

declare i32 @"puts"(i8* %".1")

declare void @"get_static_size_of_unknown_value"(i8* %".1")

declare i8* @"create_py_object"()

declare double @"int64_to_double"(i64 %".1")

declare i64 @"double_to_int64"(double %".1")

define i32 @"main"(i32 %".1", i8** %".2")
{
.4:
  %".5" = call i8* @"create_py_object"()
  %".6" = bitcast i8* %".5" to i64*
  store i64 48, i64* %".6", align 8
  %".8" = bitcast i8* %".5" to i64*
  %".9" = load i64, i64* %".8"
  %".10" = trunc i64 %".9" to i32
  %".11" = call i32 @"putchar"(i32 %".10")
  %".12" = sext i32 %".11" to i64
  %".13" = bitcast i8* %".5" to i64*
  %".14" = load i64, i64* %".13"
  %".15" = add i64 %".14", 1
  %".16" = bitcast i8* %".5" to i64*
  store i64 %".15", i64* %".16", align 8
  %".18" = bitcast i8* %".5" to i64*
  %".19" = load i64, i64* %".18"
  %".20" = trunc i64 %".19" to i32
  %".21" = call i32 @"putchar"(i32 %".20")
  %".22" = sext i32 %".21" to i64
  ret i32 0
}
