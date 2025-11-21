from std/math import sqrt
import std/strutils
import std/sequtils
import std/sugar


const PI = 3.1416
proc sqr1[T](x: T): T = x * x
template sqr2(x: untyped): untyped = x * x
proc beforeCall() =
    echo "before"
proc afterCall() =
    echo "after"
proc actuallyCall(): int = 
    echo "call"
    result = 123
template Call(x: untyped): void =
    beforeCall()
    x
    afterCall()

echo sqr1(PI)
echo sqr2(PI)

var y: int
Call():
    y = actuallyCall()
echo y


type
    Point = object
        x, y: int

    Circle = object
        center: Point

template x(c: Circle): int = c.center.x

template `x=`(c: var Circle, v: int) = c.center.x = v

var a, b: Circle

a.center.x = 7
echo a.center.x

b.x = 7
echo b.x

const debug = true

template log(msg: string) =
    if debug: stdout.writeLine(msg)

var xx = 4
log("xx has the value: " & $xx)

template gen = 
    # var z: int
    proc maxx(a, b: int): int =
        if a > b: a else: b


gen()
echo maxx(2, 3)

template withFile(f: untyped, filename: string, actions: untyped) =
    var f: File
    if open(f, filename, fmWrite):
        actions
        close(f)

withFile(myTextFile, "notExistsFileName.txt"):
    myTextFile.writeLine("Line 1")
    myTextFile.writeLine("Line 2")


template times(n: int, actions: untyped) = 
    var i = n
    while i > 0:
        dec i
        actions

var o = 0.0
3.times:
    o += 2.0
    echo o, " ", o * o


template liftScalarProc(fname) =
    proc fname[T](x: openarray[T]): auto =
        var temp: T
        type outType = typeof(fname(temp))
        result = newSeq[outType](x.len)
        for i in 0..x.high:
            result[i] = fname(x[i])

liftScalarProc(sqrt)
echo sqrt(@[4.0, 16.0, 25.0, 36.0])

<<<<<<< HEAD
var s: string = "+"
echo s.repeat(4)
=======

echo "Vec templates"

type
    Vector = object
        x, y, z: int

template getOp(op: untyped) = 
    proc `op`(a, b: Vector): Vector = 
        Vector(x: `op`(a.x, b.x), y: `op`(a.y, b.y), z: `op`(a.z, b.z))


getOp(`+`)
getOp(`-`)

echo `+`(2, 3)

var p = Vector(x: 1, y: 8, z: 9)
var p2 = p + p
echo p2



>>>>>>> cb64cb0 (chapter2 done)

