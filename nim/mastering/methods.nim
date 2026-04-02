

type
  Expression = ref object of RootObj

  Literal = ref object of Expression
    x: int

  PlusExpr = ref object of Expression
    a, b: Expression


method eval(e: Expression): int {.base.} =
  raise newException(CatchableError, "Method withou everride")

method eval(e: Literal): int = return e.x

method eval(e: PlusExpr): int =
  result = eval(e.a) + eval(e.b)

proc newLit(x: int): Literal = Literal(x: x)

proc newPlus(a, b: Expression): PlusExpr = PlusExpr(a: a, b: b)

echo eval(newPlus(newPlus(newLit(1), newLit(2)), newLit(4)))
