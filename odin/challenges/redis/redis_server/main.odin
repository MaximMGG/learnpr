package redis_server

import "core:net"
import "core:strings"
import "core:fmt"
import "core:os"
import "core:slice"

Redis_Cli_Error :: enum {
    Redis_None,
    Redis_Parse_Error,
    Redis_Read_Request_Error,
}

Request_Type :: enum {
    PING,
    ECHO
}

Request :: struct {
    type: Request_Type,
    content: []u8,
}

Client_Request :: struct {
    requests: [dynamic]Request
}

redis_parse_request :: proc(buf: []u8) -> (Client_Request, Redis_Cli_Error) {
    strings.index(transmute(string)buf, "\r\n\r\n")
    
}

redis_read_request :: proc(client_socket: net.TCP_Socket) -> ([]u8, Redis_Cli_Error) {
    buf: [1024]byte
    read_bytes, read_err := net.recv(client_socket, buf[:])
    if read_err != nil {
	return {}, .Redis_Read_Request_Error
    }
    return slice.clone(buf[:read_bytes]), .Redis_None
}

main :: proc() {
    
    server_endpoint := net.Endpoint{address = net.IP4_Address{127, 0, 0, 1}, port = 6379}
    server_socket, socket_err := net.listen_tcp(server_endpoint)
    if socket_err != nil {
	fmt.eprintln("listen_tcp error:", socket_err)
	os.exit(1)
    }
    fmt.println("Radis server started")
    
    for {
	client_socket, client_endpoint, client_err := net.accept_tcp(server_socket)
	if client_err != nil {
	    fmt.eprintln("accept_tcp err:", client_err)
	    net.close(server_socket)
	    os.exit(1)
	}

	buf, read_err := redis_read_request(client_socket)
	if read_err != .Redis_None {
	    fmt.eprintln("Radis read request error:", read_err)
	    continue
	}
	requests, parse_request_error := redis_parse_request(buf)
    }
    
}
