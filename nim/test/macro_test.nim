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



