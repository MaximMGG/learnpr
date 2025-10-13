const std = @import("std");

const Node = struct {
    weight: u32 = 0,
    val:    u8 = 0,
    leaf:   bool = false,
    left:   ?*Node = null,
    right:  ?*Node = null,
};

const Pair = struct {
    char: u8 = 0,
    count: u32 = 0,
};


fn compare(context: Pair, a: Pair, b: Pair) std.math.Order {
    _ = context;
    
    if (a.count == b.count) return .eq;
    if (a.count < b.count) return .lt;
    if (a.count > b.count) return .gt;

    return.eq;
}

fn increaseOrAdd(pair: []Pair, c: u8, pair_len: *usize) void {
    for(0..pair_len.*) |i| {
        if (pair[i].char == c) {
            pair[i].count += 1;
            return;
        }
    }
    pair[pair_len.*].char = c;
    pair[pair_len.*].count = 1;
    pair_len.* += 1;
}


pub fn prepCharQueue(text: []const u8, allocator: std.mem.Allocator) !std.PriorityQueue(Pair, Pair, compare) {
    const pair: []Pair = try allocator.alloc(Pair, 256);
    defer allocator.free(pair);
    var pair_len: usize = 0;

    for(text) |c| {
        increaseOrAdd(pair, c, &pair_len);
    }

    var q = std.PriorityQueue(Pair, Pair, compare).init(allocator, Pair{});

    for(0..pair_len) |i| {
        try q.add(pair[i]);
    }

    return q;
}


pub fn main() !void { 
    const allocator = std.heap.page_allocator;
    const file = try std.fs.cwd().openFile("test2.txt", .{.mode = .read_only});
    defer file.close();
    var file_buf: [4096]u8 = undefined;
    var f_reader = file.reader(&file_buf);
    var reader = &f_reader.interface;
    const f_stat = try file.stat();

    const text = try reader.readAlloc(allocator, f_stat.size);
    defer allocator.free(text);
    var q = try prepCharQueue(text, allocator);
    defer q.deinit();

    while(q.count() != 0) {
        std.debug.print("{any}\n", .{q.remove()});
    }
}
