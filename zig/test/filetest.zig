const std = @import("std");
const c = std.c;

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
}
