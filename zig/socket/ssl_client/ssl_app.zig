const std = @import("std");
const c = @cImport({
    @cInclude("openssl/ssl.h");
    @cInclude("openssl/err.h");
    @cInclude("netdb.h");
    @cInclude("unistd.h");
    @cInclude("string.h");
});


pub fn main() !void {
    //const allocator = std.heap.c_allocator;

    // c.SSL_library_init();
    // c.SSL_load_error_strings();
    // c.OpenSSL_add_all_algorithms();
    //

    _ = c.OPENSSL_init_ssl(0, null);


    const ctx = c.SSL_CTX_new(c.TLS_client_method());
    if (ctx == null) {
        return error.SSLContextInitFailed;
    }

    var hints: c.struct_addrinfo = std.mem.zeroInit(c.struct_addrinfo, .{
        .ai_family = c.AF_INET,
        .ai_socktype = c.SOCK_STREAM,
    });
    var res: ?*c.struct_addrinfo = null;
    if (c.getaddrinfo("api.binance.com", "443", &hints, &res) != 0) {
        std.debug.print("getaddrinfo failed\n", .{});
        return error.AddresResolutionFailed;
    }

    defer c.freeaddrinfo(res);

    const sockfd = c.socket(res.?.ai_family, res.?.ai_socktype, res.?.ai_protocol);
    if (sockfd < 0) {
        std.debug.print("socket creation failed\n", .{});
        return error.SocketCreationFaild;
    }

    if (c.connect(sockfd, res.?.ai_addr, res.?.ai_addrlen) != 0) {
        std.debug.print("connect failed\n", .{});
        _ = c.close(sockfd);
        return error.ConnectionFailed;
    }

    const ssl = c.SSL_new(ctx) orelse return error.SSLInitFailed;
    _ = c.SSL_set_fd(ssl, sockfd);

    if (c.SSL_connect(ssl) <= 0) {
        c.ERR_print_errors_fp(c.stderr);
        return error.SSL_ConnectFailed;
    }

    const request = "GET /api/v3/ticker?symbol=BTCUSDT HTTP/1.1\r\nHost: api.binance.com\r\nConnection: close\r\n\r\n";
    _ = c.SSL_write(ssl, request, @intCast(request.len));

    var buffer: [4096]u8 = .{0} ** 4096;
    var bytes: c_int = 1;

    bytes = c.SSL_read(ssl, &buffer, @intCast(buffer.len));

    const content_start = std.mem.indexOf(u8, &buffer, "\r\n\r\n") orelse 0;

    std.debug.print("{s}\n", .{buffer[content_start + 4..@as(usize, @intCast(bytes))]});

    _ = c.SSL_shutdown(ssl);
    c.SSL_free(ssl);
    _ = c.close(sockfd);
    c.SSL_CTX_free(ctx);


}
