const std = @import("std");
const Allocator = std.mem.Allocator;

pub fn main() !void {
    var arr: IntArra(3) = undefined;
    arr[0] = 0;
    arr[1] = 2;
    arr[2] = 3;
    std.debug.print("{any}\n", .{arr});

    var arr2 = IntArray(3).init();

    arr2.items[0] = 2;
    arr2.items[1] = 3;
    arr2.items[2] = 4;

    std.debug.print("{any}\n", .{arr2});

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var l = try List(i32).init(allocator);
    defer l.deinit();

    try l.add(@intCast(123));
    try l.add(@intCast(444));
    try l.add(@intCast(333));
    try l.add(@intCast(555));

    std.debug.print("{any}\n", .{l.items[0..l.pos]});
    std.debug.print("type of List {any}\n", .{@TypeOf(l)});
    std.debug.print("type of List {any}\n", .{@TypeOf(l.items)});
    std.debug.print("type of List {any}\n", .{@TypeOf(l.items[0..l.pos])});
    std.debug.print("type of List {any}\n", .{@TypeOf(l.items[0..l.items.len])});
}

fn IntArra(comptime length: usize) type {
    return [length]i64;
}

fn IntArray(comptime length: usize) type {
    return struct {
        items: [length]i64,

        fn init() IntArray(length) {
            return .{
                .items = undefined,
            };
        }
    };
}

const DEF_LIST_SIZE = 4;

fn List(comptime T: type) type {
    return struct {
        pos: usize,
        items: []T,
        allocator: Allocator,

        fn init(allocator: Allocator) !List(T) {
            return .{
                .pos = 0,
                .allocator = allocator,
                .items = try allocator.alloc(T, DEF_LIST_SIZE),
            };
        }
        fn deinit(self: *List(T)) void {
            self.allocator.free(self.items);
        }

        fn add(self: *List(T), value: T) !void {
            const pos = self.pos;
            const len = self.items.len;

            if (pos == len) {
                var larger = try self.allocator.alloc(T, len * 2);
                @memcpy(larger[0..len], self.items);

                self.allocator.free(self.items);
                self.items = larger;
            }

            self.items[pos] = value;
            self.pos += 1;
        }
    };
}
