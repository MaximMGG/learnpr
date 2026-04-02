package back_end

import "core:fmt"
import "core:net"
import "core:sys/posix"
import "core:os"
import "core:slice"

main :: proc() {
  endpoint := net.Endpoint{address = net.IP4_Address{127, 0, 0, 1}, port = 4444}
  back_socket, back_err := net.listen_tcp(endpoint)
  if back_err != nil {
    fmt.eprintln("listen_tcp error:", back_err)
    os.exit(1)
  }

  load_sock, load_endpoint, load_err := net.accept_tcp(back_socket)
  if load_err != nil {
    fmt.eprintln("Connect load_server error:", load_err)
    os.exit(1)
  }

  buf: [1024]byte
  for {
    slice.zero(buf[:])
    read_bytes := posix.read(cast(posix.FD)load_sock, raw_data(buf[:]), len(buf))

    if transmute(string)buf[:read_bytes] == "exit" {
      break
    }

    fmt.println("Received from load server:", transmute(string)buf[:read_bytes])

    msg := "HTTP/1.1 200 OK\r\n\r\nHello from backend server!"
    write_bytes := posix.write(cast(posix.FD)load_sock, raw_data(transmute([]u8)msg), len(msg))

    if write_bytes != len(msg) {
      fmt.eprintln("Write bytes:", write_bytes, "not equalse msg len:", len(msg))
    }
  }
}
