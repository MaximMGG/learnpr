import std/strutils

proc charToInt(c: char): int =
    if c in {'0'..'9'}:
        result = ord(c) - ord('0')
    raise newException(OSError, "parse error")


# proc main() = 
#     var i: int = 1
#     while i > 0:
#         stdout.write("Please enter a single decimal integer: ")
#         let s = stdin.readline()
#         try:
#             echo "Fine, the number is: ", charToInt(s[0])
#         except:
#             if s.len == 0:
#                 break
#             echo "Try agane"
#         dec i
#
# main()

var
    f: File

if f.open("numbers.txt"):
    try:
        let a = f.readline
        let b = f.readline
        echo "sum: ", parseInt(a) + parseInt(b)
    except OverflowDefect:
        echo "overflow"
    except ValueError as e:
        echo "value or IO error ", e.msg, " {", e.name, "}"
    except:
        echo "Unknown exception!"
    finally:
        f.close()


let x = try: parseFloat("3.14")
            except: NaN
            finally: echo "well we tried."

echo x
let i = (try: parseInt("133a") except: -1)
echo i


proc main = 
    var f = open("numbers.txt", fmWrite)
    defer: f.close()
    f.write("abc")
    f.write("def")

main()


