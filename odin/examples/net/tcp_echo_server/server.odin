
package server

import "core:fmt"
import "core:os"
import "core:net"
import "core:thread"


is_ctrl_d :: proc(bytes: []u8) -> bool {
    return len(bytes) == 1 && bytes[0] == 4
}


is_empty :: proc(bytes: []u8) -> bool {
    return(
	(len(bytes) == 2 && bytes[0] == '\r' && bytes[1] == '\n') ||
	    (len(bytes) == 1 && bytes[0] == '\n')
	
    )
}

is_telnet_ctrl_c :: proc(bytes: []u8) -> bool {
    return (
	(len(bytes) == 3 && bytes[0] == 255 && bytes[1] == 251 && bytes[2] == 6) ||
	    (len(bytes) == 5 &&
	     bytes[0] == 255 &&
	     bytes[1] == 244 &&
	     bytes[2] == 255 &&
	     bytes[3] == 253 &&
	     bytes[4] == 6)
	
    )
}

handle_msg :: proc(sock: net.TCP_Socket) {
    buffer: [256]u8
    for {
	bytes_recv, err_recv := net.recv_tcp(sock, buffer[:])
	if err_recv != nil {
	    fmt.eprintln("Failed to deceive data")
	    return
	}
	received := buffer[:bytes_recv]
	if len(received) == 0 ||
	    is_ctrl_d(received) ||
	    is_empty(received) ||
	    is_telnet_ctrl_c(received) {
		fmt.eprintln("Disconnectiong client")
		break
	    }
	fmt.printfln("Server received [ %d bytes ]: %s", len(received), received)
	bytes_sent, err_send := net.send_tcp(sock, received)
	if err_send != nil {
	    fmt.eprintln("Failed to send data")
	    break
	}
	sent := received[:bytes_sent]
	fmt.printfln("Server sent [ %d bytes ]: %s", len(sent), sent)
    }
    net.close(sock)
}


tcp_echo_server :: proc(ip: string, port: int) {
    local_addr, ok := net.parse_ip4_address(ip)
    if !ok {
	fmt.eprintln("Failed to parse IP address")
	os.exit(1)
    }

    endpoint := net.Endpoint {
	address = local_addr,
	port = port,
    }

    sock, err := net.listen_tcp(endpoint)
    if err != nil {
	fmt.eprintln("Failed to listen on TCP")
	os.exit(1)
    }
    fmt.printfln("Listening on TCP: %s", net.endpoint_to_string(endpoint))
    for {
	cli, _, err_accept := net.accept_tcp(sock)
	if err_accept != nil {
	    fmt.eprintln("Failed to accept TCP connection")
	    os.exit(1)
	}
	thread.create_and_start_with_poly_data(cli, handle_msg)
    }
    net.close(sock)
    fmt.println("Closed socket")
}


main :: proc() {
    tcp_echo_server("127.0.0.1", 8080)
}
