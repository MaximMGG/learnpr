import std/[macros, strformat]



macro myMacro(arg: static[int]): untyped =
  echo arg


myMacro(1 + 2 * 3)

type MyType = object
  a: float
  b: string


macro myMacro2(arg: untyped): untyped =
  var mt: MyType = MyType(a: 123.456, b: "arbsre")
  let mtLit = newLit(mt)

  result = quote do:
    echo `arg`
    echo `mtLit`


myMacro2("Helloe")


macro myAssert(arg: untyped): untyped =
  arg.expectKind nnkInfix
  arg.expectLen 3

  let op = newLit(" " & arg[0].repr & " ")
  let lhs = arg[1]
  let rhs = arg[2]

  result = quote do:
    if not `arg`:
      raise newException(AssertionDefect, $`lhs` & `op` & $`rhs`)


let a = 1
let b = 2

myAssert(a != b)
#myAssert(a == b)

echo fmt"Number {a}"


macro createProcedures() =
  result = newStmtList()

  for i in 0..<10:
    let name = ident("myProc" & $i)
    let content = newLit("I am procedure number #" & $i)

    result.add quote do:
      proc `name`() =
        echo `content`


createProcedures()
myProc7()
