package net_impl

import "core:net"
import "core:thread"
import "core:sync"
import "core:log"
import "core:strings"
import _module "../module"
import DB "../storage"
import "core:fmt"

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

Request_Path :: enum {
  INDEX, COMBINE_MODULES, CREATE_MODULE, DELETE_MODULE, MODULE,
}

Request :: struct {
  type: Request_Type,
  path: string,
  path_type: Request_Path,
  headers: map[string]string,
}

init :: proc(modules: []string) -> (Net, NetError) {
  endpoint := net.Endpoint{port = 8080, address = net.IP4_Address{127, 0, 0, 1}}
  socket, socket_error := net.listen_tcp(endpoint)
  if socket_error != nil {
    return Net{}, .NET_INIT_ERROR
  }

  n := Net{sock = socket, modules = modules}
  n.cur_module = nil

  html_fmt_prepare()
  return n, nil
}

shutdown :: proc(n: ^Net) {
  net.close(n.sock)
  html_fmt_destroy()
}

waitNewConnection :: proc(n: ^Net) -> NetError {
  new_conn, new_endpoint, new_error := net.accept_tcp(n.sock)
  if new_error != nil {
    return .NET_NEW_CONNECTION_ERROR
  }

  log.info("New Connection", new_endpoint.address, "-", new_endpoint.port)

  readRequest(n, new_conn)

  return nil
}

// processConn :: proc(t: ^thread.Thread) {
//   sock := net.TCP_Socket(t.user_index)
//   readRequest((^Net)(t.data), sock)
// }

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
requestType :: proc(path: string) -> Request_Path {
  switch(path) {
  case "":
    return .INDEX
  case "module.html":
    return .MODULE
  case "combine-modules.html":
    return .COMBINE_MODULES
  case "create-module.html":
    return .CREATE_MODULE
  case "delete-module.html":
    return .DELETE_MODULE
  }
  return nil
}

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
  request.path_type = requestType(request.path)

  for header in request_lines[1:] {
    split_header := strings.split(header, ": ")
    defer delete(split_header)
    if len(split_header) == 2 {
      request.headers[split_header[0]] = split_header[1]
    }
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
    if read_bytes == 0 {
      continue
    }
    if err != nil {
      log.error("ReadRequest from socket:", sock, "error")
      return
    }

    request := parseRequest(buf[0:read_bytes])
    defer freeRequest(request)

    sendResponse(n, sock, request)
  }
}

getHeader :: proc(m: ^map[string]string, header: string) -> string {
  for k, v in m {
    if header == k {
      return v
    } 
  } 
  return ""
}


getIndexHtml :: proc(n: ^Net) -> string {

  return ""
}

sendResponse :: proc(n: ^Net, sock: net.TCP_Socket, req: ^Request) {
  if req.type == .GET {
    switch(requestType(req.path)) {
    case .INDEX:
      index_html := html_fmt_get_index_html(n.modules)
      defer delete(index_html)
      response := fmt.aprintf(REQUEST_FMT_OK_200, len(index_html), index_html)
      defer delete(response)
      net.send_tcp(sock, transmute([]byte)response)
    case .MODULE:
      href := getHeader(&req.headers, "href")
      if n.cur_module.name == href {
        module_html := html_fmt_get_module(n.cur_module)
        defer delete(module_html)
        response := fmt.aprintf(REQUEST_FMT_OK_200, len(module_html), module_html)
        defer delete(response)
        net.send_tcp(sock, transmute([]byte)response)
      }
    case .CREATE_MODULE:
    case .COMBINE_MODULES:
    case .DELETE_MODULE:

    case nil:
      fmt.eprintf("Not corrent path: %s\n", req.path)
      return
    }

  }
}



