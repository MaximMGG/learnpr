
iterator strIt(s: string): char =
    var i = 0
    while i < s.len():
        yield s[i]
        inc(i)

const s = "Hello world!"

for c in strIt(s):
    echo c

