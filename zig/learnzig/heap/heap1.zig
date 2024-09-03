const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var arr = try allocator.alloc(usize, try getRandomCount());
    defer allocator.free(arr);

    for (0..arr.len) |i| {
        arr[i] = i;
    }

    std.debug.print("{any}\n", .{arr});
}

fn getRandomCount() !u8 {
    var seed: u64 = undefined;
    // var seedd = std.time.microTimestamp();
    try std.posix.getrandom(std.mem.asBytes(&seed));

    var random = std.Random.DefaultPrng.init(@intCast(seed));
    return random.random().uintAtMost(u8, 5) + 5;
}
