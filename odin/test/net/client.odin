package client

import "core:fmt"
import "core:net"
import "core:os"


main :: proc() {
  e := net.Endpoint{net.IP4_Address{127, 0, 0, 1}, 6969}
  socket, socket_err := net.dial_tcp_from_hostname_and_port_string("127.0.0.1:6969")
  if socket_err != nil {
    fmt.eprintln("dial_tcp_from_hostname_and_port_string error:", socket_err)
    return
  }
  defer net.close(socket)


  for {
    buf: [128]u8
    read_bytes, _ := os.read(os.Handle(os.stdin), buf[:])
    send_bytes, send_error := net.send(socket, buf[:read_bytes])
    if send_error != nil {
      fmt.eprintln("net.send error:", send_error)
      return
    }

    recv: [1024]u8

    recv_bytes, recv_error := net.recv(socket, recv[:])
    if recv_bytes == 0 {
      break
    }
    if recv_error != nil {
      fmt.eprintln("net.recv error:", recv_error)
      return
    }

    fmt.println("Recv from server:", transmute(string)recv[0:recv_bytes])
  }
}
