const std = @import("std");


fn build_frequensy(allocator: std.mem.Allocator, file: []u8) !std.AutoHashMap(u8, u32) {
    var m = std.AutoHashMap(u8, u32).init(allocator);

    for (file) |c| {
        if (m.contains(c)) {
            const entry = m.getEntry(c).?;
            entry.value_ptr.* += 1;
        } else {
            try m.put(c, 1);
        }
    }

    return m;
}

const Node = struct {
    freq: u32,
    letter: u8,
    is_liaf: bool,
    left: ?*Node = null,
    right: ?*Node = null,
};

fn less(context: void, a: Node, b: Node) std.math.Order {
    _ = context;
    if (a.freq == b.freq) {
        return std.math.order(a.letter, b.letter);
    }
    return std.math.order(a.freq, b.freq);
}


fn build_priority_queue(allocator: std.mem.Allocator, m: std.AutoHashMap(u8, u32)) !std.PriorityQueue(*Node) {
    var pq = std.PriorityQueue(*Node, void, less).init(allocator);

    var it = m.iterator();
    while(it.next()) |entry| {
        const n = try allocator.create(Node);
        n.letter = entry.key_ptr.*;
        n.freq = entry.value_ptr.*;
        n.is_liaf = true;
        try pq.add(n);
    }

    return pq;
}

fn build_huffman_tree(allocator: std.mem.Allocator, pq: *std.PriorityQueue(*Node)) !*Node {
    while(pq.count() > 1) {
        const l = pq.remove();
        const r = pq.remove();
        const new_node = try allocator.create(Node);
        new_node.is_liaf = false;
        new_node.freq = l.freq + r.freq;
        new_node.left = l;
        new_node.right = r;
        try pq.add(new_node);
    }
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const args = try std.process.argsAlloc(allocator);
    if (args.len < 2) {
        std.debug.print("Usage: compress [file_name]\n", .{});
        return;
    }

    const file = try std.fs.cwd().openFile(args[1], .{.mode = .read_only});
    defer file.close();
    const stat = try file.stat();

    const buf = try allocator.alloc(u8, stat.size);
    _ = try file.read(buf);

    var m = try build_frequensy(allocator, buf);
    defer m.deinit();

    var pq = try build_priority_queue(allocator, m);

}
