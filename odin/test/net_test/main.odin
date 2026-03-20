package net_test


import "core:fmt"
import "core:net"
import "core:os"


HEADER :: "<h1>Hello world</h1>"

REQUEST_FMT_OK_200 :: "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\nContent-Length: %d\r\nConnection: keep-alive\r\n\r\n%s"

get_header :: proc() -> string {
  index, index_ok := os.read_entire_file("./index.html")
  if !index_ok {
    fmt.eprintln("read_entire_file error:", index_ok)
    return ""
  }
  defer delete(index)
  buf := fmt.aprintf(transmute(string)index, HEADER)
  defer delete(buf)

  answer := fmt.aprintf(REQUEST_FMT_OK_200, len(buf), buf)

  return answer
}

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

    buf: [1024]byte

    bytes_recved, ok := net.recv_tcp(conn, buf[:])

    fmt.printf("Get request: %s\n", transmute(string)buf[:bytes_recved])

    response := get_header()

    net.send_tcp(conn, transmute([]byte)response)

    fmt.printf("Response: %s\n", response)

  }

}
