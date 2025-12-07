package token

import "core:fmt"
import "core:net"
import "core:c"
import "core:log"


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
    index: i32
}

