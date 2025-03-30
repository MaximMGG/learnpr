const std = @import("std");
const net = std.net;
const posix = std.posix;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const address = try net.getAddressList(allocator, "example.com", 80);
    defer address.deinit();
    const cpe = posix.SOCK.STREAM;
    const protocol = posix.IPPROTO.TCP;
    //const addr: *net.Address = &address.addrs[0];
    const sock = try posix.socket(address.addrs[0].any.family, cpe, protocol);
    defer posix.close(sock);

    try posix.connect(sock, &address.addrs[0].any, address.addrs[0].getOsSockLen());

    const stream = net.Stream{.handle = sock};

    var bytes = try stream.write("GET / HTTP/1.1\r\nHost: example.com\r\n\r\n");
    if (bytes == 0) {
        std.debug.print("send 0 bytes\n", .{});
        return;
    }

    var buf: [4096]u8 = undefined;
    while(bytes > 0) {
        bytes = try stream.readAll(&buf);
        if (bytes < buf.len) {
            std.debug.print("read less then buf.len\n", .{});
            std.debug.print("{s}", .{buf});
            break;
        }
        std.debug.print("{s}", .{buf});
        @memset(&buf, 0);
    }


}
