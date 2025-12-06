import std/json
from std/math import PI

type
  Line = ref object of RootRef
    x1, y1, x2, y2: float

  Circ = ref object of RootRef
    x0, y0: float
    radius: float

  Arc = ref object of Circ
    startAngle, endAngle: float

  Data = object
    elements: seq[RootRef]

  Storage = object
    lines: seq[Line]
    circs: seq[Circ]
    arcs: seq[Arc]


const DataFileName = "MyJsonTest.json"

var
  d1: Data
  storage1, storage2: Storage
  outFile, inFile: File

d1.elements.add(Line(x1: 0, y1: 0, x2: 5, y2: 10))
d1.elements.add(Circ(x0: 7, y0: 3, radius: 20))
d1.elements.add(Line(x1: 3, y1: 2, x2: 7, y2: 9))
d1.elements.add(Arc(x0: 9, y0: 7, radius: 2, startAngle: 0, endAngle: PI))

for el in d1.elements:
  if el of Arc:
    storage1.arcs.add(Arc(el))
  elif el of Circ:
    storage1.circs.add(Circ(el))
  elif el of Line:
    storage1.lines.add(Line(el))
  else:
    assert(false)

let str1 = pretty(%* storage1)

if not open(outFile, DataFileName, fmWrite):
  echo "Could not open file for storing data"
  quit()
outFile.write(str1)
outFile.close()

if not open(inFile, DataFileName, fmRead):
  echo "Coult not open file recoveritng data"
  quit()

let str2 = inFile.readAll()
inFile.close()

storage2 = to(parseJson(str2), Storage)

assert str1 == str2
assert storage1.arcs[0].x0 == storage2.arcs[0].x0
