package https_example

import "core:fmt"
import "core:net"

host :: "example.com"
port :: "443"

main :: proc() {
    tcp, err := net.dial_tcp(host + ":" + port)
    if err != nil {
        fmt.eprintln("Cant open tlc connection")
        return
    }
    defer net.close(tcp)
}
