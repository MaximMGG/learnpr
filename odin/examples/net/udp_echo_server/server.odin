package server

import "core:fmt"
import "core:net"

udp_echo_server :: proc(ip: string, port: int) {
    local_addr, ok := net.parse_ip4_address(ip)
    if !ok {
	fmt.eprintln("Failed to parse IP address")
	return
    }
    endpoint := net.Endpoint{
	address = local_addr,
	port = port,
    }
    sock, err := net.make_bound_udp_socket(endpoint.address, endpoint.port)
    if err != nil {
	fmt.eprintln("Failed to make bound UDP socket", err)
	return
    }
    fmt.printfln("Listening on UDP: %s", net.endpoint_to_string(endpoint))
    buffer: [256]u8
    for {
	bytes_recv, remote_endpoint, err_recv := net.recv_udp(sock, buffer[:])
	if err_recv != nil {
	    fmt.println("Failed to receive data", err_recv)
	}
	received := buffer[:bytes_recv]
	fmt.printfln("Server received from %s", net.endpoint_to_string(remote_endpoint))
	fmt.printfln("Received data [ %d bytes]: %s", len(received), received)
	bytes_sent, err_send := net.send_udp(sock, received, remote_endpoint)
	if err_send != nil {
	    fmt.eprintln("Failed to send data", err_send)
	}
	send := received[:bytes_sent]
	fmt.printfln("Server sent [ %d bytes ]: %s", len(send), send)

	free_all(context.temp_allocator)
    }
    net.close(sock)
    fmt.println("Closed socket")
}

main :: proc() {
    udp_echo_server("127.0.0.1", 8080)
}
