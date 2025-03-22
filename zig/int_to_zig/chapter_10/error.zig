const std = @import("std");
const Allocator = std.mem.Allocator;


pub fn resolvePath(ally: Allocator, p: []const u8) error{
    OutOfMemory,
    CurrentWorkingDirectoryUnkinked,
    Unexpected, }![]u8 {


        _ = ally;
        _ = p;
}

pub const ReadError = error {
    TlsFailure,
    TlsAlert,
    ConnectionTimedOut,
    ConnectionResetByPeer,
    UnexpectedReadFailure,
    EndOfStream
};

pub fn readvDirect(conn: std.net.Server.Connection, buffers: []std.posix.iovec) ReadError!usize {
    _ = conn;
    _ = buffers;

}

fn open_file(path: []const u8) ?std.fs.File {
    const file = std.fs.cwd().openFile(path, .{}) catch |err| blk: {
        std.debug.print("Error: {any}\n", .{err});
        break :blk null;
    };
    return file;

}

fn if_err(n: usize) !usize {
    if (n % 2 == 0) {return n / 2;}
    else {return error.NotDevideByTwo;}
}

pub fn main() !void {
    const f: ?std.fs.File = open_file("Cabucha");
    if (f) |file| {
        std.debug.print("Open file {any}\n", .{file});
    } else {
        std.debug.print("Cant open file\n", .{});
    }

    if (if_err(5)) |number| {
        std.debug.print("Number: {d}\n", .{number});

    } else |err| {
        std.debug.print("Error: {any}\n", .{err});
    }

    const r: Registry = Registry{.c = 1};
    
    switch(r) {
        .c => {
            std.debug.print("Double\n", .{});
        },
        .d => {
            std.debug.print("I32\n", .{});
        },
        .p => {
            std.debug.print("String\n", .{});
        },
    }

}

pub const Registry = union(enum) {
    c: i32,
    d: f64,
    p: []const u8
};

