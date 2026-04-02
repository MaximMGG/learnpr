const std = @import("std");
const c = @cImport({
    @cInclude("stdlib.h");
    @cInclude("time.h");
    @cInclude("unistd.h");
});


var writer: *std.Io.Writer = undefined;
var logger_buf: [4096]u8 = undefined;
var time_buf: [1024]u8 = undefined;

pub fn loggerInit() void {
    var stderr = std.fs.File.stderr().writer(logger_buf);
    writer = &stderr.interface;
}


fn getTime() void {
    @memset(time_buf[0..], 0);
    var t = c.time(null);
    const tm = c.localtime(&t);
    c.strftime(time_buf[0..].ptr, 1024, "%Y-%m-%d - %H-%M-%S", tm);
}


pub fn trace(fmt: []const u8, args: anytype) !void {
    getTime();
}

pub fn info() !void {

}

pub fn debug() !void {

}

pub fn err() !void {

}

pub fn fatal() !void {

}

