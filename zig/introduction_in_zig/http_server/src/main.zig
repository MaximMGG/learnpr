const std = @import("std");
const sock_conf = @import("config.zig").Socket;

const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    const socket = try sock_conf.init();
    try stdout.print("Server addres: {any}\n", .{socket._address});
    var server = try socket._address.listen(.{});
    const conn = try server.accept();
    _ = conn;
}

