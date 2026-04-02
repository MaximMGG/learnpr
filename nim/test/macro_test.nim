import std/macros

macro debug(args: varargs[untyped]): untyped =
    result = nnkStmtList.newTree()
    for n in args:
        result.add(newCall("write", newIdentNode("stdout"), newLit(n.repr)))
        result.add(newCall("write", newIdentNode("stdout"), newLit(": ")))
        result.add(newCall("writeLine", newIdentNode("stdout"), n))


proc printText(): string =
    "Super test"

var a: array[0..10, int]
var x = "Some string"

a[0] = 42
a[1] = 45

debug(a[0], a[1], x, printText())

macro enumerate(x: ForLoopStmt): untyped =
  expectKind x, nnkForStmt

  var countStart = if x[^2].len == 2: newLit(0) else: x[^2][1]
  result = newStmtList()

  result.add newVarStmt(x[0], countStart)
  var body = x[^1]
  if body.kind == nnkStmtList:
    body = newTree(nnkStmtList, body)
    body.add newCall(bindSym"inc", x[0])
    var newFor = newTree(nnkForStmt)
    for i in 1..x.len-3:
      newFor.add x[i]

    newFor.add(x[^2][^1])
    newFor.add body
    result.add newFor

    result = quote do:
        block: `result`


for a, b in enumerate(items([1, 2, 3])):
  echo a, " ", b

for a, b in enumerate(10, [1, 2, 3, 5]):
  echo a, " ", b
