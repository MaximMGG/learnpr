package client


import "core:net"
import "core:fmt"
import "core:os"


main :: proc() {
  endpoint := net.Endpoint{address = net.IP4_Address{127, 0, 0, 1}, port = 8080}
  sock, sock_err := net.dial_tcp_from_endpoint(endpoint)
  if sock_err != nil {
    fmt.eprintln("dial_tcp_from_endpoint err:", sock_err)
  }

  msg := `GET / HTTP/1.1
Host: localhost
User-Agent: curl/7.85.0
Accept:`
  send_bytes, send_err := net.send_tcp(sock, transmute([]byte)msg)
  if send_err != nil {
    fmt.eprintln("send_tcp err:", send_err)
    os.exit(1)
  }
}
