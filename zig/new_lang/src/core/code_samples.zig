pub const RETURN_ZERO = 
\\fn i32 main() {
\\  return 0;
\\}
;

pub const RETURN_ZERO_WITH_INT = 
"fn i32 main() {\n" ++ 
"  i32 number = 10;\n" ++
"  return 0;\n" ++ 
"}\n";

pub const RETURN_10_PLUS_10 = 
\\fn void main() {
\\  return 10 + 10;
\\}
;

pub const HELLO_WORLD = 
\\fn void main() {
\\  println("Hello world!");
\\  return 0;
\\}
;

pub const GLOBAL = 
\\i32 number = 10;
;
