from std/sugar import dup

var
    number: int = 7
    p: pointer
    ip: ptr int

echo cast[int](p)
echo cast[int](ip)
p = addr(number)
ip = addr(number)
echo cast[int](p)
echo cast[int](ip)


proc main() =
    var
        a: array[8, int] = [0, 1, 2, 3, 4, 5, 6, 7]
        sum = 0
    var p: ptr int = addr(a[0])
    for i in a.low .. a.high:
        echo p[]
        sum += p[]
        echo cast[int](p)
        var h = cast[int](p); h += sizeof(a[0]); p = cast[ptr int](h)

    echo sum
    echo typeof(sizeof(a[0]))

proc main2() =
    var ip: ptr int
    ip = create(int)
    ip[] = 13
    echo ip[] * 3
    var ip2: ptr int
    ip2 = ip
    echo ip2[] * 3
    dealloc(ip)

proc main3() =
    var ip: ref int
    new(ip)
    echo ip[]
    ip[] = 13
    echo ip[] * 3
    var ip2: ref int
    ip2 = ip
    echo ip[] * 3

type
    Friend = ref object
        name: string
        next: Friend

proc main4() =
    var
        f: Friend
        n: string

    while true:
        write(stdout, "Name of friend: ")
        var n = readline(stdin)
        if n == "" or n == "quit":
            break
        var node: Friend
        new(node)
        node.name = n
        node.next = f
        f = node

    var ff = f
    while ff != nil:
        echo ff.name
        ff = ff.next

    var f1 = f
    while f1 != nil:
        n = readline(stdin)
        if n == "" or n == "quit":
            break
        if f1.name == n:
            f1 = f1.next
        else:
            while f1.next != nil:
                if f1.next.name == n:
                    f1.next = f1.next.next
                    break
                f1 = f1.next
                    

type
    RO = ref object
        i: int

proc main5() =
    var
        ro1 = RO(i: 1)
        ro2 = RO(i: 1)
        ro3 = ro1

    echo ro1 == ro2
    echo ro1[] == ro2[]
    echo ro1 == ro3


proc frame(s: string, c: char = '*'): string =
    var res = newString(s.len + 4)
    res[0] = c
    res[1] = ' '
    res[2 .. s.high + 2] = s
    res[^2] = ' '
    res[^1] = c
    return res

proc framed(s: var string, c: char = '*') =
    var cs = newString(2)
    cs[0] = c
    cs[1] = ' '
    s.insert(cs)
    s.add(' ')
    s.add(c)

main()
echo "main2"
main2()
echo "main3"
main3()
echo "main4"
main4()
echo "main5"
main5()
echo "frame"
echo frame("Hello World")
echo frame("Hello World", '#')
echo "Hello world".dup(framed)
echo "Hello world".dup(framed, framed)
echo "Hello world".dup(framed('#'))

