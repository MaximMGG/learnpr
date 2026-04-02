
var
  a = @[1, 2 ,3]
  b = newSeq[int](3)

for i, v in a:
  b[i] = v * v

for i in 4..100:
  b.add(i * i)


b.delete(0)

b = a[0] & b

echo b

let c = @[1, 2, 3]

var d = @[1, 2, 3]
d.add(4)

echo c, " ", d

proc doSomething(mySeq: var seq[int]) =
  mySeq[0] = 2


var testSeq = @[1, 2, 3]

doSomething(testSeq)

echo "testSeq: ", testSeq
