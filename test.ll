; ModuleID = ""
target triple = ""
target datalayout = ""

declare i8* @"calloc"(i64 %".1", i64 %".2")

declare i32 @"getchar"()

declare i32 @"putchar"(i32 %".1")

declare i32 @"puts"(i8* %".1")

declare i32 @"stop_module"()

declare void @"start_module"(i32 %".1", i8** %".2")

define i32 @"main"(i32 %".1", i8** %".2")
{
.4:
  call void @"start_module"(i32 %".1", i8** %".2")
  %".6" = call i32 @"stop_module"()
  ret i32 %".6"
}
