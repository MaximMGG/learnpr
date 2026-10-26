proc sumTillNegative(x: varargs[int]): int =
  for i in x:
    if i < 0:
      return
    result = result + i



proc yes(question: string): bool =
  echo question, " (y/n)"
  while true:
    case readLine(stdin):
    of "y", "Y", "yes", "Yes": return true
    of "n", "N", "no", "No": return false
    else: echo "Enter only yes or no"


if yes("Do you like dogs?"):
  echo "Yes he likes dogs"
else:
  echo "No he doesn't like dogs"



proc printSeq(s: seq, nprinted: int = -1) =
  var nprinted = if nprinted == -1: s.len else: min(nprinted, s.len)
  for i in 0..<nprinted:
    echo s[i]


echo sumTillNegative(3, 9, -1, 2)
printSeq(@[3, 3, 4, 9], -1)
var a: seq[int]
a.insert(123)
echo a


proc divmod(a, b: int, res, remainder: var int) =
  res = a div b
  remainder = a mod b


var x, y: int

divmod(8, 5, x, y)
echo x, " ", y



proc pup(x, y: int): int {.discardable.} =
  return x + y


pup(3, 8)
