import tables

iterator items*(a: string): char {.inline.} =
  var i = 0
  while i < a.len:
    yield a[i]
    i += 1

for ch in items("Hello world"):
  echo ch


for x in [1, 2, 3]: echo x

for x in items([1, 2, 3]): echo x

var tab = initTable[string, int]()

tab["aaa"] = 1

template foreach() =
  for key, val in tab:
    echo(key, val)


foreach()


iterator count0(): int {.closure.} =
    yield 0

iterator count2(): int {.closure.} =
    var x = 1
    yield x
    inc x
    yield x

proc invoke(iter: iterator(): int {.closure.}) =
    for x in iter(): echo x
    
invoke(count0)
invoke(count2)


echo "simple tasking\n"


type
    Task = iterator (ticker: int)

iterator a1(ticker: int) {.closure.} =
    echo "a1: A"
    yield
    echo "a1: B"
    yield
    echo "a1: C"
    yield
    echo "a1: D"
    yield

iterator a2(ticker: int) {.closure} =
    echo "a2: A"
    yield
    echo "a2: B"
    yield
    echo "a2: C"
    yield

proc runTasks(t: varargs[Task]) =
    var ticker = 0
    while true:
        let x = t[ticker mod t.len]
        if finished(x): break
        x(ticker)
        inc ticker

runTasks(a1, a2)

iterator mycount(a, b: int): int {.closure.} =
    var i = a
    while i <= b:
        yield i
        inc i

var c = mycount
while not finished(c):
    echo c(1, 3)

proc mycount2(a, b: int): iterator (): int =
    result = iterator(): int =
        var x = a
        while x <= b:
            yield x
            inc x

let foo = mycount2(1, 4)

for f in foo():
    echo f
