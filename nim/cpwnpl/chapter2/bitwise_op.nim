from std/strutils import toBin

var i = 1.int8

i = i shl 7
i = i shr 2
echo i.toBin(8)
var j: uint8 = 0b11111111
j = j shr 2
echo j.int8.toBin(8)

var a = 3
var b = a and 2
b = a and 4
b = a or (4 + 8)
echo b.toBin(8)
