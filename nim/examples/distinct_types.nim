

type
  Dollars* = distinct float

var a = 20.Dollars
a = 25.Dollars
var b = 35.Dollars

proc `+`(a, b: Dollars): Dollars {.borrow.}
proc `$`(a: Dollars): string {.borrow.}

echo a + b


var d: ptr int = cast[ptr int](alloc0(sizeof(int)))


d[] = 123

echo d[]

dealloc(d)
