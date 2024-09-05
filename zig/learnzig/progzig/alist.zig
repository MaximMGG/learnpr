const std = @import("std");
const builtin = @import("builtin");
const Allocator = std.mem.Allocator;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alc = gpa.allocator();

    var arr = std.ArrayList(User).init(alc);
    defer {
        for (arr.items) |user| {
            user.deinit(alc);
        }
        arr.deinit();
    }

    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var i: i32 = 0;
    while (true) : (i += 1) {
        var buf: [64]u8 = undefined;
        try stdout.print("Pleas enter the name: ", .{});
        if (try stdin.readUntilDelimiterOrEof(&buf, '\n')) |link| {
            var name = link;
            if (builtin.os.tag == .windows) {
                name = std.mem.trimRight(u8, name, "\r");
            }
            if (name.len == 0) break;

            const owned_name = try alc.dupe(u8, name);
            try arr.append(.{ .name = owned_name, .power = i });
        }
    }

    var has_leto = false;
    for (arr.items) |user| {
        if (std.mem.eql(u8, "Leto", user.name)) {
            has_leto = true;
            break;
        }
    }

    std.debug.print("has leto {any}\n", .{has_leto});
}

const User = struct {
    name: []const u8,
    power: i32,

    fn deinit(self: User, alc: Allocator) void {
        alc.free(self.name);
    }
};
