package token

import "core:fmt"
import "core:net"
import "core:c"
import "core:log"
import "core:strings"
import "core:testing"


HOST :: "api.binance.com"
PORT :: "443"
REQUEST :: "GET /api/v3/ticker?symbol=%s HTTP/1.1\r\nHost: api.binance.com\r\nConection: open\r\n\r\n"


foreign import libssl {
    "system:ssl", "system:crypto",
}

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

Token :: struct {
    symbol: string,
    id: i32,
    ticker: ^Ticker,
    request: string,
    response: string,
    ctx: SSL_CTX,
    ssl: SSL,
    socket: i32,
}

create :: proc(token: string) -> (t: ^Token) {
    t = new(Token)
    t.symbol = strings.clone(token)
    t.request = fmt.aprintf(REQUEST, token)
    SSL_library_init()
    SSL_load_error_strings()

    t.ctx = SSL_CTX_new(TLS_client_method())
    if t.ctx == nil {
    	log.error("SSL_CTX_new error")
    	free(t)
    	return nil
    }

    connection_string := strings.concatenate([]string{HOST, ":", PORT})
    defer delete(connection_string)

    s, s_ok := net.dial_tcp_from_hostname_and_port_string(connection_string)
    if s_ok != nil {
    	log.error("TCP connection error")
    	free(t)
    	return nil
    }
    t.socket = i32(s)
    t.ssl = SSL_new(t.ctx)
    SSL_set_fd(t.ssl, t.socket)
    if SSL_connect(t.ssl) <= 0 {
    	log.error("SSL_connect error")
    	net.close(net.TCP_Socket(t.socket))
    	SSL_free(t.ssl)
    	free(t)
    	return nil
    }
    log.info("Create socket and made SSL connection")
    return
}

destroy :: proc(t: ^Token) {
    delete(t.symbol)
    if len(t.response) != 0 {
    	delete(t.response)
    }
    delete(t.request)
    if t.ticker != nil {
    	ticker_destroy(t.ticker)
    }
    SSL_shutdown(t.ssl)
    SSL_free(t.ssl)
    SSL_CTX_free(t.ctx)
    net.close(net.TCP_Socket(t.socket))
    free(t)
}

request :: proc(t: ^Token) {
    write_bytes := SSL_write(t.ssl, cstring(raw_data(t.request)), len(t.request))
    if write_bytes != i32(len(t.request)) {
    	log.error("SSL_write error, write bytes: ", write_bytes, "request len:", len(t.request))
    	return
    }
    buf := make([]u8, 4096)
    defer delete(buf)
    read_bytes := SSL_read(t.ssl, raw_data(buf), 4096)
    content_index := strings.index(string(buf[0:read_bytes]), "\r\n\r\n")

    if len(t.response) != 0 {
    	delete(t.response)
    }
    t.response = strings.clone(string(buf[content_index + 4:read_bytes]))
    if t.ticker != nil {
    	ticker_destroy(t.ticker)
    }
    t.ticker = ticker_create(t.response)
    log.info("Token:", t.symbol, "request DONE")
}


@(test)
tocket_create_parse_test :: proc(t: ^testing.T) {
    token := create("BTCUSDT")
    defer destroy(token)
    request(token)
    assert(token.socket != 0)
    fmt.println(token)
}
