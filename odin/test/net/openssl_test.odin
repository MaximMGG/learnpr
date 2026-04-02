package openssl_test

import "core:fmt"
import "core:net"
import "core:strings"
import "core:c"
import "core:encoding/json"

foreign import libssl {"system:ssl", "system:crypto"}

SSL_CTX :: rawptr
SSL :: rawptr
SSL_METHOD :: rawptr
OPENSSL_INIT_LOAD_SSL_STRINGS :: c.uint64_t(0x00200000)
OPENSSL_INIT_LOAD_CRYPTO_STRINGS :: c.uint64_t(0x00000002)



@(default_calling_convention="c")
foreign libssl {
    OPENSSL_init_ssl :: proc(n: c.uint64_t = 0, p: rawptr = nil) -> c.int ---
    TLS_client_method :: proc() -> SSL_METHOD ---
    SSL_CTX_new :: proc(method: SSL_METHOD) -> SSL_CTX ---
    SSL_new :: proc(ctx: SSL_CTX) -> SSL ---
    SSL_set_fd :: proc(ssl: SSL, fd: i32) -> i32 ---
    SSL_connect :: proc(ssl: SSL) -> i32 ---
    SSL_shutdown :: proc(ssl: SSL) -> i32 ---
    SSL_free :: proc(ssl: SSL) ---
    SSL_CTX_free :: proc(ctx: SSL_CTX) ---
    SSL_write :: proc(ssl: SSL, buf: cstring, blen: int) -> i32 ---
    SSL_read :: proc(ssl: SSL, buf: rawptr, num: int) -> i32 ---
}

SSL_library_init :: #force_inline proc() {
    OPENSSL_init_ssl(0, nil)
}

SSL_load_error_strings :: proc() {
    OPENSSL_init_ssl(OPENSSL_INIT_LOAD_SSL_STRINGS | OPENSSL_INIT_LOAD_CRYPTO_STRINGS, nil)
}

main :: proc() {
    socket, _ := net.dial_tcp_from_hostname_and_port_string("api.binance.com:443")
    SSL_library_init()
    SSL_load_error_strings()

    ctx := SSL_CTX_new(TLS_client_method())
    if ctx == nil {
	fmt.eprintln("SSL_CTX_new error")
	return
    }
    ssl := SSL_new(ctx)
    SSL_set_fd(ssl, i32(socket))
    if SSL_connect(ssl) <= 0 {
	fmt.eprintln("SSL_connect error")
    }

    request := "GET /api/v3/ticker?symbol=BTCUSDT HTTP/1.1\r\nHost: api.binance.com\r\nConection: close\r\n\r\n"
    s := strings.unsafe_string_to_cstring(request)
    write_bytes := SSL_write(ssl, s, len(request))
    if int(write_bytes) != len(request) {
	fmt.eprintf("write bytes: %d != requiest len: %d\n", write_bytes, len(request))
    }

    buf: [4096]u8

    read_bytes := SSL_read(ssl, rawptr(&buf[0]), 4096)
    response := strings.clone_from(buf[0:read_bytes])
    defer delete(response)
    index := strings.index(response, "\r\n\r\n")
    resp, _ := strings.substring(response, index + 4, len(response))
    fmt.printf("Read response from sever: %s", resp)

    val, json_err := json.parse_string(resp)
    a := val.(json.Object)

    i: u32 = 0
    for k, v in a {
      switch i {
      case 0:
        fmt.println("Key -> ", k, ", val -> ", v.(json.String))
      case 1..=14:
        fmt.println("Key -> ", k, ", val -> ", v.(json.Integer))
      }
      i += 1
    }

    json.destroy_value(val)

    SSL_shutdown(ssl)
    SSL_free(ssl)
    SSL_CTX_free(ctx)
    net.close(socket)

}
