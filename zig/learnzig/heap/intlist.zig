const std = @import("std");
const Allocator = std.mem.Allocator;
const testing = std.testing;

pub const IntList = struct {
    pos: usize,
    items: []i64,
    allocator: Allocator,

    fn init(allocator: Allocator) !IntList {
        return .{ .pos = 0, .allocator = allocator, .items = try allocator.alloc(i64, 4) };
    }
    fn deinit(self: IntList) void {
        self.allocator.free(self.items);
    }

    fn add(self: *IntList, val: i64) !void {
        const pos = self.pos;
        const len = self.items.len;

        if (pos == len) {
            var larger = try self.allocator.alloc(i64, len * 2);

            @memcpy(larger[0..len], self.items);

            self.allocator.free(self.items);
            self.items = larger;
        }
        self.items[pos] = val;
        self.pos += 1;
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var list = try IntList.init(allocator);
    defer list.deinit();

    for (0..10) |i| {
        try list.add(@intCast(i));
    }

    std.debug.print("{any}\n", .{list.items[0..list.pos]});
}

test "IntList: add" {
    var list = try IntList.init(testing.allocator);
    defer list.deinit();

    for (0..5) |i| {
        try list.add(@intCast(i + 10));
    }

    try testing.expectEqual(@as(usize, 5), list.pos);
    try testing.expectEqual(@as(i64, 10), list.items[0]);
    try testing.expectEqual(@as(i64, 11), list.items[1]);
    try testing.expectEqual(@as(i64, 12), list.items[2]);
    try testing.expectEqual(@as(i64, 13), list.items[3]);
    try testing.expectEqual(@as(i64, 14), list.items[4]);
}
