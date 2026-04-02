

let
  a: int8 = 0x7F
  b: uint8 = 0b1111_1111
  c = 0xFF
  d: uint8 = 0

type
  MyInteger* = distinct int


proc `+`(a: MyInteger, b: int): MyInteger =
  MyInteger(cast[int](a) + b)

proc `$`(a: MyInteger): string =
  $cast[int](a)
  
let a2: int = 2


echo MyInteger(3) + a2
