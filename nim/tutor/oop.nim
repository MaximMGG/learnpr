import std/[strutils, sequtils]

type Person = ref object of RootObj
  name*: string
  age: int


type Student = ref object of Person
  id: int



var
  student: Student
  person: Person

assert(student of Student)

student = Student(name: "Misha", age: 5, id: 2)

echo student[]

type IntFieldInterface = object
    getter: proc(): int
    setter: proc(x: int)

proc outer: IntFieldInterface =
  var captureMe = 0
  proc getter(): int = result = captureMe
  proc setter(x: int) = captureMe = x

  result = IntFieldInterface(getter: getter, setter: setter)


type # this can be with only one type section, if write in with separete 'type' sections it will not be working
  Node = ref object
    le, ri: Node
    sym: ref Sym

  Sym = object
    name: string
    line: int
    code: Node


proc getID(x: Person): int=
  Student(x).id
    

var s = Student(name: "Bill", age: 9, id: 8)
var n: Node

echo getID(s)
#echo getID(n)


type
  NodeKind = enum
    nkInt,
    nkFloat,
    nkString,
    nkAdd,
    nkSub,
    nkIf
  NodeT = ref object
    case kind: NodeKind
    of nkInt: intVal: int
    of nkFloat: floatVal: float
    of nkString: strVal: string
    of nkAdd, nkSub:
      leftOp, rightOp: NodeT
    of nkIf:
      condition, thenPart, elsePart: NodeT
        
var node = NodeT(kind: nkFloat, floatVal: 1.0)

echo repr(node)


echo "Method call syntax"
echo "abc".len
echo "abc".toUpperAscii()
echo ({'a', 'b', 'c'}.card)
stdout.writeLine("Hello")

stdout.writeLine("Give a list of numbers (separated by spaces): ")
# stdout.write(stdin.readLine.splitWhitespace.map(parseInt).max.`$`)
stdout.writeLine(" is the maximum!")

type Socket* = ref object of RootObj
  h: int

proc `host=`*(s: var Socket, value: int) {.inline.} =
    s.h = value

proc host*(s: Socket): int {.inline.} =
  s.h

var sock: Socket
new sock

sock.host = 34


type Vector* = object
    x, y, z: float

proc `[]=`*(v: var Vector, i: int, value: float) =
    case i
    of 0: v.x = value
    of 1: v.y = value
    of 2: v.z = value
    else: assert(false)
    

var v: Vector

v[0] = 2.3
v[1] = 3.3
v[2] = 89.0

# v.`[]=`(1, 0.2) it is all valid proc call
# `[]=`(v, 1, 0.33) it is all valid proc call

echo v


type
  Expression = ref object of RootObj
  Literal = ref object of Expression
    x: int
  PlusExpr = ref object of Expression
    a, b: Expression

method eval(e: Expression): int {.base.} =
  quit "to override!"

method eval(e: Literal): int = e.x
method eval(e: PlusExpr): int = eval(e.a) + eval(e.b)

proc newLit(x: int): Literal = Literal(x: x)
proc newPlus(a, b: Expression): PlusExpr = PlusExpr(a: a, b: b)


echo eval(newPlus(newPlus(newLit(1), newLit(2)), newLit(4)))

type
  Thing = ref object of RootObj
  Unit = ref object of Thing
    x: int


method collide(a, b: Thing) {.inline.} =
  quit "to override!"
method callide(a: Thing, b: Unit) {.inline.} =
  echo "1"
method collide(a: Unit, b: Thing) {.inline.} =
  echo "2"

var t, u: Unit
new t
new u
collide(t, u)

var e: ref OSError

new (e)

e.msg = "The Request to the OS failed"
# aise e


var f: File

if open(f, "first_prog.nim"):
  try:
    let a = readLine(f)
    let b = readLine(f)
    echo "sum: ", parseInt(a) + parseInt(b)
  except IOError:
    echo "IO error!"
  except OverflowDefect:
    echo "overflow!"
  except ValueError:
    echo "Could not convert string to integer"
  except CatchableError:
    echo "Unknown exception!"
    raise # on raise program stop executing
  finally:
    close(f)
