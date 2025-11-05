{.push warningAsError[Effect]: on.}
{.experimental: "strictEffects".}
import algorithm


proc p(what: bool) {.raises: [IOError, OSError].} =
    if what: raise newException(IOError, "IO")
    else: raise newException(OSError, "OS")

proc p(): bool {.raises: [].} =
    try:
        # unsageCall()
        result = true
    except:
        result = false

try: 
    p(true)

except IOError:
    echo "IOERORR", getCurrentExceptionMsg()

echo p()


type
    MyInt = distinct int

var toSort = @[MyInt 1, MyInt 2, MyInt 3]

proc cmpN(a, b: MyInt): int =
    cmp(a.int, b.int)

proc harmless {.raises: [].} =
    toSort.sort cmpN

proc cmpE(a, b: MyInt): int {.raises: [Exception].} =
    cmp(a.int, b.int)

proc harmful {.raises: [].} =
    toSort.sort cmpE
