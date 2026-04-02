package test


import "core:fmt"
import "core:c"
import "core:net"


main :: proc() {
    sock, err_sock := net.dial_tcp_from_hostname_with_port_override("www.example.com", 443)
    defer net.close(sock)
    if err_sock != nil {
	fmt.eprintln("Failed connect to TCP")
	return
    }
    msg := "GET / HTTP/1.1\r\n\r\n"
    send_bytes, err_send := net.send_tcp(sock, transmute([]u8)msg)
    if err_send != nil {
	fmt.eprintln("Send error")
	return
    }
    buffer: [1024]u8

    recv_bytes, err_recv := net.recv_tcp(sock, buffer[:])
    if err_recv != nil {
	fmt.eprintln("Received error")
	return
    }
    
    fmt.printfln("Received from server %s", buffer[:recv_bytes])
}
