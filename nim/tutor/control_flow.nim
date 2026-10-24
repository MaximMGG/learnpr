
from strutils import parseInt


proc main() =
  echo "Tell me instruction"

  # let instruction = readLine(stdin)
  let instruction = ""
  # if instruction == "":
  #   echo "You didn't gave any instruction try agane"
  # elif instruction == "sleep":
  #   echo "Going to sleep"
  # else:
  #   echo "Do another instruction"
  case instruction:
  of "":
    echo "You didn't gave any instruction"
  of "sleep":
    echo "Going to sleep"
  else:
    echo "Do another instruction"


  echo "Give me a number please"

  # let n = parseInt(readLine(stdin))
  let n = 1
  case n:
  of 0..4, 8..10:
    echo "0..4, 8..10"
  of 5, 12:
    echo "5, 12"
  else: discard #this means do nothing here
  # else:
  #   echo n


  echo "for i  in countup(0, 9)"
  for i in countup(0, 9):
    echo i


  echo "while i < 10:"
  var i = 0
  while i < 10:
    echo i
    # i.inc
    inc i

  echo "0 .. 9"
  for i in 0..9:
    echo i

  echo "for i in countdown(9, 0)"
  for i in countdown(9, 0):
    echo i

  let s = "some string"

  echo "for i in 0..<s.len:"
  for i in 0..<s.len:
    echo s[i]

  echo "for i in s[0..^1]:"
  for i in s[0..^1]:
    echo i


  let col = ["a", "b", "c", "d"]

  echo "for index, item in col.pairs:"
  for index, item in col.pairs:
    echo item, " at index ", index
  
  when system.hostOS == "linux":
    echo "Yeah is linux"

  echo system.hostCPU

main()

