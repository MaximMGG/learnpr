const std = @import("std");

const String = struct {
    data: []u8,

    fn init(str: []u8) String {
        return String{.data = str};
    }

};


const User = struct {
    // id: i64,
    // name: String,
    age: u8,

    fn init(age: u8) User {
        return User{.age = age};
    }
};


pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var users = try std.ArrayListAligned(User, @alignOf(User)).initCapacity(allocator, 100_000_000);
    defer users.deinit();
    //var buf: [128]u8 = undefined;

    std.debug.print("User size: {d}\n", .{@sizeOf(User)});
    std.debug.print("User alignment: {d}\n", .{@alignOf(User)});


    for(0..100_000_000) |i| {
        // const id: i64 = @intCast(i);
        // const name = try std.fmt.bufPrint(&buf, "User {d}", .{i});
        const age: u8 = @intCast(i % 100);
        try users.append(User{.age = age});
    }

    var timer = try std.time.Timer.start();
    var sum: u64 = 0;

    for(0..users.items.len) |i| {
        sum += @as(u64, @intCast(users.items[i].age));
    }

    sum /= users.items.len;
    std.debug.print("Average age: {d}\n", .{sum});
    std.debug.print("Elapsed time: {d}\n", .{timer.lap() / std.time.ns_per_ms});
}
