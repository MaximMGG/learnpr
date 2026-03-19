package net_test


import "core:fmt"
import "core:net"

main :: proc() {
  endpoint := net.Endpoint{port = 8080, address = net.IP4_Address{127, 0, 0, 1}}
  sock, sock_err := net.listen_tcp(endpoint, 10)
  defer net.close(sock)
  if sock_err != nil {
    fmt.eprintln("listen_tcp error:", sock_err)
    return
  }

  for {
    conn, conn_endpoint, conn_err := net.accept_tcp(sock)
    if conn_err != nil {
      fmt.eprintln("accept_tcp error:", conn_err)
      return
    }


  }
  



}
