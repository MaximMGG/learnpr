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


fn createHuffmanTree(q: *std.PriorityQueue(Pair, Pair, compare), allocator: std.mem.Allocator) !*Node {
    var cur_node: *Node = try allocator.create(Node);
    var left_node: *Node = try allocator.create(Node);
    var right_node: *Node = try allocator.create(Node);
    var tmp_pair: Pair = q.remove();
    left_node.* = .{.val = tmp_pair.char, .weight = tmp_pair.count, .leaf = true};
    tmp_pair = q.remove();
    right_node.* = .{.val = tmp_pair.char, .weight = tmp_pair.count, .leaf = true};
    cur_node.* = .{.weight = left_node.weight + right_node.weight, .leaf = false, .left = left_node, .right = right_node};

    while(q.count() != 0) {
        tmp_pair = q.remove();
        if (cur_node.weight < tmp_pair.count) {
            left_node = cur_node;
            right_node = try allocator.create(Node);
            right_node.* = .{.val = tmp_pair.char, .weight = tmp_pair.count, .leaf = true};
            cur_node = try allocator.create(Node);
            cur_node.* = .{.weight = left_node.weight + right_node.weight, .leaf = false, .left = left_node, .right = right_node};
        } else {
            right_node = cur_node;
            left_node = try allocator.create(Node);
            left_node.* = .{.val = tmp_pair.char, .weight = tmp_pair.count, .leaf = true};
            cur_node = try allocator.create(Node);
            cur_node.* = .{.weight = left_node.weight + right_node.weight, .leaf = false, .left = left_node, .right = right_node};
        }
    }
    return cur_node;
}

fn freeHuffmanTree(node: *Node, allocator: std.mem.Allocator) void {
    const tmp: *Node = node;
    if (tmp.left) |l| {
        if (l.leaf) {
            allocator.destroy(l);
        } else {
            freeHuffmanTree(l, allocator);
        }
    } else {
        allocator.destroy(tmp);
        return;
    }
    if (tmp.right) |r| {
        if (r.leaf) {
            allocator.destroy(r);
        } else {
            freeHuffmanTree(r, allocator);
        }
    } else {
        allocator.destroy(tmp);
        return;
    }
    allocator.destroy(tmp);
}

fn encodeHuffmanTree(text: []const u8, node: *Node, allocator: std.mem.Allocator) ![]u8 {
    const encoding: []u8 = try allocator.alloc(u8, text.len);
    var i: usize = 0;
    var bit: u8 = 0;
    var bits_count: u8 = 0;

    for(text) |c| {
        var tmp: *Node = node;
        while(true) {
            if (tmp.left.?.leaf) {
                if (tmp.left.?.val == c) {
                    bits_count += 1;
                    break;
                } 
                if (tmp.right.?.leaf) {
                    if (tmp.right.?.val == c) {
                        bit += 1;
                        bits_count += 1;
                        break;
                    } else {
                        @panic("End of tree, no chars is matched");
                    }
                } else {
                    tmp = tmp.right.?;
                    bit += 1;
                    bits_count += 1;
                }
            } else if (tmp.right.?.leaf) {
                if (tmp.right.?.val == c) {
                    bit += 1;
                    bits_count += 1;
                    break;
                }
                bits_count += 1;
                tmp = tmp.left.?;
            } else {
                @panic("Not support now bot not leaf");
            }

            if (bits_count == 8) {
                encoding[i] = bit;
                bit ^= bit;
                i += 1;
                bits_count = 0;
            } else {
                bit <<= 1;
            }
        }
        if (bits_count == 8) {
            encoding[i] = bit;
            bit ^= bit;
            i += 1;
            bits_count = 0;
        } else {
            bit <<= 1;
        }
    }

    if (bits_count != 0) {
        encoding[i] = bit;
        i += 1;
    }

    const res = try allocator.alloc(u8, i);
    @memcpy(res, encoding[0..i]);
    allocator.free(encoding);

    return res;
}



pub fn main() !void { 
    const allocator = std.heap.page_allocator;
    // const allocator = std.heap.c_allocator;
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

    const node = try createHuffmanTree(&q, allocator);
    defer freeHuffmanTree(node, allocator);
    const res = try encodeHuffmanTree(text, node, allocator);

    for(res) |b| {
        std.debug.print("{b}", .{b});
    }

    std.debug.print("\n", .{});
    std.debug.print("{any}\n", .{node});
}

