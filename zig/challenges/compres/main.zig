const std = @import("std");
const testing = std.testing;


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

fn less(context: void, a: *Node, b: *Node) std.math.Order {
    _ = context;
    if (a.freq == b.freq) {
        return std.math.order(a.letter, b.letter);
    }
    return std.math.order(a.freq, b.freq);
}


fn build_priority_queue(allocator: std.mem.Allocator, m: std.AutoHashMap(u8, u32)) !std.PriorityQueue(*Node, void, less) {
    var pq = std.PriorityQueue(*Node, void, less).init(allocator, {});

    var it = m.iterator();
    while(it.next()) |entry| {
        const n = try allocator.create(Node);
        n.letter = entry.key_ptr.*;
        n.freq = entry.value_ptr.*;
        n.is_liaf = true;
        n.left = null;
        n.right = null;
        try pq.add(n);
    }

    return pq;
}

fn build_huffman_tree(allocator: std.mem.Allocator, pq: *std.PriorityQueue(*Node, void, less)) !*Node {
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
    return pq.remove();
}

fn wolk_huffman_tree(base: *Node, level: u32) void {
    if (base.is_liaf) {
        std.debug.print("Char: {c}, frequensy: {d}, LEVEL: {d}\n", .{base.letter, base.freq, level});
    } else {
        if (base.left) |left| {
            std.debug.print("Cur WEIGHT: {d}, LEVEL {d}, going to the LEFT\n", .{base.freq, level});
            wolk_huffman_tree(left, level + 1);
        } else {
            return;
        }
        if (base.right) |right| {
            std.debug.print("Cur WEIGHT: {d}, LEVEL {d}, going to the RIGHT\n", .{base.freq, level});
            wolk_huffman_tree(right, level + 1);
        }
    }
}

fn destroy_huffman_tree(allocator: std.mem.Allocator, base: *Node) void {
    if (base.left) |left| {
        destroy_huffman_tree(allocator, left);
    }
    if (base.right) |right| {
        destroy_huffman_tree(allocator, right);
    }
    allocator.destroy(base);
}

fn build_lookup_table_helper(allocator: std.mem.Allocator, base: *Node, path: []u8, path_len: usize, lookup: *std.AutoHashMap(u8, []u8)) !void {
    if (base.is_liaf) {
        const end_path = try allocator.dupe(u8, path[0..path_len]);
        try lookup.put(base.letter, end_path);
    } else {
        if (base.left) |left| {
            path[path_len] = 0;
            try build_lookup_table_helper(allocator, left, path, path_len + 1, lookup);
        } else {
            return;
        }
        if (base.right) |right| {
            path[path_len] = 1;
            try build_lookup_table_helper(allocator, right, path, path_len + 1, lookup);
        }
    }
}

fn build_lookup_table(allocator: std.mem.Allocator, base: *Node) !std.AutoHashMap(u8, []u8) {
    var res = std.AutoHashMap(u8, []u8).init(allocator);
    var path: [128]u8 = .{0} ** 128;
    try build_lookup_table_helper(allocator, base, &path, 0, &res);
    return res;
}
fn destroy_lookup_table(allocator: std.mem.Allocator, lookup: *std.AutoHashMap(u8, []u8)) void {
    var it = lookup.iterator();

    while(it.next()) |entry| {
        allocator.free(entry.value_ptr.*);
    }

    lookup.deinit();
}


fn build_header(allocator: std.mem.Allocator, freq: std.AutoHashMap(u8, u32)) ![]u8 {
    var num_buf: [64]u8 = undefined;
    var header = try std.ArrayList(u8).initCapacity(allocator, 1024);
    defer header.deinit(allocator);

    var it = freq.iterator();

    while(it.next()) |entry| {
        try header.append(allocator, entry.key_ptr.*);
        try header.append(allocator, ',');
        const num = try std.fmt.bufPrint(&num_buf, "{d}", .{entry.value_ptr.*});
        try header.appendSlice(allocator, num);
        try header.append(allocator, ',');
    }

    return try header.toOwnedSlice(allocator);
}

fn create_encrypt_file(old_name: []u8) !std.fs.File {
    const dot_position = std.mem.indexOfScalar(u8, old_name, '.').?;
    var new_name: [128]u8 = undefined;
    @memcpy(new_name[0..dot_position + 1], old_name[0..dot_position + 1]);
    @memcpy(new_name[dot_position + 1..dot_position+3], "hf");

    const new_file = try std.fs.cwd().createFile(new_name[0..dot_position + 3], .{.truncate = true, .mode = 0o666});
    return new_file;
}

fn encrypt(allocator: std.mem.Allocator, text: []u8, lookup: *std.AutoHashMap(u8, []u8)) ![]u8 {
    var buf = try std.ArrayList(u8).initCapacity(allocator, text.len);    
    defer buf.deinit(allocator);

    var b: u8 = 0;
    var offset: u32 = 0;

    for(text) |c| {
        const path = lookup.get(c).?;
        for (path) |bit| {
            if (bit == 1) {
                b |= 1;
            } else {
                b |= 0;
            }
            if (offset == 7) {
                try buf.append(allocator, b);
                b = 0;
                offset = 0;
            } else {
                b <<= 1;
                offset += 1;
            }
        }
    }
    while(offset < 8) {
        b <<= 1;
        offset += 1;
    }
    try buf.append(allocator, b);

    return buf.toOwnedSlice(allocator);
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);
    if (args.len < 2) {
        std.debug.print("Usage: compress [file_name]\n", .{});
        return;
    }
    if (args.len == 3) {
        if (std.mem.eql(u8, args[1], "-e")) {

        }
    }

    const file = try std.fs.cwd().openFile(args[1], .{.mode = .read_only});
    defer file.close();
    const stat = try file.stat();

    const buf = try allocator.alloc(u8, stat.size);
    _ = try file.read(buf);

    var m = try build_frequensy(allocator, buf);
    defer m.deinit();

    var pq = try build_priority_queue(allocator, m);
    defer pq.deinit();

    const base = try build_huffman_tree(allocator, &pq);
    defer destroy_huffman_tree(allocator, base);

    var lookup = try build_lookup_table(allocator, base);
    defer destroy_lookup_table(allocator, &lookup);

    const header = try build_header(allocator, m);
    defer allocator.free(header);

    const new_file = try create_encrypt_file(args[1]);
    defer new_file.close();
    var write_bytes = try new_file.write(header);
    const encrypted_text = try encrypt(allocator, buf, &lookup);
    defer allocator.free(encrypted_text);

    write_bytes = try new_file.write(encrypted_text);
}



test "encrypt test" {
    std.debug.print("Run test\n", .{});
    const file_name = "test.txt";
    const allocator = testing.allocator;

    const file = try std.fs.cwd().openFile(file_name, .{.mode = .read_only});
    defer file.close();
    const stat = try file.stat();
    const buf = try allocator.alloc(u8, stat.size);
    defer allocator.free(buf);
    _ = try file.read(buf);

    var m = try build_frequensy(allocator, buf);
    defer m.deinit();

    var pq = try build_priority_queue(allocator, m);
    defer pq.deinit();

    const base = try build_huffman_tree(allocator, &pq);
    defer destroy_huffman_tree(allocator, base);

}
