
var
    a = 100
    b = 1234567890000
    c = 5'i8
    d = 7u16
    e = 0b1111
    f = 0o77
    g = 0xFF

echo a, " of type: ", typeof(a)
echo b, " of type: ", typeof(b)
echo c, " of type: ", typeof(c)
echo d, " of type: ", typeof(d)
echo e, " of type: ", typeof(e)
echo f, " of type: ", typeof(f)
echo g, " of type: ", typeof(g)

var
    mean = 3.0 / 7.9
    x: float = 12
    y = 1.2E3

echo mean, " of type: ", typeof(mean)
echo x, " of type: ", typeof(x)
echo y, " of type: ", typeof(y)


for i in 1..10:
    echo "--"
    for j in 2..9:
        let a = i.float / j.float
        var sum: float
        for k in 1..j:
            sum += a
        echo sum


const eps = 1e-16
if (a == 0 and b == 0) or (a - b).abs / (a.abs + b.abs) < eps:
    echo "aaaaa"


echo "Distinct types"

type Time = distinct float 

proc `$`(self: Time): string {.borrow.}

var t: Time = Time(2.1)

echo "Time: ", t

echo "Subrange types"

type
    Year = range[2020..2025]
    Month = range[1..12]
    Day = range[1..31]

var aay: int = 0
var day: Day = 1

echo "Enumeration types"

type
    TrafficLight = enum
        red, yellow, green

var tl: TrafficLight
tl = green
if tl == red:
    tl = green

echo tl

for el in TrafficLight:
    echo el.ord, ' ', el

type 
    A = array[TrafficLight, string]

var aaa: A
aaa[red] = "Rot"
echo aaa[red]

echo "Sets"

var AlphaNum: set[char] = {'a'..'z', 'A'..'Z', '0'..'9'}

AlphaNum.incl('!')

if '!' in AlphaNum:
    echo "! in ALphaNum"
else:
    echo "! not in AlphaNum"

type
    ChessPos = set[0'i8 .. 63'i8]

type
    ChessSquare = range[0..63]
    ChessSquares = set[ChessSquare]

const baseLine = {0.ChessSquare .. 7.ChessSquare}
const baseLineExplicit: ChessSquares = {0.ChessSquare .. 7.ChessSquare}

assert baseLine == baseLineExplicit

type
    CompLangFlag = enum
        compiled, interpreted, hasGC, isOpenSource, isSelfHosted
    CompLangProg = set[CompLangFlag]

const NimPorp: CompLangProg = {compiled, hasGC, isOpenSource, isSelfHosted}
type
  DialogFlag* {.size: sizeof(cint), pure.} = enum
    modal = 0
    destroyWithParent = 1
    useHeaderBar = 2
  DialogFlags* = set[DialogFlag]

var dialog: DialogFlags = {modal, useHeaderBar}

