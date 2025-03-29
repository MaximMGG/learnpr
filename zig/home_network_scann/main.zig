const std = @import("std");
const net = std.net;



pub fn main() !void {

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var port: u16 = 0;
    while(port != 0xFFFF) : (port += 1) {
        //std.debug.print("Trying port {d}\n", .{port});
        const stream = net.tcpConnectToHost(allocator, "192.168.0.1", port) catch |err| {
            switch(err) {
                error.ConnectionRefused => {
                    continue;
                },
                else => {
                    std.debug.print("{any}", .{err});
                    continue;
                }
            }

        };
        defer stream.close();
        const write_bytes = try stream.write("GET / HTTP/1.1\r\n\r\n");
        if (write_bytes > 0) {
            std.debug.print("Wrote to {s}, port {d} - {d} bytes\n", .{"192.168.0.1", port, write_bytes});

            var buf: [1024]u8 = undefined;
            @memset(buf[0..], 0);

            const read_bytes = try stream.read(buf[0..]);
            if (read_bytes > 0) {
                std.debug.print("Answer from server - {d} bytes, {s}\n", .{read_bytes, buf});
            }
        }
    }


}
