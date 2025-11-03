# import strutils, math
import sequtils
import algorithm as algo


proc foo(inp: int, outp: var int) =
    outp += inp + 47;

var x: int = 1
var y: int = 8

foo x, y

echo y



proc toLower(c: char): char =
    if c in {'A'..'Z'}:
        result = chr(ord(c) + (ord('a') - ord('A')))
    else:
        result = c

proc toLower(s: string): string =
    result = newString(s.len)
    for i in 0..<s.len:
        result[i] = toLower(s[i])


var s = "OIDFJoIJdIFJoijDkJF(*(*!FIJKd))"

echo toLower(s)


proc callme(x, y: int, s: string = "", c: char, b: bool = false) = discard


callme(0, 1, "abc", '\t', true)
callme(x=1, y=0, "abd", '\t')
callme(c = '\t', y=1, x=0)
callme 0, 1, "abc", '\t'


# proc `$`(x: int): string = discard
#     #result = intToStr(x)

proc `*+`(a, b, c: int): int =
    result = a * b + c

assert `*+`(3, 4, 6) == `+`(`*`(3, 4), 6)

proc toUpper(c: char): char =
    if c in {'a'..'z'}:
        result = chr(ord(c) - (ord('a') - ord('A')))
    else:
        result = c

proc toUpper(s: string): string =
    result = newString(s.len)
    for i in 0..<s.len:
        result[i] = toUpper(s[i])


echo "abc".len
echo "abc".toUpper
echo toUpper("oaijsodif")
echo {'a', 'b', 'c'}.card
stdout.write("\tHello\n")


echo "Properties"

# type
#     Socket* = ref object of RootObj
#         host: int
#
# proc `host=`(s: var Socket, value: int) {.inline.} = 
#         s.host = value


echo "Indexing\n\n\n"


type
    Matrix* = object
        data: ptr UncheckedArray[float]
        m*, n*: int

proc `[]`*(m: Matrix, i, j: int): float {.inline.} =
    m.data[i * m.n + j]

proc `[]`*(m: var Matrix, i, j: int): float {.inline.} =
    m.data[i * m.n + j]

proc `[]=`*(m: var Matrix, i, j: int, s: float) =
    m.data[i * m.n + j] = s


echo "Closure\n\n\n"

proc outer =
    var i = 0

    proc mutate =
        inc i

    mutate()
    echo i

outer()


var later: seq[proc ()] = @[]

for i in 1..2:
    later.add(proc () = echo i)

for x in later: 
    x()

var later2: seq[proc ()] = @[]

for i in 1..2:
    (proc = 
        let j = i
        later2.add proc() = echo j)()

for x in later2:
    x()

echo "Anonymous procs\n\n\n"

var cities = @["Frankfurt", "Tokyo", "New Youk", "Kyiv"]

cities.sort(proc (x, y: string): int = cmp(x.len, y.len))

echo repr(cities)





