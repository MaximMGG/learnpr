package server

import "core:fmt"
import "core:net"
import "core:os"
import "core:strings"
import "core:thread"

PORT :: "6969"

dial_with_clien :: proc(data: rawptr) {
  client_socket: net.TCP_Socket = (cast(^net.TCP_Socket)data)^
  fmt.println("Dial with socket:", client_socket)
  for {
    recv_buf: [128]u8
    bytes_recv, recv_err := net.recv(client_socket, recv_buf[:])
    if recv_err != nil {
      fmt.eprintln(recv_err)
      return
    }

    fmt.println("Recv:", transmute(string)recv_buf[:bytes_recv])
    if transmute(string)recv_buf[:bytes_recv] == "quit\n" {
      fmt.println("Disconnect Client:", client_socket)
      break
    }

    bytes_write, send_err := net.send(client_socket, recv_buf[:bytes_recv])
    fmt.println("Write to client(", client_socket, "):", bytes_write, "bytes")
  }
  net.close(client_socket)
} 




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

  for {
    client_socket, source_endpoint, client_socket_err :=  net.accept_tcp(server_socket)
    if client_socket_err != nil {
      fmt.println("net.accept_tcp error:", client_socket_err)
      return
    }
    t: thread.Thread
    thread.create_and_start_with_data(&client_socket, dial_with_clien, context)
  }
}
