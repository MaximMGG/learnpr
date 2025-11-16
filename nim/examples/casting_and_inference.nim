

var x = 5
var y = "foo"

var x2 = int(1.0 / 3)

echo x2

var y2: seq[int] = @[]


y2.add(123)
y2.add(123)
y2.add(123)
y2.add(123)

echo repr(y2)

var z = "Foobar"
proc ffi(foo: ptr array[6, char]) =
  echo repr(foo)
  echo sizeof(foo)

  
ffi(cast[ptr array[6, char]](addr z[0]))

let p = addr z[0]

echo p[]

let p_arr = cast[ptr array[6, char]](p)

echo repr(p_arr)
