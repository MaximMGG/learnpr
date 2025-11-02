

echo "discard"

proc p(x, y: int): int =
    return x + y

discard p(3, 4)

echo "{.dicardable.}"
proc p2(x, y: int): int {.discardable.} =
    return x + y

p2(3, 4)


type Arr[T] = object
    data: seq[T]
    len: uint


proc arr[T](): Arr[T] =
    result.data = @[]
    result.len = 0


static:
    echo "echo in compile type"

    
    
type
    Obj = object
        a: int32
        b: int32


var o: Obj

cast[ptr int32](cast[uint](addr o) + 4)[] = 999
echo o


let t1 = "Hello"

var t2 = t1
var t3: pointer = addr(t2)
echo repr(addr(t2))
echo cast[ptr string](t3)[]


