import posix
import system/ansi_c


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




