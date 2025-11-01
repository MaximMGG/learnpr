

type Point = object
    x: int
    y: int

iterator `..<`(a, b: int): int = 
    var i = a
    while i < b:
        yield i
        inc(i)
        
iterator items(s: seq[Point]): Point =  
    for i in 0 ..< s.len:
        yield s[i]


for i in 0 ..< 3:
    echo i, " - ", $i


var p = @[Point(x: 1, y: 2), Point(x: 2, y: 3)]


for i in items(p):
    echo i


proc find(haystack: string, needle: char): int =
    for i in 0 ..< haystack.len:
        if haystack[i] == needle:
            return i
        
    return -1


iterator findAll(haystack: string, needle: char): int =
    for i in 0 ..< haystack.len:
        if haystack[i] == needle:
            yield i

let s = "Kavabunga!!!@"
echo find(s, 'v')


for i in findAll(s, 'a'):
    echo i





