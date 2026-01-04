package client

import "core:fmt"
import "core:net"


main :: proc() {
  e := net.Endpoint{address = {127, 0, 0, 1}, port = 6969}
  socket, socket_err := net.dial_tcp_from_hostname_and_port_string("127.0.0.1:6969")
  if socket_err != nil {
    fmt.eprintln("dial_tcp_from_hostname_and_port_string error:", socket_err)
    return
  }
  net.close(socket)

  message := "Hello from client"

  send_bytes, send_error := net.send(socket, transmute([]u8)message)
  if send_error != nil {
    fmt.eprintln("net.send error:", send_error)
    return
  }

  recv: [1024]u8

  recv_bytes, recv_error := net.recv(socket, recv[:])
  if recv_error != nil {
    fmt.eprintln("net.recv error:", recv_error)
    return
  }

  fmt.println("Recv from server:", transmute(string)recv[0:recv_bytes])
}
