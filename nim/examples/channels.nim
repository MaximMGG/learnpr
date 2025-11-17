import std/os, threadpool, strutils

var
  commChan: Channel[string]


proc sendMsg() =
  sleep(500)
  commChan.send("Hi there!")

proc recvMsg() =
  let msg = commChan.recv()
  echo "Received msg: " & msg

commChan.open()
spawn recvMsg()
spawn sendMsg()
sync()


while true:
  let tried = commChan.tryRecv()
  if tried.dataAvailable:
    echo tried.msg


var chan Channel[int]


