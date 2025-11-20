import t3


type
    TestObj1 = object
        name: string
        size: int


proc smaller(a, b: TestObj1): bool =
    a.size < b.size

proc main() =
    var c: MyGenericConteiner[TestObj1]
    var a = TestObj1(name: "Alice", size: 162)
    var b = TestObj1(name: "Bob", size: 184)

    c.add(b, a)
    echo c
    c.sortBy(smaller)
    echo c

main()
