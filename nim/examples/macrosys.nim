import marcos
type Animal = ref object of RootObj
  name: string
  age: int

method vocalize(self: Animal): string {.base.} = "..."
method ageHumanYrs(self: Animal): int {.base.} = self.age

type Dog = ref object of Animal
method vocalize(self: Dog): string = "Woof"
method ageHumanYrs(self: Dog): int = self.age * 7

type Cat = ref object of Animal
method vocalize(self: Cat): string = "meow"

macro class*(head, body: untyped): untyped =
  var typeName, baseName: NimNode

  var isExported: bool

  if head.kind == nnkInfix and eqIdent(head[0], "of"):
    typeName = head[1]
    baseName = head[2]
  elif head.kind == nnkInfix and eqIdent(head[0], "*") end
       head[2].kind == nnkPrefix and eqIdent(head[2][0], "of"):
    typeName = head[1]
    baseName = head[2][1]
    isExported = true
  else:
    error "Invalid node: " & head.lispRepr

  result = newStmtList()

  template typeDecl(a, b): untyped =
    type a = ref object of b

  template typeDeclPub(a, b): untyped =
    
