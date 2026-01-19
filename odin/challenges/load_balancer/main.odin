package main

import "core:fmt"
import "core:net"
import "core:os"
import "core:log"
import "core:thread"


main :: proc() {
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
    buf: [1024]byte
    received_bytes, received_err := net.recv_tcp(client_socket, buf[:])
    if received_err != nil {
      fmt.eprintln("recv err:", received_err)
      os.exit(1)
    }
  }

  log.info("Shutdown load balancer server")
}
