package main

import "core:fmt"
import "core:net"
import "core:os"
import "core:log"
import "core:sys/posix"
import "core:thread"
import "core:c"


redirect_worker :: proc(data: rawptr) {
  sock_p: ^i32 = cast(^i32)data
  sock: posix.FD = cast(posix.FD)sock_p^
  buf: [1024]byte
  read_bytes := posix.read(sock, raw_data(buf[:]), len(buf[:]))
  fmt.println(transmute(string)buf[:read_bytes])

  back_endpoint := net.Endpoint{address = net.IP4_Address{127, 0, 0, 1}, port = 4444}

  backend_sock, backend_err := net.dial_tcp_from_endpoint(back_endpoint)
  defer net.close(backend_sock)
  if backend_err != nil {
    fmt.eprintln("dial_tcp_from_endpoint backend error:", backend_err)
    os.exit(1)
  }

  write_bytes := posix.write(cast(posix.FD)backend_sock, raw_data(buf[:read_bytes]), cast(c.size_t)read_bytes)
  read_bytes = posix.read(cast(posix.FD)backend_sock, raw_data(buf[:]), len(buf))
  write_bytes = posix.write(sock, raw_data(buf[:read_bytes]), cast(c.size_t)read_bytes)
  if write_bytes != read_bytes {
    fmt.eprintln("read bytes:", read_bytes, "not equalse write bytes:", write_bytes)
  }

  exit := "exit"
  posix.write(cast(posix.FD)backend_sock, raw_data(transmute([]u8)exit), len(exit))

  net.close(cast(net.TCP_Socket)sock)
}

main :: proc() {
  log.create_console_logger()
  log.info("Startup load balancer server")
  endpoint: net.Endpoint 
  endpoint.address = net.IP4_Address{127, 0, 0, 1}
  endpoint.port = 8080
  load_socket, load_err := net.listen_tcp(endpoint)
  if load_err != nil {
    fmt.eprintln("listen_tcp err:", load_err)
    os.exit(1)
  }
  for {
    client_socket, client_endpoint, client_err := net.accept_tcp(load_socket)
    if client_err != nil {
      fmt.eprintln("accept_tcp err:", client_err)
      os.exit(1)
    }
    fmt.println("Received request from ", client_endpoint.address)
    t := thread.create_and_start_with_data(&client_socket, redirect_worker, context, self_cleanup = true)
  }

  log.info("Shutdown load balancer server")
}
