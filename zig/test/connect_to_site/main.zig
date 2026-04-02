const std = @import("std");
const net = std.net;

const stdout = std.io.getStdOut().writer();


pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var msg: [1024]u8 = .{0} ** 1024;

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);
    if (args.len < 2) {
        try stdout.print("Usage: main <site_name>\n", .{});
        return;
    }
    const port = 80;
    const site_name = args[1];
    if (args.len == 3) {
        _ = try std.fmt.bufPrint(msg[0..], "GET /{s} HTTP/1.1\r\nHost: {s}\r\n\r\n", .{args[2][0..], site_name});
    } else {
        _ = try std.fmt.bufPrint(msg[0..], "GET / HTTP/1.1\r\nHost: {s}\r\n\r\n", .{site_name});
    }

    if (net.isValidHostName(site_name)) {
        var stream = try net.tcpConnectToHost(allocator, site_name, port);
        defer stream.close();
        const timeval = std.posix.timeval{.sec = 1.0, .usec = 100_000};
        try std.posix.setsockopt(
                    stream.handle, 
                    std.posix.SOL.SOCKET, 
                    std.posix.SO.RCVTIMEO, 
                    &std.mem.toBytes(timeval));

        try stdout.print("Connected to {s}\n", .{site_name});
        _ = try stream.write(msg[0..]);

        const res = try stream.reader().readAllAlloc(allocator, 40960);
        defer allocator.free(res);

        try stdout.print("Received {d} bytes\n{s}", .{res.len, res});

    } else {
        try stdout.print("Host name is not valid, try agane\n", .{});
        return;
    }
}
