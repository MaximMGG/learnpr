package redis_cli

import "core:net"
import "core:fmt"
import "core:os"
import "core:strings"

GET_REQUEST :: "GET / HTTP/1.1\r\n\r\n%s"

prepare_args :: proc(args: []string) -> string {
    builder: strings.Builder
    strings.builder_init(&builder)
    defer strings.builder_destroy(&builder)

    for arg in args {
	strings.write_string(&builder, arg)
	strings.write_string(&builder, " ")
    }
    strings.write_string(&builder, "\r\n")

    return strings.clone(strings.to_string(builder))
}

//6379
main :: proc() {
    args := os.args
    if len(args) <= 1 {
	fmt.eprintln("Wrong number of args: Usage: redis_clie [command], []arg")
    }
    
    endpoint := net.Endpoint{address = net.IP4_Address{127, 0, 0, 1}, port = 6379}
    socket, socket_err := net.dial_tcp(endpoint)
    defer net.close(socket)
    if socket_err != nil {
	fmt.eprintln("dial_tcp error:", socket_err)
	return
    }

    request := prepare_args(args)
    defer delete(request)

    buf := fmt.aprintf(GET_REQUEST, request)
    defer delete(buf)
    net.send(socket, transmute([]byte)buf)
}
