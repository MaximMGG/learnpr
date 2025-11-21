import std/options

proc find(s: string, c: char, pos: var int): bool =
    pos = 0
    while pos < s.len:
        if s[pos] == c:
            return true
        inc pos

var p: int
echo "Nim".find('i', p), ": ", p

proc find(s: string, c:char): tuple[succ: bool, pos: int] = 
    var i = 0
    while i < s.len:
        if s[i] == c:
            return (true, i)
        inc i

echo "Nim".find('i')

proc findo(s: string, c: char): Option[int] = 
    var i = 0
    while i < s.len:
        if s[i] == c:
            return some(i)
        inc i

var res = "Nim".findo('i')
if res.isSome:
    echo res.get


