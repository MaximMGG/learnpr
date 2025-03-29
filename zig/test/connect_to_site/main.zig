const std = @import("std");
const net = std.net;

const stdout = std.io.getStdOut().writer();


pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);
    if (args.len < 2) {
        try stdout.print("Usage: main <site_name>\n", .{});
        return;
    }
    const port = 80;
    const site_name = args[1];
    if (net.isValidHostName(site_name)) {
        var stream = try net.tcpConnectToHost(allocator, site_name, port);
        try stdout.print("Connected to {s}\n", .{site_name});

        _ = try stream.write("GET / HTTP/1.1\r\nHost: example.com\r\n\r\n");

        var buf: [1024]u8 = undefined;
        @memset(buf[0..], 0);
        var bytes: usize = 2;
        while(true) {
            bytes = try stream.read(buf[0..]);
            try stdout.print("Read {d} bytes\n", .{bytes});
            try stdout.print("{s}\n", .{buf});
            @memset(buf[0..], 0);
            if (bytes < buf.len) {
                break;
            }
        }

        defer stream.close();
    } else {
        try stdout.print("Host name is not valid, try agane\n", .{});
        return;
    }

}
