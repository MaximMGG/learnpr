import std/sequtils, std/random

proc main() =
    var a: array[4, uint64]
    echo sizeof(a)
    a[0] = 7
    echo a[0]
    echo cast[int](addr a)
    echo cast[int](addr a[0])


    var a2 = a
    a[0] = 3
    echo a2
    echo cast[int](addr a2[0])



proc main2() =
    var dummy: int
    var s: seq[int64]

    echo sizeof(seq)
    echo sizeof(s)
    s.add(7)
    echo s[0]
    echo cast[int](addr dummy)
    echo cast[int](addr s)
    echo cast[int](addr s[0])

    var s2 = s
    s[0] = 3
    echo s2[0]
    echo cast[int](addr s2[0])



proc main3() =
    var
        s: seq[int64] = newSeqOfCap[int64](4)
        s2: seq[int64]
        p: ptr int

    var h = cast[ptr int](addr s2)
    
    echo cast[int](h)
    echo h[]
    echo ""

    for i in 0..8:
        s.add(i)
        echo cast[int](addr s[0])
        p = cast[ptr int](cast[int](addr s[0]) - 8)
        echo p[]
        p = cast[ptr int](cast [int](addr s[0]) - 16)
        echo p[]


proc main4() =
    const 
        Rows = 8
        Cols = 8

    type
        Fig = int8
        Col = array[Rows, Fig]
        Board = array[Cols, Col]

    var b: Board

    const
        a = 0
        rook = 5

    b[a][0] = rook
    echo b[a][0]

    template `[]`(b: Board, i, j: int): int8 = 
        b[i][j]

    template `[]=`(b: var Board, i, j: int; v: int8) =
        b[i][j] = v
    
    b[a, 0] = rook + 1
    echo b[a, 0]


proc main5() =
    type
        T1 = array[4, seq[int]]
        T2 = seq[array[2, int]]
        T3 = seq[seq[int]]

    var t1: T1
    t1[0] = @[1, 2, 3]
    t1[1].add(7)
    echo t1[0][0]
    echo t1[1][0]

    var t2: T2
    t2.add([1, 2])
    echo t2[0]

    var t2x = newSeq[array[2, int]](10)
    t2x[7] = [5, 6]
    echo t2x[7]

    var t3: T3
    t3.add(@[1, 2, 3])
    t3.add(newSeq[int](1))
    t3[1][0] = 19
    for row in t3:
        echo row


proc main6() =
    var seq2D = newSeqWith(5, newSeq[bool](3))
    assert seq2D.len == 5
    assert seq2D[0].len == 3
    assert seq2D[4][2] == false

    var seqRand = newSeqWith(20, rand(1.0))
    assert seqRand[0] != seqRand[1]

type
    HSlice*[T, U] = object
        a*: T
        b*: U
    Slice*[T] = HSlice[T, T]


proc contains*[U, V, W](s: HSlice[U, V], value: W): bool {.noSideEffect,
inline.} =
    result = s.a <= value and value <= s.b

proc main7() =
    var m = "Nim programming is difficult."
    m[19 .. 18] = "not easy."

    echo m

    echo "Indeed " & m[0..18] & "is much fun!"
    var s = HSlice[int, int](a: 0, b: 18)
    echo "Indeed " & m[0 .. 18] & "is much fun!"


type
    O = object
        i: int

proc main8() =
    var
        s = newSeq[O](1000000)
    for i in 0 .. (1000000 - 1):
        s[i] = O(i: i)

    var sum = 0
    for x in s[1 .. ^1]:
        sum += x.i

    echo sum


proc main9() =
    var arr: array[5, int]
    var i: int = 1
    for x in mitems(arr):
        x = i
        inc i

    echo cast[int](addr arr[0])

    var p_x: ptr int = cast[ptr int](addr arr[0])
    echo cast[int](p_x)
    echo p_x[]
    var p_i: int = cast[int](p_x)
    p_i += 8
    echo p_i
    var p_x2: ptr int = cast[ptr int](p_i)
    echo cast[ptr int](p_i)[]
    echo p_x2[]
    echo cast[ptr int](p_i + 8)[] 
    echo cast[ptr int](p_i + 16)[] 
    echo cast[ptr int](p_i + 24)[] 
    echo cast[ptr int](p_i + 32)[] 

main()
echo "main2()"
main2()
echo "main3()"
main3()
echo "main4()"
main4()
echo "main5()"
main5()
echo "main6()"
main6()
echo "main7()"
main7()
echo "main8()"
main8()
echo "main9()"
main9()
