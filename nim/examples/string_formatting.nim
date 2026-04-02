import std/strutils, std/strformat

echo "$1 $2" % ["Hello", "world"]
echo "$# $#" % ["Hello", "world"]
echo "$first $second" % ["first", "hello", "second", "world"]

echo "Hello, my name is: $1, I am $2 years old!" % ["Mickle", $33]


let
  h = "hello"
  w = "world"


var num: int = 123
echo fmt"{h} {w}"

echo &"{h} {w}"

echo &"This is {num} number"
num += 1

echo &"This is {num} number"


proc printDirName(s: string) =
  let newName = "test"
  echo &"{s}/{newName}"

printDirName("experimenta/newlang")

let n = 42

echo &"hello {n}"

assert $n == "42"
echo "hello " & $n
echo "Hello $1" % [$n]


type Fruit = object
  name: string
  color: string


proc `$`(self: Fruit): string =
  &"Fruit({self.name}, {self.color})"

let apple = Fruit(name: "apple", color: "Red")

echo apple

echo "hello " & $apple

echo &"Hello {apple}"

echo &"Hello {$apple}"
