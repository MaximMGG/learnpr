import std/net

proc connect_test() =
  let socket = newSocket()
  let ctx = newContext()
  wrapSocket(ctx, socket)
  socket.connect("google.com", Port(443))
 
connect_test()
