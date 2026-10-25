import strutils

proc main() =
  var f = readFile("./total.txt")
  let s = strip(f)
  let total = parseInt(s)
  var sum: uint64
  for i in 0..<total:
    sum += uint64(i) * 2 + uint64(float(3))
  
  echo "Sum is: ", sum


main()
