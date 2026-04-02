import std/[sequtils, sugar]

proc primeFilter(x: int): bool =
    x in {3, 5, 7, 13}

proc square(x: int): int = x * x

var s = (0 .. 9).toSeq

echo s.filter(primeFilter)
echo s.filter(proc(x: int): bool = (x and 1) == 0)
echo s.filter(x => (x and 1) == 0)

echo s.map(proc(x: int): int = x * x)
echo s.map(x => x * x)
echo s.map(x => square(x)).map(x => x * x + 2)
