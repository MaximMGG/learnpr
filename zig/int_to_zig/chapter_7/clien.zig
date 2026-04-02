const std = @import("std");
const net = std.net;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const con = try net.tcpConnectToHost(allocator, "127.0.0.1", 3490);
    const send_bytes = try con.write("GET / HTTP/1.1\n\r\n\r");
    std.debug.print("Sending {d} bytes\n", .{send_bytes});

    var buf: [1024]u8 = .{0} ** 1024;

    const read_bytes = try con.read(buf[0..buf.len]);

    std.debug.print("Reseived {d} bytes from server\n{s}\n", .{ read_bytes, buf });

    con.close();
    defer {
        const ok = gpa.deinit();
        if (ok == std.heap.Check.ok) {} else {
            @panic("Maeby heap is broken");
        }
    }
}
