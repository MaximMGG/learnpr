const std = @import("std");
const posix = std.posix;
const net = std.net;


pub fn main() !void {

    const allocator = std.heap.c_allocator;


    const addressed = try net.getAddressList(allocator, "craftinginterpreters.com", 80);
    defer addressed.deinit();
    //const address = try net.Address.parseIp("craftinginterpreters.com", 80);
    const tpe = posix.SOCK.STREAM;
    const protocol = posix.IPPROTO.TCP;
    const sock = try posix.socket(addressed.addrs[0].any.family, tpe, protocol);
    const sock_len: posix.socklen_t = @sizeOf(net.Address);
    const timeval = posix.timeval{.sec = 1, .usec = 500_000};
    try posix.setsockopt(sock, posix.SOL.SOCKET, posix.SO.RCVTIMEO, &std.mem.toBytes(timeval));
    posix.connect(sock, &addressed.addrs[0].any, sock_len) catch |err| {
        std.debug.print("Error connecting {}\n", .{err});
        return;
    };

    const stream = net.Stream{.handle = sock};

    var bytes = try stream.write("GET /introduction.html HTTP/1.1\r\nHost: craftinginterpreters.com\r\n\r\n");
    if (bytes != 0) {
        std.debug.print("Wrote {d} bytes\n", .{bytes});
    }

    bytes = 1024;
    var buf: [4096]u8 = undefined;

    while(bytes != 0) {
        bytes = posix.read(sock, &buf) catch |err| {
            std.debug.print("Error read {}\n", .{err});
            continue;
        };
        std.debug.print("{s}", .{buf});
        @memset(&buf, 0);
    }

    // var buf: [1024]u8 = undefined;
    // while(bytes == buf.len) {
    //     bytes = try stream.read(buf[0..]);
    //     std.debug.print("{s}", .{buf});
    //     @memset(buf[0..], 0);
    // }


    // const res = try stream.reader().readAllAlloc(allocator, 40960);
    // defer allocator.free(res);
    // std.debug.print("Read {d} bytes.\n{s}", .{res.len, res});


    posix.close(sock);
}
