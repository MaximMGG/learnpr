const std = @import("std");
const ssl = @cImport({
    @cInclude("openssl/ssl.h");
    @cInclude("openssl/err.h");
});
const net = @cImport({
    @cInclude("sys/socket.h");
    @cInclude("arpa/inet.h");
    @cInclude("netdb.h");
    @cInclude("unistd.h");
});

const HOST = "api.binance.com";
const PORT = "443";

const REQUEST = "GET /api/v3/ticker?symbol=BTCUSDT HTTP/1.1\r\nHost: api.binance.com\r\nConnection: keep-alive\r\n\r\n";

pub fn main() !void {
    // _ = ssl.SSL_library_init();
    _ = ssl.OPENSSL_init_ssl(0, null);
    // _ = ssl.SSL_load_error_strings();
    _ = ssl.OPENSSL_init_ssl(ssl.OPENSSL_INIT_LOAD_SSL_STRINGS | ssl.OPENSSL_INIT_LOAD_CRYPTO_STRINGS, null);
    // _ = ssl.OpenSSL_add_all_algorithms();
    _ = ssl.OPENSSL_init_crypto(ssl.OPENSSL_INIT_ADD_ALL_CIPHERS | ssl.OPENSSL_INIT_ADD_ALL_DIGESTS, null);
    const ctx = ssl.SSL_CTX_new(ssl.TLS_client_method().?) orelse {
        std.debug.print("SSL_CTX_new error\n", .{});
        return;
    };
    var hints = net.addrinfo{.ai_family = net.AF_INET, .ai_socktype = net.SOCK_STREAM};
    var res: *net.addrinfo = undefined;

    if (net.getaddrinfo(HOST, PORT, &hints, @ptrCast(&res)) != 0) {
        std.debug.print("getaddrinfo error\n", .{});
        return;
    }
    const sock = net.socket(res.*.ai_family, res.*.ai_socktype, res.*.ai_protocol);
    if (sock <= 0) {
        std.debug.print("socket error\n", .{});
        return;
    }

    if (net.connect(sock, res.*.ai_addr, res.*.ai_addrlen) != 0) {
        std.debug.print("connet error\n", .{});
        return;
    }
    net.freeaddrinfo(@ptrCast(res));

    const ssl_v = ssl.SSL_new(ctx).?;

    _ = ssl.SSL_set_fd(ssl_v, sock);

    if (ssl.SSL_connect(ssl_v) <= 0) {
        std.debug.print("SSL_connect error\n", .{});
        return;
    }

    const write_bytes = ssl.SSL_write(ssl_v, REQUEST, REQUEST.len);
    if (write_bytes <= 0) {
        std.debug.print("SSL_write error\n", .{});
        return;
    }

    var buf: [4096]u8 = .{0} ** 4096;

    const read_bytes = ssl.SSL_read(ssl_v, buf[0..].ptr, 4096);
    std.debug.print("Read {d} bytes\n", .{read_bytes});
    std.debug.print("{s}\n", .{buf});
    

    _ = ssl.SSL_shutdown(ssl_v);
    ssl.SSL_free(ssl_v);
    ssl.SSL_CTX_free(ctx);
    _ = net.close(sock);
}

