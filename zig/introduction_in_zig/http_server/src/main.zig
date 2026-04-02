const std = @import("std");
const sock_conf = @import("config.zig").Socket;
const Request = @import("request.zig");
const Response = @import("response.zig");
const Method = Request.Method;

const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    const socket = try sock_conf.init();
    try stdout.print("Server addres: {any}\n", .{socket._address});
    var server = try socket._address.listen(.{});
    const conn = try server.accept();
    defer conn.stream.close();

    var buf: [1000]u8 = undefined;
    @memset(&buf, 0);

    try Request.read_request(conn, buf[0..buf.len]);
    const request = Request.Request.parse_request(&buf);
    if (request.method == Method.GET) {
        if (std.mem.eql(u8, request.uri, "/")) {
            try Response.send_200(conn);
        } else {
            try Response.send_404(conn);
        }
    }
}

