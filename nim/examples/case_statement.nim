

case "charlie":
  of "alfa":
    echo "A"
  of "bravo":
    echo "B"
  of "charlie":
    echo "C"
  else:
    echo "Unrecognized letter"


case 'h':
  of 'a', 'e', 'i', 'o', 'u':
    echo "Vowel"
  of '\127', '\255':
    echo "Unknown"
  else:
    echo "Consonant"


proc positiveOrNegative(num: int): string =
  result = case num:
            of low(int).. -1:
               "negative"
            of 0:
              "zero"
            of 1..high(int):
              "positive"
            else:
              "impossible"


echo positiveOrNegative(-1)
echo "low int is: ", low(int)
echo "high int is: ", high(int)
echo "low int32 is: ", low(int32)
echo "high int32 is: ", high(int32)
echo "low uint32 is: ", low(uint32)
echo "high uint32 is: ", high(uint32)


var sum: uint64
for i in low(int32)..<high(int32):
  sum += uint64(i)

echo "sum is: ", sum
  
