


iterator `..`[T, U](a: T, b: U): U =
    var i = U(a)
    while i <= b
        yield i
        inc i

type Point[T] = object
    x, y: T

iterator items[T](s: seq[T]): T =
    for i in 0..<s.len:
        yield s[i]


for x in items(@[1, 2, 3]): discard
for x in items(@["ijij", "kdjfsl", "ooooo"]):
    echo x

var p = Point[float](x: 123.3, y: 11)
echo p
