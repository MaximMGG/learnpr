const std = @import("std");


const Ticker = struct {
    symbol: []const u8,
    priceChange: f32,
    priceChangePercent: f32,
    weightedAvgPrice: f32,
    openPrice: f32,
    highPrice: f32,
    lowPrice: f32,
    lastPrice: f32,
    volume: f32,
    quoteVolume: f64,
    openTime: std.posix.time_t,
    closeTime: std.posix.time_t,
    firstId: u64,
    lastId: u64,
    count: u64,


    // pub fn init(symbol_string: []const u8) Ticker {
    //
    // }
};




pub fn main() !void {
    const get_msg = "GET /api/v3/ticker?symbol=BTCUSDT HTTP1.1\r\n\r\n";
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var buf: [1024]u8 = undefined;

    const addr = try std.net.tcpConnectToHost(allocator, "api.binance.com", 80);
    var bytes = try addr.write(get_msg[0..]);
    bytes = try addr.read(&buf);

    std.debug.print("{s}\n", .{buf});

}
