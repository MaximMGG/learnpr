import sequtils, sugar


let powersOfTwo = @[1, 2, 4, 8, 16, 32, 64, 128, 256]

echo(powersOfTwo.filter do (x: int) -> bool: x > 32)
echo powersOfTwo.filter(proc (x: int): bool = x > 32)

proc greaterThan32(x: int): bool = x > 32

echo powersOfTwo.filter(greaterThan32)



let cats: seq[string] = @["Cattin", "bighs", "Jasting", "MArry", "Missy", "Bally"]


echo (cats.filter do (x: string) -> bool: x[1] == 'a')


let arr: array[5, int] = [1, 2, 3, 4, 5]


var arr_seq: seq[int] = arr[0..4]

arr_seq.add(7)

echo repr(arr_seq)

echo repr(arr.filter do (x: int) -> bool: x mod 2 == 1)


proc map(str: string, fun: (char) -> char): string =
  for c in str:
    result &= fun(c)


echo "abc".map((c) => char(ord(c) + 1))

echo "foo".map(proc (c: char): char = char(ord(c) + 1))
