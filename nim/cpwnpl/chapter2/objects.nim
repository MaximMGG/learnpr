import std/with

type
    Computer = object
        manufacturer: string = "bananas"
        cpu: string
        powerConsumption: float
        ram: int
        ssd: int
        quantity: int
        price: float

var computer: Computer

with computer:
    manufacturer = "bananas"
    cpu = "x7"
    powerConsumption = 17
    ram = 32
    ssd = 1024
    quantity = 3
    price = 499.99

var computer2: Computer = Computer()

echo computer
echo computer2

echo "Arrays"

var
    a: array[8, int]
    v = 1

for el in mitems(a):
    el = v
    inc v

for el in mitems(a):
    el = el * el

for i, square in a:
    echo i + 1, " - ", square

echo "seq"

var
    s: seq[int]
    n = 0

while n < 8:
    inc(n)
    add(s, n)

for el in mitems(s):
    el = el * el

for i, square in s:
    echo i + 1, " - ", square

    
var ss: seq[int] = newSeq[int](8)

var i2: int
while i2 < 8:
    ss[i2] = i2 * i2
    inc(i2)

for i, square in ss:
    echo i + 1, " - ", square
