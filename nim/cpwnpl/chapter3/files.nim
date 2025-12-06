from std/os import fileExists


proc main() =
  const FN = "NoImportantData"
  if os.fileExists(FN):
    echo "File exists, we may overwrite important data"
    return
  var f: File = open(FN, fmWrite)
  f.write("Hello ")
  f.writeLine("World!")
  f.writeLine(3.1415)
  f.close()


proc read_file() =
  var f: File
  try:
    f = open("NoImportantData", fmRead)
    echo f.readLine
    echo f.readLine
  finally:
    if f != nil:
      f.close()

proc read_file_agane() =
  var f: File
  f = open("NoImportantData", fmRead)
  for str in f.lines:
    echo str
  f.setFilepos(0)
  var s: string
  while f.readLine(s):
    echo s
  f.close()


proc write_binnary() =
  var f: File
  f = open("NoImportantData", fmWrite)
  var i: int = 123
  var x: float = 3.1415
  assert f.writeBuffer(addr(x), sizeof(x)) == sizeof(x)
  assert f.writeBuffer(addr(i), sizeof(i)) == sizeof(i)
  f.close
  f = open("NoImportantData", fmRead)
  assert f.readBuffer(addr(x), sizeof(x)) == sizeof(x)
  assert f.readBuffer(addr(i), sizeof(i)) == sizeof(i)
  f.close()
  echo i, " ", x


main()
read_file()
read_file_agane()

var sq = readLines("NoImportantData", 2)
echo sq

write_binnary()
