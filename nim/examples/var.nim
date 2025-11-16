
proc getAlphabet(): string =
    var accm = ""
    for letter in 'a'..'z':
        accm.add(letter)
    return accm

const alphabet = getAlphabet()

var
  a = "foo"
  b = 0
  c: int

let
  d = "foo"
  e = 5
  f: float = 1.0


a.add("foo")
b = 4
c = 123


proc unexpected(): int =
  result += 5


echo a, b, c, d, e, f, alphabet, unexpected()
