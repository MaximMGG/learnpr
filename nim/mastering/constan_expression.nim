func createFactTable[N: static[int]]: array[N, int] = 
    result[0] = 1
    for i in 1..<N:
        result[i] = result[i - 1] * i



func fact(n: int): int =
    runnableExamples:
        doAssert fact(0) == 1
        doAssert fact(4) == 24
        doAssert fact(10) == 3628800

    const factTable =
        when sizeof(int) == 2:
            createFactTable[5]()
        elif sizeof(int) == 4:
            createFactTable[13](0)
        else:
            createFactTable[21]()

    assert(n >= 0, $n & " must not be negative.")
    assert(n < factTable.len, $n & " is too large to look up in the table.")
    factTable[n]


const a = static createFactTable[10]()
const f = fact(20)

echo a
echo f
