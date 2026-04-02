import asyncdispatch


proc ioManager(id: string) {.async.} =
  for i in 1..10:
    await sleepAsync(10)
    echo id & " - run: " & $i


let
  ma = ioManager("a")
  mb = ioManager("b")

waitFor ma and mb
