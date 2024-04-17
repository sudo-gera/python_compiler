; ModuleID = ""
target triple = "unknown-unknown-unknown"
target datalayout = ""

define void @"mul"(i65536* %".1", i65536* %".2")
{
.4:
  %".5" = load i65536, i65536* %".1"
  %".6" = load i65536, i65536* %".2"
  %".7" = mul i65536 %".5", %".6"
  store i65536 %".7", i65536* %".1"
  ret void
}

define void @"sub"(i65536* %".1", i65536* %".2")
{
.4:
  %".5" = load i65536, i65536* %".1"
  %".6" = load i65536, i65536* %".2"
  %".7" = sub i65536 %".5", %".6"
  store i65536 %".7", i65536* %".1"
  ret void
}

define void @"add"(i65536* %".1", i65536* %".2")
{
.4:
  %".5" = load i65536, i65536* %".1"
  %".6" = load i65536, i65536* %".2"
  %".7" = add i65536 %".5", %".6"
  store i65536 %".7", i65536* %".1"
  ret void
}

define void @"sdiv"(i65536* %".1", i65536* %".2")
{
.4:
  %".5" = load i65536, i65536* %".1"
  %".6" = load i65536, i65536* %".2"
  %".7" = sdiv i65536 %".5", %".6"
  store i65536 %".7", i65536* %".1"
  ret void
}

define void @"srem"(i65536* %".1", i65536* %".2")
{
.4:
  %".5" = load i65536, i65536* %".1"
  %".6" = load i65536, i65536* %".2"
  %".7" = srem i65536 %".5", %".6"
  store i65536 %".7", i65536* %".1"
  ret void
}

