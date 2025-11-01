

proc len[T](a: openArray[T]): int = a.len()
proc len(s: string): int = s.len()

proc main =
    echo "Main proc"
    var x = @[1, 2, 3]
    var s = "Hello"
    echo len(x)
    echo len(s)
    



main()

