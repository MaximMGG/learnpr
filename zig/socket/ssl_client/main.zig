const std = @import("std");
const ssl = @import("ssl_conn.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    //var s = try ssl.Ssl_conn.init(allocator, "api.binance.com", "443");
    var s = try ssl.Ssl_conn.init(allocator, "www.reverso.net", "443");
    defer s.deinit();
    //var buf = try s.request("/api/v3/ticker?symbol=BTCUSDT");
    var buf = try s.request("/text-translation#sl=eng&tl=rus&text=cat");

    const content_start = std.mem.indexOf(u8, buf, "\r\n\r\n") orelse {s.deinit(); return;};
    std.debug.print("{s}\n", .{buf[(content_start + 4)..buf.len]});

    allocator.free(buf);


}
