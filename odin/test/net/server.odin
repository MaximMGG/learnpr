package server

import "core:fmt"
import "core:net"
import "core:strings"

PORT :: "6969"

main :: proc() {
  e := net.Endpoint{address = net.IP4_Address{127,0,0,1}, port = 6969}
  // socket, socket_error := net.dial_tcp_from_endpoint(e)
  // if socket_error != nil {
  //   fmt.eprintln(socket_error)
  //   return
  // }
  //defer net.close(socket)

  server_socket, server_socket_err := net.listen_tcp(e)
  if server_socket_err != nil {
    fmt.eprintln("net.listen error:", server_socket_err)
    return
  }
  defer net.close(server_socket)
  client_socket, source_endpoint, client_socket_err :=  net.accept_tcp(server_socket)

  if client_socket_err != nil {
    fmt.println("net.accept_tcp error:", client_socket_err)
    return
  }
  defer net.close(client_socket)

  recv_buf: [1024]u8

  bytes_recv, recv_err := net.recv(client_socket, recv_buf[:])
  if recv_err != nil {
    fmt.eprintln(recv_err)
    return
  }

  fmt.println("Recv:", transmute(string)recv_buf[:bytes_recv])
  hello := "Hello from server"

  bytes_write, send_err := net.send(client_socket, transmute([]u8)hello)
}
