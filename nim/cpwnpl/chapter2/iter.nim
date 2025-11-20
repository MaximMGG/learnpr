import std/strutils, std/sequtils, std/sugar

iterator decDigits(s: string): char =
    var pos = 0
    while pos < s.len:
        if s[pos] in {'0' .. '9'}:
            yield s[pos]
        inc pos

for d in decDigits("asidjf81kfm119f10"):
    stdout.write(d)
stdout.write('\n')

var s: string = "2liw9foiw7e77j1f0"
echo s.toSeq().filter(x => x in {'0'..'9'})

var a: string = s.toSeq().filter(x => x in {'0'..'9'}).substr()
echo a

iterator items(s: string): char =
    var i = 0
    while i < s.len:
        yield s[i]
        inc i

iterator pairs(s: string): tuple[key: int, val: char] =
    var i = 0
    while i < s.len:
        yield (i, s[i])
        inc i

iterator mitems(s: var string): var char =
    var i = 0
    while i < s.len:
        yield s[i]
        inc i
iterator mpairs(s: var string): tuple[key: int, val: var char] =
    var i = 0
    while i < s.len:
        yield (i, s[i])
        inc i

var str = "Nim is nice."
for c in items(str):
    stdout.write(c, '*')
    
echo ""
for i, c in pairs(str):
    echo i, ": ", c


var s2 = "NIM"
for i, c in mpairs(s2):
    if i > 0:
        c = toLowerAscii(c)

echo s2

iterator myCounter(a, b: int): int {.closure.} =
    var i = a
    while i < b:
        yield i
        inc i

for x in myCounter(3, 5):
    echo x
echo "---"

var counter = myCounter

while true:
    var v =  counter(3, 5)
    if counter.finished:
        break
    echo v

proc mucount(a, b: int): iterator(): int =
    result = iterator(): int = 
        var i = a
        while i < b:
            yield i
            inc i


var muc = mucount(2, 5)
for i in muc():
    echo i

echo "==="

var muc2 = mucount(2, 8)

while true:
    var v = muc2()
    if muc2.finished:
        break
    echo v


