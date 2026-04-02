

type
    Socket* = ref object of RootObj
        host: int

proc `host=`*(s: var Socket, value: int) {.inline.} =
    s.host = value

proc getHost*(s: Socket): int {.inline} = s.host
