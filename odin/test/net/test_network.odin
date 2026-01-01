package test_network

import "core:fmt"
import "core:net"

main :: proc() {
  tcp_socket, ok := net.dial_tcp_from_hostname_and_port_string("")
}
