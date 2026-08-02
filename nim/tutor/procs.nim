

proc foo(x, y: int): int {.discardable.}=
  return x + y

proc divmod(a, b: int, res, remainder: var int) =
  res = a div b
  remainder = a mod b


# proc printSeq(s: seq, nprinted: int = -1) =
#   var nprinted = if nprinted == -1: s.len else: min(nprinted, s.len)
#   for i in 0 ..< nprinted:
#     echo s[i]

proc sumTillNegavive(x: varargs[int]): int =
  for i in x:
    if i < 0:
      return
    result = result + i


proc yes(question: string): bool =
  echo question, " (y/n)"
  while true:
    case readLine(stdin)
    of "y", "Y", "yes", "Yes": return true
    of "n", "N", "No", "no": return false
    else: echo "Plase be clear: yes or no"



if yes("Should I delte all your important files?"):
  echo "I'm sorry Dave, I'm afraid I can't do that."
else:
  echo "I think you know what the problem is just as well is I do."



echo sumTillNegavive()
echo sumTillNegavive(3, 4, 5)
echo sumTillNegavive(3, 4, -1, 6)


echo "divmod"
var 
  x, y: int
divmod(8, 5, x, y)
echo x
echo y

foo(8, 8)

if `==`(`+`(2, 8), 10):
  echo "2 + 8 == 10"

# echo printSeq(@[1, 2, 3], 3)


