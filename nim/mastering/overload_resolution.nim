


proc takesInt(x: int) = echo "int"
proc takesInt[T](x: T) = echo "T"
proc takesInt(x: int16) = echo "int16"



takesInt(4)
var x: int32
takesInt(x)
var y: int16
takesInt(y)
var z: range[0..4] = 0
takesInt(z)



type
    A = object of RootObj
    B = object of A
    C = object of B

proc p(obj: A) = echo "A"

proc p(obj: B) = echo "B"

var c = C()

p(c)

proc pp(obj: A, obj2: B) = echo("A B")
#proc pp(obj: B, obj2: A) = echo("B A")

pp(c, c)


proc gen[T](x: ref T) = echo "ref T"
proc gen[T](x: ref ref T) = echo "ref ref T"
proc gen[T](x: T) = echo "T"

var ri: ref int
gen(ri)


proc sayHi(x: int): string =
    result = $x

proc sayHi(x: var int): string =
    result = $(x + 10)

proc sayHello(x: int) = 
    var m = x
    echo sayHi(x)
    echo sayHi(m)


sayHello(3)


