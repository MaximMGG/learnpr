

proc fibonacci(n: int): int =
  if n < 2:
    result = n
  else:
    result = fibonacci(n - 1) + (n - 2).fibonacci


echo fibonacci(7)


proc makeSum(x: int, y: int): int = x + y
proc makeSum(x: var int, y: int) = x += y

echo makeSum(123, 321)
echo 321.makeSum(999)



var a: int = 999
let b: int = 888

a.makeSum(999)
let bb = b.makeSum(999)

echo a
echo bb

echo "Side effect"

proc sum(x, y: int): int {.noSideEffect.} =
  x + y

# proc minus(x, y: int): int {.noSideEffect.} =
#   echo x                        
#   x - y                        

echo "Operators"

proc `$`(a: array[2, array[2, int]]): string =
  result = ""
  for v in a:
    for vx in v:
      result.add($v & ", ")
    result.add("\n")

echo([[1, 2], [3, 4]])


proc `^&*^@%`(a, b: string): string =
  result = a[0] & b[high(b)]


assert("foo" ^&*^@% "bar" == "fr")

echo "Generic Functions"

proc `+`(a, b: string): string =
  a & b

proc `*`[T](a: T, b: int): T =
  result = default(T)
  for i in 0..b-1:
    result = result + a

assert("a" * 10 == "aaaaaaaaaa")
