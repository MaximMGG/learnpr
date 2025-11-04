import strutils

type
    A = object of RootObj
        name: string
    B = object of A
        id: int

proc seyName(a: A) =
    echo a.name

converter toB(a: A): B =
    return B(name: a.name, id: 0)


var b = B(name: "Bill", id: 12)
var a = A(name: "John")

var bb = a.toB()

b.seyName()
a.seyName()
bb.seyName()



