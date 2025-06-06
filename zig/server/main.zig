const std = @import("std");
const net = std.net;
const posix = std.posix;


pub fn main() !void {
    const address = try net.Address.parseIp("127.0.0.1", 5882);

    const tpe: u32 = posix.SOCK.STREAM;
    const protocol = posix.IPPROTO.TCP;
    const listener = try posix.socket(address.any.family, tpe, protocol);
    defer posix.close(listener);

    try posix.setsockopt(listener, posix.SOL.SOCKET, posix.SO.REUSEADDR, &std.mem.toBytes(@as(c_int, 1)));
    try posix.bind(listener, &address.any, address.getOsSockLen());


    try printAddress(listener);


    try posix.listen(listener, 128);
    var buf: [128]u8 = undefined;

    while(true) {
        var client_address: net.Address = undefined;
        var client_address_len: posix.socklen_t = @sizeOf(net.Address);

        const socket = posix.accept(listener, &client_address.any, &client_address_len, 0) catch |err| {
            std.debug.print("error accept: {}\n", .{err});
            continue;
        };
        defer posix.close(socket);

        std.debug.print("{} connected\n", .{client_address});


        const timeout = posix.timeval{.sec = 2, .usec = 500_000};
        try posix.setsockopt(socket, posix.SOL.SOCKET, posix.SO.RCVTIMEO, &std.mem.toBytes(timeout));
        try posix.setsockopt(socket, posix.SOL.SOCKET, posix.SO.SNDTIMEO, &std.mem.toBytes(timeout));

        const stream = net.Stream{.handle = socket};

        // const read = posix.read(socket, &buf) catch |err| {
        //     std.debug.print("error reading: {}\n", .{err});
        //     continue;
        // };
        const read = try stream.read(&buf);
        if (read == 0) {
            continue;
        }

        // write(socket, "Hello (and goodbye)\n") catch |err| {
        //     std.debug.print("error writing {}\n", .{err});
        // };
        
        try stream.writeAll(buf[0..read]);
        // write(socket, buf[0..read]) catch |err| {
        //     std.debug.print("error writing: {}\n", .{err});
        // };
     }
}

fn write(socket: posix.socket_t, msg: []const u8) !void {
    var pos: usize = 0;
    while(pos < msg.len) {
        const written = try posix.write(socket, msg[pos..]);
        if (written == 0) {
            return error.Close;
        }
        pos += written;
    }

}

fn printAddress(socket: posix.socket_t) !void {
    var address: net.Address = undefined;
    var len: posix.socklen_t = @sizeOf(net.Address);

    try posix.getsockname(socket, &address.any, &len);
    std.debug.print("{}\n", .{address});
}

fn writeMessage(socket: posix.socket_t, msg: []const u8) !void {
    var buf: [4]u8 = undefined;
    std.mem.writeInt(u32, &buf, @intCast(msg.len), .little);

    var vec = [2]posix.iovec_const{
        .{.len = 4, .base = &buf},
        .{.len = msg.len, .base = msg.ptr},
    };

    try writeAllVectored(socket, &vec);
}

fn writeAllVectored(socket: posix.socket_t, vec: []posix.iovec_const) !void {
    var i: usize = 0;
    while(true) {
        var n = try posix.writev(socket, vec[i..]);
        while(n >= vec[i].len) {
            n -= vec[i].len;
            i += 1;
            if (i >= vec.len) return;
        }
        vec[i].base += 1;
        vec[i].len -= n;
    }
}


const Reader = struct {
    buf: []u8,
    pos: usize = 0,
    start: usize = 0,
    socket: posix.socket_t,

    fn readMessage(self: *Reader) ![]u8 {
        var buf = self.buf;
        while(true) {
            if (try self.bufferedMessage()) |msg| {
                return msg;
            }
        }

        const pos = self.pos;
        const n = try posix.read(self.socket, buf[pos..]);
        if (n == 0) {
            return error.Closed;
        }

        self.pos += n;

    }

    fn bufferedMessage(self: *Reader) !?[]u8 {
        const buf = self.buf;
        const pos = self.pos;
        const start = self.start;

        std.debug.assert(pos >= start);
        const unprocessed = buf[start..pos];

        if (unprocessed.len < 4) {
            self.ensureSpace(4 - unprocessed.len) catch unreachable;
            return null;
        }

        const message_len = std.mem.readInt(u32, unprocessed[0..4], .little);
        const total_len = message_len + 4;
        if (unprocessed.len < total_len) {
            try self.ensureSpace(total_len);
            return null;
        }
        self.start += total_len;
        return unprocessed[4..total_len];
    }

    fn ensureSpace(self: *Reader, space: usize) error{BufferTooSmall}!void {
        const buf = self.buf;
        if (buf.len < space) {
            return error.BufferTooSmall;
        }
        const start = self.start;
        const spare = buf.len - start;
        if (spare >= space) {
            return;
        }

        const unprocessed = buf[start..self.pos];
        std.mem.copyForwards(u8, buf[0..unprocessed.len], unprocessed);
        self.start = 0;
        self.pos = unprocessed.len;
    }

};
