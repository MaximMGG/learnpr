

proc superSum(): uint64 = 
  for i in low(int32)..<high(int32):
    result += uint64(i)


let sum: uint64 = superSum()

echo "sum is: ", sum
