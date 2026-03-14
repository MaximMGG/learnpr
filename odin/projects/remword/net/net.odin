package net

import "core:net"
import "core:thread"
import "core:sync"
import "core:log"
import "core:strings"
import "core:os"
import _module "../module"

REQUEST_FMT_OK_200 :: "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\nContent-Length: %d\r\nConnection: keep-alive\r\n\r\n%s"

html_pages := []string{
  "combine-modules.html",
  "create-module.html",
  "delete-module.html",
  "index.html",
  "module.html",
}

NetError :: enum {
  NET_INIT_ERROR,
  NET_NEW_CONNECTION_ERROR,

}

Net :: struct {
  sock: net.TCP_Socket,
  cur_module: ^_module.Module,
  modules: []string,
  mutex: sync.Mutex
}

Request_Type :: enum {
  GET, POST, NOT_SUPPORT
}

Request :: struct {
  type: Request_Type,
  path: string,
  headers: map[string]string,
}

init :: proc(modules: []string) -> (Net, NetError) {
  endpoint := net.Endpoint{port = 8080, address = net.IP4_Address{127, 0, 0, 1}}
  socket, socket_error := net.listen_tcp(endpoint)
  if socket_error != nil {
    return Net{}, .NET_INIT_ERROR
  }

  n := Net{sock = socket, modules = modules}

  return n, nil
}

shutdown :: proc(n: ^Net) {
  net.close(n.sock)
}

waitNewConnection :: proc(n: ^Net) -> NetError {
  new_conn, new_endpoint, new_error := net.accept_tcp(n.sock)
  if new_error != nil {
    return .NET_NEW_CONNECTION_ERROR
  }

  log.info("New Connection", new_endpoint.address, "-", new_endpoint.port)

  worker := thread.create(processConn)
  worker.user_index = int(new_conn)
  worker.data = n
  thread.start(worker)

  return nil
}

processConn :: proc(t: ^thread.Thread) {
  sock := net.TCP_Socket(t.user_index)
  readRequest((^Net)(t.data), sock)
}

// GET /combine-modules.html HTTP/1.1
// Host: localhost:8080
// Connection: keep-alive
// Cache-Control: max-age=0
// sec-ch-ua: "Chromium";v="146", "Not-A.Brand";v="24", "Google Chrome";v="146"
// sec-ch-ua-mobile: ?0
// sec-ch-ua-platform: "Windows"
// Upgrade-Insecure-Requests: 1
// User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36
// Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/sstack: 7

@(private)
parseRequest :: proc(request_buf: []byte) -> ^Request {

  request := new(Request)

  request_lines := strings.split(string(request_buf), "\r\n")
  defer delete(request_lines)

  first_line := strings.split(request_lines[0], " ")
  defer delete(first_line)
  if first_line[0] == "GET" {
    request.type = .GET
  } else if first_line[0] == "POST" {
    request.type = .POST
  } else {
    request.type = .NOT_SUPPORT
  }

  request.path = strings.clone(first_line[1][1:])

  for header in request_lines[1:] {
    split_header := strings.split(header, ": ")
    defer delete(split_header)
    request.headers[split_header[0]] = split_header[1]
  }

  return request
}

freeRequest :: proc(request: ^Request) {
  delete(request.headers)
  delete(request.path)
  free(request)
}

readRequest :: proc(n: ^Net, sock: net.TCP_Socket) {
  read_bytes: int = 1
  err: net.TCP_Recv_Error
  for read_bytes > 0 {
    buf := make([]byte, 4096)
    defer delete(buf)

    read_bytes, err = net.recv(sock, buf)
    if err != nil {
      log.error("ReadRequest from socket:", sock, "error")
      return
    }

    request := parseRequest(buf[0:read_bytes])
    defer freeRequest(request)

    sendResponse(n, sock, request)
  }
}

getIndexHtml :: proc(n: ^Net) -> string {

  return ""
}



sendResponse :: proc(n: ^Net, sock: net.TCP_Socket, req: ^Request) {
  if req.type == .GET {
    if len(req.path) == 0 {

    }
  } else if req.type == .POST {

  } else {

  }
}



