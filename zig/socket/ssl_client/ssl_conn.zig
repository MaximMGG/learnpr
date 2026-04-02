const std = @import("std");
const c = @cImport({
    @cInclude("openssl/ssl.h");
    @cInclude("openssl/err.h");
    @cInclude("netdb.h");
    @cInclude("unistd.h");
    @cInclude("string.h");
});

pub const Ssl_conn = struct {
    host_name: []const u8,
    host_port: []const u8,
    allocator: std.mem.Allocator,
    const Self = @This();
    var ctx: ?*c.SSL_CTX = null;
    var sockfd: c_int = undefined;
    var ssl: ?*c.SSL = null;
    const request_string = "GET {s} HTTP/1.1\r\nHost: {s}\r\nConnection: close\r\n\r\n";

    pub fn init(allocator: std.mem.Allocator, host_name: []const u8, host_port: []const u8) !Ssl_conn {

        _ = c.OPENSSL_init_ssl(0, null);

        ctx = c.SSL_CTX_new(c.TLS_client_method()) orelse {
            return error.SSLContextInitFailed;
        };

        var hints: c.struct_addrinfo = std.mem.zeroInit(c.struct_addrinfo, .{
            .ai_family = c.AF_INET,
            .ai_socktype = c.SOCK_STREAM,
        });

        var res: ?*c.struct_addrinfo = null;
        if (c.getaddrinfo(@ptrCast(host_name), @ptrCast(host_port), &hints, &res) != 0) {
            std.debug.print("getaddrinfo faild\n", .{});
            return error.AddressResolutionFailed;
        }

        defer c.freeaddrinfo(res);

        sockfd = c.socket(res.?.ai_family, res.?.ai_socktype, res.?.ai_protocol);
        if (sockfd < 0) {
            std.debug.print("socket creation failed\n", .{});
            return error.SocketCreationFailed;
        }

        if (c.connect(sockfd, res.?.ai_addr, res.?.ai_addrlen) != 0) {
            std.debug.print("connection failed\n", .{});
            _ = c.close(sockfd);
            return error.ConnectionFailed;
        }

        ssl = c.SSL_new(ctx) orelse return error.SSLInitFailed;
        _ = c.SSL_set_fd(ssl, sockfd);

        if (c.SSL_connect(ssl) <= 0) {
            c.ERR_print_errors_fp(c.stderr);
            _  =c.close(sockfd);
            return error.SSL_ConnectFailed;
        }

        return Ssl_conn{
            .allocator = allocator,
            .host_name = host_name,
            .host_port = host_port
        };
    }

    pub fn request(self: *Self, _request: []const u8) ![]u8 {
        var buf: [4096]u8 = undefined;
        const final_request = try std.fmt.bufPrint(&buf, request_string, .{_request, self.host_name});

        var bytes = c.SSL_write(ssl, @ptrCast(final_request), @intCast(final_request.len));
        std.debug.print("SSL write {d} bytes\n", .{bytes});
        @memset(&buf, 0);

        bytes = c.SSL_read(ssl, &buf, @intCast(buf.len));
        std.debug.print("SSL read {d} bytes\n", .{bytes});

        var res_buf = try self.allocator.alloc(u8, @intCast(bytes));
        @memcpy(res_buf[0..], buf[0..@intCast(bytes)]);

        return res_buf;
    }

    pub fn deinit(self: *Self) void {
        _ = self;
        _ = c.SSL_shutdown(ssl);
        c.SSL_free(ssl);
        _ = c.close(sockfd);
        c.SSL_CTX_free(ctx);
    }
};



