const std = @import("std");
const net = std.net;
//const c = @cImport(@cInclude("sys/socket.h"));


pub const Socket = struct {
    _address: net.Address,
    _stream: net.Stream,

    pub fn init() !Socket {
        const host = [4]u8{127, 0, 0, 1};
        const port = 3490;
        const address = net.Address.initIp4(host, port);
        const socket = try std.posix.socket(address.any.family, std.posix.SOCK.STREAM, std.posix.IPPROTO.TCP);
        const stream = net.Stream{.handle = socket};
        return Socket{._address = address, ._stream = stream};
    }

};
