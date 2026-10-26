const std = @import("std");
const ssl = @import("ssl");


pub fn main() void {
    _ = ssl.SSL_library_init();
    _ = ssl.SSL_load_error_strings();
    var hints: std.c.addrinfo = undefined;
    hints.flags = std.c.AF.INET;
    hints.socktype = std.c.SOCK.STREAM;
    var res: *?std.c.addrinfo = null;
    _ = std.c.getaddrinfo("fapi.binance.com", "443", &hints, &res);

    const s: std.Io.net.Socket = undefined;
}
