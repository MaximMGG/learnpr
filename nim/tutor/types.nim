type
  Direction = enum
    NORTH, EAST, SOUTH, WEST


proc printDir(d: Direction) =
  case d:
  of NORTH:
    echo "NORTH"
  of EAST:
    echo "EAST"
  of SOUTH:
    echo "SOUTH"
  of WEST:
    echo "WEST"



var
  myBool = true
  myChar = 'n'
  myString = "Hello"
  myInt = 45
  myFloat = 3.3


echo myBool, ":", repr(myBool)
echo myChar, ":", repr(myChar)
echo myString, ":", repr(myString)
echo myInt, ":", repr(myInt)
echo myFloat, ":", repr(myFloat)

printDir(EAST)
echo Direction.SOUTH


type
  CharSet = set[char]

var
  x: CharSet

x = {'a'..'z', '0'..'9'}

if 'a' in x:
  echo "a in x"

if x.contains('a'):
  echo "'a' in set"

if not x.contains('B'):
  echo "'B' not in set"

type
  MyFlag* {.size: sizeof(cint).} = enum
   A
   B
   C
   D
  MyFlags = set[MyFlag]


proc toNum(f: MyFlags): int = cast[cint](f)
proc toFlags(v: int): MyFlags = cast[MyFlags](v)


assert toNum({}) == 0
assert toNum({A}) == 1
assert toNum({D}) == 8
assert toNum({A, C}) == 5
assert toFlags(0) == {}
assert toFlags(7) == {A, B, C}                     

type
  IntArray = array[0..5, int]

var
  arr: IntArray

arr = [1, 2, 3, 4, 5, 6]

for i in low(arr) .. high(arr):
  echo arr[i]



type
  BlinkLights = enum
    off, on, slowBlink, mediumBlink, fastBlink
  LevelSetting = array[NORTH..WEST, BlinkLights]

var
  level: LevelSetting

level[NORTH] = on
level[SOUTH] = slowBlink
level[EAST] = fastBlink
echo level

echo low(level)
echo len(level)
echo high(level)

type
  LightTower = array[1..10, LevelSetting]


var
  tower: LightTower

tower[1][NORTH] = slowBlink
tower[1][EAST] = mediumBlink

echo len(tower)
echo len(tower[1])
echo tower

type
  QuickArray = array[6, int]

var
  xarr: IntArray
  yarr: QuickArray

xarr = [1, 2, 3, 4, 5, 6]
yarr = xarr

for i in low(xarr) .. high(xarr):
  echo xarr[i], yarr[i]


echo "Sequences"

var
  xseq: seq[int]

xseq = @[1, 2, 3, 4, 5, 6]

for i, val in xseq:
  echo "Index: ", i, ", value: ", val


proc openArraySize(oa: openArray[string]): int =
  oa.len

var
  fruits: seq[string]
  capitals: array[3, string]

capitals = ["New York", "London", "Berlin"]
fruits.add("Banana")
fruits.add("Mango")

assert openArraySize(fruits) == 2
assert openArraySize(capitals) == 3

proc myWriteln(f: File, a: varargs[string, `$`]) =
  for s in items(a):
    write(f, s)
  write(f, "\n")


myWriteln(stdout, 123, "def", 4.0)

myWriteln(stdout, [$123, "def", $4.0])

var a = "Nim is a programming language"
var b = "Slices are useless."

echo a[7..12]
b[11..^2] = "useful"
echo b

echo "Objects"

type Person = object
  name: string
  age: int

var person1 = Person(name: "Peter", age: 30)

echo person1.name
echo person1.age


var person2 = person1

person2.age += 14

echo person1.age
echo person2.age

let person3 = Person(age: 12, name: "Quentin")
discard person3

let person4 = Person(age: 3)

doAssert person4.name == ""

echo "Tuples"

type Person2 = tuple
  name: string
  age: int

type PersonX = tuple[name: string, age: int]
type PersonY = (string, int)


var p1: Person2
var p2: PersonX
var p3: PersonY

p1 = (name: "Perter", age: 30)
p2 = p1

p3 = ("Poemon", 33)

p1 = p3
p3 = p1

echo p1.name
echo p1.age

echo p1[0]
echo p2[1]

var building: tuple[street: string, number: int]
building = ("Rue del Percebe", 13)
echo building.street
echo building

import std/os

let path = "use/local/nimc.htlm"
let (dir, name, ext) = path.splitFile()
let baddir, badname, badext = splitFile(path)

echo dir
echo name
echo ext

echo baddir
echo badname
echo badext

let aa = [(10, 'a'), (20, 'b'), (30, 'c')]

for (x, c) in aa:
  echo x

for i, (x, c) in aa:
  echo i, c

type Node = ref object
  le, ri: Node
  data: int


var n = Node(data: 9)
echo n.data

proc greet(name: string): string =
  "Hello, " & name & "!"

proc bye(name: string): string =
  "Goodbye, " & name & "!"


proc communicate(greeting: proc(x: string): string, name: string) =
  echo greeting(name)


communicate(greet, "John")
communicate(bye, "Bill")
