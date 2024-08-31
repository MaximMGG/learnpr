const std = @import("std");
const c = std.c;
const c_dirent = @cImport(@cInclude("dirent.h"));

const _file = struct {};

pub fn main() void {
    const file: ?*c.FILE = c.fopen("reflect.zig", "r");
    defer _ = c.fclose(file.?);
    var buf: [512]u8 = undefined;
    @memset(buf[0..], 0);

    if (file != null) {
        const read_byte: usize = c.fread(&buf, 1, 512, file.?);
        std.debug.print("Read {d} bytes\n", .{read_byte});
        std.debug.print("file content -> {s}\n", .{buf});
    }
    readdir();
}

fn readdir() void {
    const dir: ?*c_dirent.DIR = c_dirent.opendir("../");
    defer _ = c_dirent.closedir(dir.?);

    var dirent: ?*c_dirent.dirent = null;
    var i: usize = 0;

    while (i < 5) : (i += 1) {
        dirent = c_dirent.readdir(dir.?);

        std.debug.print("dir -> {s}\n", .{dirent.?.d_name});
    }
}
