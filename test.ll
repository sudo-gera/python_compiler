; ModuleID = ""
target triple = ""
target datalayout = ""

declare i8* @"calloc"(i64 %".1", i64 %".2")

declare i32 @"getchar"()

declare i32 @"putchar"(i32 %".1")

declare i32 @"puts"(i8* %".1")

declare void @"print_int"(i64 %".1")

declare i8* @"get_cell_from_function"(i8* %".1", i64 %".2")

declare i64 @"get_code_from_function"(i8* %".1")

declare void @"add_cell_to_function"(i8* %".1", i8* %".2")

declare i8* @"create_py_function"(i64 %".1")

declare void @"get_static_size_of_unknown_value"(i8* %".1")

declare i8* @"create_py_object"()

define i32 @"main"(i32 %".1", i8** %".2")
{
.4:
  %"n" = call i8* @"create_py_object"()
  %"m" = call i8* @"create_py_object"()
  %"print" = call i8* @"create_py_object"()
  %"result" = call i8* @"create_py_object"()
  %"s" = call i8* @"create_py_object"()
  %"wrapper" = call i8* @"create_py_object"()
  %"f" = call i8* @"create_py_object"()
  %"a" = call i8* @"create_py_object"()
  %"partial" = call i8* @"create_py_object"()
  %"sum" = call i8* @"create_py_object"()
  %"add_5" = call i8* @"create_py_object"()
  %"add_6" = call i8* @"create_py_object"()
  %"print.1" = call i8* @"create_py_function"(i64 4321886272)
  %".5" = bitcast i8* %"print" to i8**
  store i8* %"print.1", i8** %".5", align 8
  %"result.1" = bitcast i8* %"result" to i64*
  store i64 0, i64* %"result.1", align 8
  %"wrapper.1" = call i8* @"create_py_function"(i64 4321891648)
  %".8" = bitcast i8* %"wrapper" to i8**
  store i8* %"wrapper.1", i8** %".8", align 8
  %"partial.1" = call i8* @"create_py_function"(i64 4321901728)
  %".10" = bitcast i8* %"partial" to i8**
  store i8* %"partial.1", i8** %".10", align 8
  call void @"add_cell_to_function"(i8* %"partial.1", i8* %"wrapper")
  call void @"add_cell_to_function"(i8* %"partial.1", i8* %"s")
  %"sum.1" = call i8* @"create_py_function"(i64 4322138224)
  %".12" = bitcast i8* %"sum" to i8**
  store i8* %"sum.1", i8** %".12", align 8
  call void @"add_cell_to_function"(i8* %"sum.1", i8* %"result")
  %".14" = bitcast i8* %"partial" to i8**
  %"partial.2" = load i8*, i8** %".14"
  %".15" = bitcast i8* %"sum" to i8**
  %"sum.2" = load i8*, i8** %".15"
  %".16" = call i64 @"get_code_from_function"(i8* %"partial.2")
  switch i64 %".16", label %".18" [i64 4321901728, label %".31"]
.17:
  %".34" = bitcast i8* %"wrapper" to i8**
  %"wrapper.3" = load i8*, i8** %".34"
  %"add_5.1" = bitcast i8* %"add_5" to i8**
  store i8* %"wrapper.3", i8** %"add_5.1", align 8
  %".36" = bitcast i8* %"partial" to i8**
  %"partial.3" = load i8*, i8** %".36"
  %".37" = bitcast i8* %"sum" to i8**
  %"sum.3" = load i8*, i8** %".37"
  %".38" = call i64 @"get_code_from_function"(i8* %"partial.3")
  switch i64 %".38", label %".40" [i64 4321901728, label %".53"]
.18:
  %".19" = trunc i64 63 to i32
  %".20" = call i32 @"putchar"(i32 %".19")
  %".21" = sext i32 %".20" to i64
  %".22" = trunc i64 63 to i32
  %".23" = call i32 @"putchar"(i32 %".22")
  %".24" = sext i32 %".23" to i64
  %".25" = trunc i64 63 to i32
  %".26" = call i32 @"putchar"(i32 %".25")
  %".27" = sext i32 %".26" to i64
  call void @"print_int"(i64 %".16")
  br label %".17"
.31:
  call void @"partial_1"(i8* %"partial.2", i8* %"sum.2", i64 5)
  br label %".17"
.39:
  %".56" = bitcast i8* %"wrapper" to i8**
  %"wrapper.4" = load i8*, i8** %".56"
  %"add_6.1" = bitcast i8* %"add_6" to i8**
  store i8* %"wrapper.4", i8** %"add_6.1", align 8
  %"result.3" = bitcast i8* %"result" to i64*
  store i64 0, i64* %"result.3", align 8
  %".59" = bitcast i8* %"add_5" to i8**
  %"add_5.2" = load i8*, i8** %".59"
  %".60" = call i64 @"get_code_from_function"(i8* %"add_5.2")
  switch i64 %".60", label %".62" [i64 4321901200, label %".75" i64 4321891648, label %".78"]
.40:
  %".41" = trunc i64 63 to i32
  %".42" = call i32 @"putchar"(i32 %".41")
  %".43" = sext i32 %".42" to i64
  %".44" = trunc i64 63 to i32
  %".45" = call i32 @"putchar"(i32 %".44")
  %".46" = sext i32 %".45" to i64
  %".47" = trunc i64 63 to i32
  %".48" = call i32 @"putchar"(i32 %".47")
  %".49" = sext i32 %".48" to i64
  call void @"print_int"(i64 %".38")
  br label %".39"
.53:
  call void @"partial_1"(i8* %"partial.3", i8* %"sum.3", i64 6)
  br label %".39"
.61:
  %".81" = bitcast i8* %"print" to i8**
  %"print.2" = load i8*, i8** %".81"
  %".82" = bitcast i8* %"result" to i64*
  %"result.4" = load i64, i64* %".82"
  %".83" = call i64 @"get_code_from_function"(i8* %"print.2")
  switch i64 %".83", label %".85" [i64 4321886272, label %".98"]
.62:
  %".63" = trunc i64 63 to i32
  %".64" = call i32 @"putchar"(i32 %".63")
  %".65" = sext i32 %".64" to i64
  %".66" = trunc i64 63 to i32
  %".67" = call i32 @"putchar"(i32 %".66")
  %".68" = sext i32 %".67" to i64
  %".69" = trunc i64 63 to i32
  %".70" = call i32 @"putchar"(i32 %".69")
  %".71" = sext i32 %".70" to i64
  call void @"print_int"(i64 %".60")
  br label %".61"
.75:
  call void @"wrapper_2"(i8* %"add_5.2", i64 3)
  br label %".61"
.78:
  call void @"wrapper_4"(i8* %"add_5.2", i64 3)
  br label %".61"
.84:
  %"result.5" = bitcast i8* %"result" to i64*
  store i64 0, i64* %"result.5", align 8
  %".102" = bitcast i8* %"add_6" to i8**
  %"add_6.2" = load i8*, i8** %".102"
  %".103" = call i64 @"get_code_from_function"(i8* %"add_6.2")
  switch i64 %".103", label %".105" [i64 4321901200, label %".118" i64 4321891648, label %".121"]
.85:
  %".86" = trunc i64 63 to i32
  %".87" = call i32 @"putchar"(i32 %".86")
  %".88" = sext i32 %".87" to i64
  %".89" = trunc i64 63 to i32
  %".90" = call i32 @"putchar"(i32 %".89")
  %".91" = sext i32 %".90" to i64
  %".92" = trunc i64 63 to i32
  %".93" = call i32 @"putchar"(i32 %".92")
  %".94" = sext i32 %".93" to i64
  call void @"print_int"(i64 %".83")
  br label %".84"
.98:
  call void @"print_5"(i8* %"print.2", i64 %"result.4")
  br label %".84"
.104:
  %".124" = bitcast i8* %"print" to i8**
  %"print.3" = load i8*, i8** %".124"
  %".125" = bitcast i8* %"result" to i64*
  %"result.6" = load i64, i64* %".125"
  %".126" = call i64 @"get_code_from_function"(i8* %"print.3")
  switch i64 %".126", label %".128" [i64 4321886272, label %".141"]
.105:
  %".106" = trunc i64 63 to i32
  %".107" = call i32 @"putchar"(i32 %".106")
  %".108" = sext i32 %".107" to i64
  %".109" = trunc i64 63 to i32
  %".110" = call i32 @"putchar"(i32 %".109")
  %".111" = sext i32 %".110" to i64
  %".112" = trunc i64 63 to i32
  %".113" = call i32 @"putchar"(i32 %".112")
  %".114" = sext i32 %".113" to i64
  call void @"print_int"(i64 %".103")
  br label %".104"
.118:
  call void @"wrapper_2"(i8* %"add_6.2", i64 3)
  br label %".104"
.121:
  call void @"wrapper_4"(i8* %"add_6.2", i64 3)
  br label %".104"
.127:
  ret i32 0
.128:
  %".129" = trunc i64 63 to i32
  %".130" = call i32 @"putchar"(i32 %".129")
  %".131" = sext i32 %".130" to i64
  %".132" = trunc i64 63 to i32
  %".133" = call i32 @"putchar"(i32 %".132")
  %".134" = sext i32 %".133" to i64
  %".135" = trunc i64 63 to i32
  %".136" = call i32 @"putchar"(i32 %".135")
  %".137" = sext i32 %".136" to i64
  call void @"print_int"(i64 %".126")
  br label %".127"
.141:
  call void @"print_5"(i8* %"print.3", i64 %"result.6")
  br label %".127"
}

define void @"partial_1"(i8* %".1", i8* %".2", i64 %".3")
{
.5:
  %".6" = call i8* @"create_py_object"()
  %".7" = call i8* @"create_py_object"()
  %"wrapper" = call i8* @"get_cell_from_function"(i8* %".1", i64 0)
  %"s" = call i8* @"get_cell_from_function"(i8* %".1", i64 1)
  %"f" = bitcast i8* %".6" to i8**
  store i8* %".2", i8** %"f", align 8
  %"a" = bitcast i8* %".7" to i64*
  store i64 %".3", i64* %"a", align 8
  %"wrapper.1" = call i8* @"create_py_function"(i64 4321901200)
  %".10" = bitcast i8* %"wrapper" to i8**
  store i8* %"wrapper.1", i8** %".10", align 8
  call void @"add_cell_to_function"(i8* %"wrapper.1", i8* %".6")
  call void @"add_cell_to_function"(i8* %"wrapper.1", i8* %".7")
  ret void
}

define void @"wrapper_2"(i8* %".1", i64 %".2")
{
.4:
  %".5" = call i8* @"create_py_object"()
  %"f" = call i8* @"get_cell_from_function"(i8* %".1", i64 0)
  %"a" = call i8* @"get_cell_from_function"(i8* %".1", i64 1)
  %"s" = bitcast i8* %".5" to i64*
  store i64 %".2", i64* %"s", align 8
  %".7" = bitcast i8* %"f" to i8**
  %"f.1" = load i8*, i8** %".7"
  %".8" = bitcast i8* %"a" to i64*
  %"a.1" = load i64, i64* %".8"
  %".9" = bitcast i8* %".5" to i64*
  %"s.1" = load i64, i64* %".9"
  %".10" = call i64 @"get_code_from_function"(i8* %"f.1")
  switch i64 %".10", label %".12" [i64 4322138224, label %".25"]
.11:
  ret void
.12:
  %".13" = trunc i64 63 to i32
  %".14" = call i32 @"putchar"(i32 %".13")
  %".15" = sext i32 %".14" to i64
  %".16" = trunc i64 63 to i32
  %".17" = call i32 @"putchar"(i32 %".16")
  %".18" = sext i32 %".17" to i64
  %".19" = trunc i64 63 to i32
  %".20" = call i32 @"putchar"(i32 %".19")
  %".21" = sext i32 %".20" to i64
  call void @"print_int"(i64 %".10")
  br label %".11"
.25:
  call void @"sum_3"(i8* %"f.1", i64 %"a.1", i64 %"s.1")
  br label %".11"
}

define void @"sum_3"(i8* %".1", i64 %".2", i64 %".3")
{
.5:
  %".6" = call i8* @"create_py_object"()
  %".7" = call i8* @"create_py_object"()
  %"result" = call i8* @"get_cell_from_function"(i8* %".1", i64 0)
  %"a" = bitcast i8* %".6" to i64*
  store i64 %".2", i64* %"a", align 8
  %"s" = bitcast i8* %".7" to i64*
  store i64 %".3", i64* %"s", align 8
  %".10" = bitcast i8* %".6" to i64*
  %"a.1" = load i64, i64* %".10"
  %".11" = bitcast i8* %".7" to i64*
  %"s.1" = load i64, i64* %".11"
  %".12" = add i64 %"a.1", %"s.1"
  %"result.1" = bitcast i8* %"result" to i64*
  store i64 %".12", i64* %"result.1", align 8
  ret void
}

define void @"wrapper_4"(i8* %".1", i64 %".2")
{
.4:
  %".5" = call i8* @"create_py_object"()
  %"s" = bitcast i8* %".5" to i64*
  store i64 %".2", i64* %"s", align 8
  ret void
}

define void @"print_5"(i8* %".1", i64 %".2")
{
.4:
  %".5" = call i8* @"create_py_object"()
  %".6" = call i8* @"create_py_object"()
  %"n" = bitcast i8* %".5" to i64*
  store i64 %".2", i64* %"n", align 8
  %".8" = bitcast i8* %".5" to i64*
  %"n.1" = load i64, i64* %".8"
  %".9" = icmp eq i64 %"n.1", 0
  %".10" = icmp ne i1 %".9", 0
  br i1 %".10", label %".4.if", label %".4.else"
.4.if:
  %".12" = trunc i64 48 to i32
  %".13" = call i32 @"putchar"(i32 %".12")
  %".14" = sext i32 %".13" to i64
  br label %".4.endif"
.4.else:
  %".16" = bitcast i8* %".5" to i64*
  %"n.2" = load i64, i64* %".16"
  %".17" = icmp slt i64 %"n.2", 0
  %".18" = icmp ne i1 %".17", 0
  br i1 %".18", label %".4.else.if", label %".4.else.else"
.4.endif:
  %".80" = trunc i64 10 to i32
  %".81" = call i32 @"putchar"(i32 %".80")
  %".82" = sext i32 %".81" to i64
  ret void
.4.else.if:
  %".20" = trunc i64 45 to i32
  %".21" = call i32 @"putchar"(i32 %".20")
  %".22" = sext i32 %".21" to i64
  %".23" = bitcast i8* %".5" to i64*
  %"n.3" = load i64, i64* %".23"
  %".24" = sub i64 0, %"n.3"
  %"n.4" = bitcast i8* %".5" to i64*
  store i64 %".24", i64* %"n.4", align 8
  br label %".4.else.endif"
.4.else.else:
  br label %".4.else.endif"
.4.else.endif:
  %"m" = bitcast i8* %".6" to i64*
  store i64 1, i64* %"m", align 8
  br label %".29"
.29:
  %".31" = bitcast i8* %".6" to i64*
  %"m.1" = load i64, i64* %".31"
  %".32" = bitcast i8* %".5" to i64*
  %"n.5" = load i64, i64* %".32"
  %".33" = icmp sle i64 %"m.1", %"n.5"
  %".34" = icmp ne i1 %".33", 0
  br i1 %".34", label %".29.if", label %".29.else"
.29.if:
  %".36" = bitcast i8* %".6" to i64*
  %"m.2" = load i64, i64* %".36"
  %".37" = mul i64 %"m.2", 10
  %"m.3" = bitcast i8* %".6" to i64*
  store i64 %".37", i64* %"m.3", align 8
  br label %".29"
.29.else:
  br label %".29.endif"
.29.endif:
  %".41" = bitcast i8* %".6" to i64*
  %"m.4" = load i64, i64* %".41"
  %".42" = srem i64 %"m.4", 10
  %".43" = add i64 %".42", 10
  %".44" = srem i64 %".43", 10
  %".45" = sub i64 %"m.4", %".44"
  %".46" = sdiv i64 %".45", 10
  %"m.5" = bitcast i8* %".6" to i64*
  store i64 %".46", i64* %"m.5", align 8
  br label %".48"
.48:
  %".50" = bitcast i8* %".6" to i64*
  %"m.6" = load i64, i64* %".50"
  %".51" = icmp ne i64 %"m.6", 0
  br i1 %".51", label %".48.if", label %".48.else"
.48.if:
  %".53" = bitcast i8* %".5" to i64*
  %"n.6" = load i64, i64* %".53"
  %".54" = bitcast i8* %".6" to i64*
  %"m.7" = load i64, i64* %".54"
  %".55" = srem i64 %"n.6", %"m.7"
  %".56" = add i64 %".55", %"m.7"
  %".57" = srem i64 %".56", %"m.7"
  %".58" = sub i64 %"n.6", %".57"
  %".59" = sdiv i64 %".58", %"m.7"
  %".60" = add i64 %".59", 48
  %".61" = trunc i64 %".60" to i32
  %".62" = call i32 @"putchar"(i32 %".61")
  %".63" = sext i32 %".62" to i64
  %".64" = bitcast i8* %".5" to i64*
  %"n.7" = load i64, i64* %".64"
  %".65" = bitcast i8* %".6" to i64*
  %"m.8" = load i64, i64* %".65"
  %".66" = srem i64 %"n.7", %"m.8"
  %".67" = add i64 %".66", %"m.8"
  %".68" = srem i64 %".67", %"m.8"
  %"n.8" = bitcast i8* %".5" to i64*
  store i64 %".68", i64* %"n.8", align 8
  %".70" = bitcast i8* %".6" to i64*
  %"m.9" = load i64, i64* %".70"
  %".71" = srem i64 %"m.9", 10
  %".72" = add i64 %".71", 10
  %".73" = srem i64 %".72", 10
  %".74" = sub i64 %"m.9", %".73"
  %".75" = sdiv i64 %".74", 10
  %"m.10" = bitcast i8* %".6" to i64*
  store i64 %".75", i64* %"m.10", align 8
  br label %".48"
.48.else:
  br label %".48.endif"
.48.endif:
  br label %".4.endif"
}
