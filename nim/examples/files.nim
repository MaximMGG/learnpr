
let entireFile = readFile("kittens.txt")
#const constFile = staticread("kittens.txt")

echo entireFile
#pecho constFile


proc readKittens() =
  let f = open("kittens.txt")
  defer: f.close()

  f.setFilePos(0, fspEnd)
  let file_size = f.getFilePos()
  f.setFilePos(0, fspSet)

  echo "File size: ", file_size

  let firstLine = f.readLine()
  echo "first kitten: ", firstLine

proc readAllKittens() =
  let f = open("kittens.txt")
  defer: f.close()

  while not f.endOfFile():
    echo f.readLine()
  

proc addKittens(name: string) =
  let f = open("kittens.txt", fmAppend)
  defer: f.close()
  f.setFilePos(0, fspEnd)
  f.write(name & "\n")

  
readKittens()
addKittens("Mishayskas")
readAllKittens()
