const std = @import("std");

var user_name: [128]u8 = .{0} ** 128;
const tmplate = "/home/{s}/.local/share/";

pub fn main() !void {
    const allocator = std.heap.page_allocator;


    var env = try std.process.getEnvMap(allocator);
    defer env.deinit();

    var it = env.iterator();

    while(it.next()) |item| {
        std.debug.print("{s}: {s}\n", .{item.key_ptr.*, item.value_ptr.*});

    }

}
