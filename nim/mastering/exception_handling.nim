from std/strutils import parseInt
import posix

var 
    f: File

if open(f, "number.txt"):
    try:
        var a = readLine(f)
        var b = readLine(f)
        echo "sum: " & $(parseInt(a) + parseInt(b))
    except OverflowDefect:
        echo "overflow!"
    except ValueError, IOError:
        echo getCurrentExceptionMsg()
        echo "catch multiple exceptions!"
    except:
        echo "Unknown exception!"
    finally:
        close(f)

let x = try: parseInt("133a")
        except: -1
        finally: echo "hi"

echo x
        
proc main =
    var f = open("number.txt", fmWrite)
    defer: f.close()
    f.write "abc"
    f.write "def"

main()

template safeOpenDefer(f, path) =
    var f = open(path, fmWrite)
    defer: close(f)

template safeOpenFinally(f, path, body) =
    var f = open(path, fmWrite)
    try: body
    finally: close(f)

block:
    safeOpenDefer(f, "/tmp/z01.txt")
    f.write "abc"
block:
    safeOpenFinally(f, "/tmp/z01.txt"):
        f.write "abc"

block:
    var f = open("/tmp/z01.txt", fmWrite)
    try:
        f.write "abc"
    finally: close(f)

block:
    var fi = open("types.nim", fmRead)
    defer: fi.close()
    var stat: posix.Stat
    discard posix.stat("types.nim", stat)
    var buf = alloc(stat.st_size)
    var read_bytes = fi.readBuffer(buf, stat.st_size)
    echo read_bytes
    echo cast[cstring](buf)
    echo "read from buf end"

    fi.setFilePos(0, SEEK_SET)
    var i: int = 1
    while not fi.endOfFile():
        echo i, " - ", fi.readLine()
        inc i


