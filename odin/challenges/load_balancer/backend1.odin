package backend1

import "core:strings"
import "core:net"
import "core:fmt"
import "core:os"
import "core:sys/posix"
import "core:c"

main :: proc() {
  endpoint := net.Endpoint{address = net.IP4_Address{127, 0, 0, 1}, port = 4444}
  serv_sock, serv_err := net.listen_tcp(endpoint)
  defer net.close(serv_sock)
  if serv_err != nil {
    fmt.eprintln("listen_tcp err:", serv_err)
    os.exit(1)
  }

  index_file, index_file_err := os.open("./http/backend1.html", os.O_RDONLY)
  index_buf: [1024]byte
  if index_file_err != nil {
    fmt.eprintln("Can't open backend1.html", index_file_err)
    os.exit(1)
  }



  defer os.close(index_file)
  index_size, _ := os.read(index_file, index_buf[:])

  response := strings.concatenate([]string{"HTTP /1.1 200 OK\r\n\r\n", transmute(string)index_buf[:index_size]})
  defer delete(response)

  for {
    client_sock, client_endpoint, client_err := net.accept_tcp(serv_sock)
    if client_err != nil {
      fmt.eprintln("accept_tcp err:", client_err)
    }
    client_buf: [1024]byte
    read_bytes := posix.read(cast(posix.FD)client_sock, raw_data(client_buf[:]), 1024)
    fmt.println("Received from load server\n", transmute(string)client_buf[:read_bytes])
    write_bytes := posix.write(cast(posix.FD)client_sock, 
      raw_data(response), cast(c.size_t)len(response))
    if write_bytes != len(response) {
      fmt.eprintln("write bytes", write_bytes, "not quealse response len", len(response))
    }
  }
}
