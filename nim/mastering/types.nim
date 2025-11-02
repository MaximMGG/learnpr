import posix
import system/ansi_c
import math
import json


type 
    Subrange = range[0..5]

var s: Subrange = 2


type Dog = object
    age: int32
    name: cstring


proc tallName(d: ptr Dog): cstring {.inline.} = d.name

var d: Dog = Dog(age: 32, name: "ijij")

echo sizeof(s)
echo sizeof(int8)
echo sizeof(Dog)
echo tallName(addr(d))


assert ord(true) == 1 and ord(false) == 0


type Direction = enum
    North, East = ("Easterniestinguish"), South, West


assert ord(Direction.East) == 1
echo Direction.East
echo sizeof(Direction)

type
    MyEnum{.pure.} = enum
        valA, valB, valC, amb

    OtherEnum{.pure.} = enum
        valX, valY, amb

echo valA
echo OtherEnum.amb


echo "Overloadable enum field names"

type
    E1 = enum
        value1, value2
    E2 = enum
        value1, value2 = 4

const
    lookupTable = [
        E1.value1: "1",
        value2: "2"]


proc p(e: E1) =
    case e
    of value1: echo "A"
    of value2: echo "B"

p(value2)


type Person = object
    name: string
    age: int


proc `$`(p: Person): string =
    result = p.name & " is " & $p.age & " yeadrs old."

var mujic = Person(name: "Billy", age: 54)
echo $mujic

proc printf(fmt: cstring){.importc: "printf", varargs, header: "<stdio.h>".}
proc fprintf(handlr: ptr, fmt: cstring) {.importc: "fprintf", varargs, header: "<stdio.h>".}

printf("This works %s\n", "as expected")
fprintf(stderr, "Print in stderr: %s\n", "IJIJIJ")

c_printf("IJIJIJ\n")


const str: string = "Hello!"
var cstr: cstring = str
var newstr: string = $cstr
echo newstr


echo "STRUCTURED TYPES\n\n\n"

type
    IntArray = array[0..5, int]
    IntSeq = seq[int]

var x: IntArray
var y: IntSeq
x = [1, 2, 3, 4, 5, 6]
y = @[1, 2, 3, 4, 5, 6]
echo x
echo y
y.add(888)
echo y

proc testOpenArray(x: openArray[int]) = echo repr(x)

testOpenArray([1, 2, 3])
testOpenArray(@[8, 2, 3])

echo "VARARGS\n\n\n"

proc myWriteLn(f: File, a: varargs[string]) =
    for s in items(a):
        write(f, s)
    write(f, "\n");


myWriteLn(stdout, "abs\n", "qqq\n", "oijoij")


proc myWriteLn2(f: File, a: varargs[string, `$`]) =
    for i in items(a):
        write(f, i)
    write(f, '\n')

myWriteLn2(stdout, "What a ", 2, " number", " and float: ", 4.8)

echo "Unchecked Arrays\n\n\n"

type MySeq[T] = object
    len, cap: int
    data: UncheckedArray[T]


type 
 Cat = tuple[name: string, age: int]

var cat: Cat
cat = (name: "Bobby", age: 3)
assert cat.name == "Bobby"
cat = ("Misha", 7)
assert cat[0] == "Misha"
assert Cat is (string, int)
assert (string, int) is Cat
assert Cat isnot tuple[other: string, age: int]


proc echoUnaryTuple(a: (int, )) =
    echo a[0]

echoUnaryTuple (3, )


echo "Little einheritanse"


type 
    Construction = object of RootObj
        name*: string
        age: int

    Box = ref object of Construction
        id: int



proc tellName(c: Construction) =
    echo c.name

var 
    box: Box = Box(name: "box", age: 1, id: 123132)
    construction: Construction = Construction(name: "Building", age: 12)


# tellName(box)

assert(box of Box)
assert(box of Construction)


echo "Fields and fieldPairs"

proc `$`[T: object](x: T): string =
    result = "["
    for name, val in fieldPairs(x):
        result.add name
        result.add ": "
        result.add $val
        result.add "\n"
    result.add "]\n"


# proc fromJ[T: object](t: typedesc[T]; j: JsonNode): T =
#     result = T()
#     for name, loc in fieldPairs(result):
#         loc = fromJ(typeof(loc), j[name])

proc `==`[T: object](x, y: T): bool =
    for a, b in fields(x, y):
        if not (a == b): return false
    return true


var per = Person(name: "kj", age: 123)
var bb = Person(name: "kj", age: 123)

if per == bb:
    echo per, " and ", bb, " the same"
else:
    echo "They are diffrent"


echo "Object construction\n\n\n"


type 
    Student = object
        name: string
        age: int
    PStudent = ref Student

proc `$`(s: Student): string =
    return s.name & ": " & $s.age

var a1 = Student(name: "Bill", age: 12)
var a2 = PStudent(name: "John", age: 24)

var a3 = (ref Student)(name: "John", age: 22)
var a4 = Student(age: 8)

echo $a1, $a4

echo "Object variants (Union)"

type 
    NodeKind = enum
        nkInt,
        nkFloat,
        nkString,
        nkAdd,
        nkSub,
        nkIf
    Node = ref NodeObj
    NodeObj = object
        case kind: NodeKind
        of nkInt: intVal: int
        of nkFloat: floatVal: float
        of nkString: stringVal: string
        of nkAdd, nkSub: leftOp, rightOp: Node
        of nkIf: condition, thenPart, elsePart: Node
        

var n = Node(kind: nkIf, condition: nil)
n.thenPart = Node(kind: nkFloat, floatVal: 2.0)
# n.stringVal = ""
# n.kind = nkInt
# n.intVal = 2


# const unknownKind = nkString
# var y = Node(kind: unknownKind, stringVal: "y")

echo "cast uncheckedAssign\n\n\n"

type 
    TokenKind* = enum
        strLit, intLit
    Token = object
        case kind*: TokenKind
        of strLit: s*: string
        of intLit: l*: int64


proc passToVar(x: var TokenKind) = discard

var t = Token(kind: strLit, s: "abc")

{.cast(uncheckedAssign).}:
    passtoVar(t.kind)

    t = Token(kind: t.kind, s: "abc")
    t.kind = intLit
    

type
    CharSet = set[char]

var 
    x_set: CharSet

x_set = {'a'..'z', '0'..'9'}

x_set.incl('Q')
echo x_set
echo sizeof(x_set)

if 'f' in x_set:
    echo "f in set"

var y_set: CharSet = {'A'..'Q', 'v'}
echo x_set + y_set

if '!' notin y_set:
    echo "! not in y_set"

echo "BIT FIELDS\n\n\n"

type
    MyFlag* {.size: sizeof(cint).} = enum
        A, B, C, D
    MyFlags = set[MyFlag]


proc toNum(f: MyFlags): int =   cast[int](f)
proc toFlags(v: int): MyFlags = cast[MyFlags](v)

assert toNum({}) == 0
assert toNum({A}) == 1
assert toNum({D}) == 8
assert toNum({A, C}) == 5
assert toFlags(0) == {}
assert toFlags(7) == {A, B, C}

echo "All assertion done"

echo "Reference and pointer types\n\n\n"

echo "0x", cast[uint64](addr(y_set))


var arr: array[5, int32] = [1, 2, 3, 4, 5]

for i in 0..<arr.len:
    echo cast[uint64](addr(arr[i]))


type
    Node2 = ref NodeObj2
    NodeObj2 = object
        le, ri: Node2
        data: int

var node: Node2
new(node)

node.data = 9

echo "Node addr: ", cast[uint64](addr(node))


echo static(fac(5)), " ", static[bool](16.isPowerOfTwo)


type
    Matrix[M, N: static int; T: SomeNumber] = array[0..(M*N - 1), T]


    AffineTransform2D[T] = Matrix[3, 3, T]
    AffineTransform3D[T] = Matrix[4, 4, T]

var m1: AffineTransform3D[float32]
echo m1

template maxval(T: typedesc[int]): int = high(int)
template maxval(T: typedesc[float]): float = Inf

template maxval2[T](U: typedesc[T]): T = high(T)

var i = int.maxval
var f = float.maxval
var i2 = int32.maxval2
echo i, " ", f, " ", i2


echo "typeof keyword\n\n\n"

iterator split(s: string): string = discard
proc split(s: string): seq[string] = discard


assert typeof("a b c".split) is string
assert typeof("a b c".split, typeOfProc) is seq[string]


proc fromJ[T: enum](t: typedesc[T]; j: JsonNode): T{.inline.} = T(j.getInt)

proc fromJ(t: typedesc[string]; j: JsonNode): string{.inline.} = j.getStr
proc fromJ(t: typedesc[bool]; j: JsonNode): string{.inline.} = j.getBool
proc fromJ(t: typedesc[int]; j: JsonNode): string{.inline.} = j.getInt
proc fromJ(t: typedesc[float]; j: JsonNode): string{.inline.} = j.getFloat

proc fromJ[T: seq](t: typedesc[T]; j: JsonNode): T =
    result = newSeq[typeof(result[0])]()
    assert j.kind == JArray
    for elem in itmes(f):
        result.add fromJ(typeof(result[0]), elem)


proc fromJ[T: object](t: typedesc[T]; j: JsonNode): T =
    result = T()
    assert j.kind == JObject
    for name, loc in fieldPairs(result):
        if j.hasKey(name):
            loc = fromJ(typeof(loc), j[name])

