
type
  CustomRange = object
    low: int
    high: int


iterator items(range: CustomRange): int =
  var i = range.low
  while i <= range.high:
    yield i
    inc i


iterator pairs(range: CustomRange): tuple[a: int, b: char] =
  for i in range:
    yield (i, char(i + ord('a')))
    
for i, c in CustomRange(low: 1, high: 3):
  echo i, " - ", c


iterator `...`*[T](a: T, b: T): T =
  var res: T = a
  while res <= b:
    yield res
    res.inc



for i in 0...5:
  echo i

iterator countTo(n: int): int =
  var i = 0
  while i < n:
    yield i
    inc i

for i in countTo(5):
  echo i


echo "Closure Iteratros"

proc countTo(n: int): iterator(): int =
  return iterator() :int =
           var i = 0
           while i <= n:
             yield i
             inc i

let countto20 = countTo(20)

echo countTo20()


var output = ""

while true:
  let next = countto20()

  if finished(countTo20):
    break

  output.add($next & " ")

echo output

output = ""

let countTo9 = countTo(9)

for i in countTo9():
  output.add($i)

echo output
