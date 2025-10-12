const std = @import("std");

pub fn sort_lists(chars: *std.ArrayList(u8), count: *std.ArrayList(u32)) void {
    std.debug.print("Chars: {any}\n", .{chars.items});
    std.debug.print("Weights: {any}\n", .{count.items});
    var start: usize = 0;
    const end: usize = chars.items.len;
    var char_slice = chars.items[start..end];
    var count_slice = count.items[start..end];

    while(char_slice.len > 1) {
        var min: u32 = 1 << 30;
        var index: usize = 0;
        for(count_slice, 0..) |weight, i| {
            if (weight < min) {
                min = weight;
                index = i;
            }
        }

        const tmp_count: u32 = count_slice[0];
        const tmp_char: u8 = char_slice[0];
        count_slice[0] = count_slice[index];
        char_slice[0] = char_slice[index];
        count_slice[index] = tmp_count;
        char_slice[index] = tmp_char;
        start += 1;
        count_slice = count.items[start..end];
        char_slice = chars.items[start..end];
    }
    std.debug.print("Chars: {any}\n", .{chars.items});
    std.debug.print("Weights: {any}\n", .{count.items});
}

const Node = struct {
    weight: u32 = 0,
    val:    u8 = 0,
    leaf:   bool = false,
    left:   ?*Node = null,
    right:  ?*Node = null,
};


pub fn printHuffmanTree(head: *Node) void {
    std.debug.print("Step weight: {d}\n", .{head.weight});
    if (head.left) |node| {
        if (node.leaf) {
            std.debug.print("Leaf: {c} - {d}\n", .{node.val, node.weight});
        } else {
            printHuffmanTree(node);
        }
    } else {
        return;
    }
    if (head.right) |node| {
        if (node.leaf) {
            std.debug.print("Leaf: {c} - {d}\n", .{node.val, node.weight});
        } else {
            printHuffmanTree(node);
        }
    } else {
        return;
    }
}


pub fn deleteHuffmanTree(head: ?*Node, allocator: std.mem.Allocator) void {
    if (head) |h| {
        if (h.leaf) {
            allocator.destroy(h);
        } else {
            deleteHuffmanTree(h.left, allocator);
            deleteHuffmanTree(h.right, allocator);
            allocator.destroy(h);
        }
    } else {
        return;
    }
}


pub fn buildHuffmanTree(chars: *std.ArrayList(u8), count: *std.ArrayList(u32), allocator: std.mem.Allocator) !*Node {
    std.debug.print("Inside buildHuffmanTree\n", .{});
    std.debug.print("Chars: {any}\n", .{chars});
    std.debug.print("Counts: {any}\n", .{count});
    const tmp_left = try allocator.create(Node);
    const tmp_right = try allocator.create(Node);
    tmp_left.* = Node{.weight = count.items[0], .val = chars.items[0], .leaf = true};
    tmp_right.* = Node{.weight = count.items[1], .val = chars.items[1], .leaf = true};

    var cur_node = try allocator.create(Node);
    cur_node.* = .{.leaf = false, .weight = tmp_left.weight + tmp_right.weight, .val = 0, .left = tmp_left, .right = tmp_right};

    var i: usize = 2;

    while(i < chars.items.len) {
        var left: *Node = undefined;
        var right: *Node = undefined;

        if (cur_node.weight < count.items[i]) {
            left = cur_node;
            right = try allocator.create(Node);
            right.* = .{.weight = count.items[i], .val = chars.items[i], .leaf = true};

        } else {
            right = cur_node;
            left = try allocator.create(Node);
            left.* = .{.weight = count.items[i], .val = chars.items[i], .leaf = true};
        }

        cur_node = try allocator.create(Node);
        cur_node.* = .{.leaf = false, .left = left, .right = right, .weight = left.weight + right.weight};

        i += 1;
    }

    return cur_node;
}


fn contain_in_list(list: *std.ArrayList(u8), c: u8) ?usize {
    for(list.items, 0..) |e, i| {
        if (e == c) {
            return i;
        }
    }
    return null;
}




pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const test_file = try std.fs.cwd().openFile("test2.txt", .{.mode = .read_only});
    defer test_file.close();
    const file_stat = try test_file.stat();
    var file_buf: [4096]u8 = undefined;
    var reader = test_file.reader(&file_buf);

    const file_cont = try reader.interface.readAlloc(allocator, file_stat.size);
    defer allocator.free(file_cont);
    if (file_cont.len != file_stat.size) {
        std.debug.print("read not anaght bytes\n", .{});
        return;
    }

    var chars = try std.ArrayList(u8).initCapacity(allocator, 255);
    defer chars.deinit(allocator);
    var count = try std.ArrayList(u32).initCapacity(allocator, 255);
    defer count.deinit(allocator);



    for(file_cont) |c| {
        if (contain_in_list(&chars, c)) |i| {
            count.items[i] += 1;
        } else {
            try chars.append(allocator, c);
            try count.append(allocator, 1);
        }
    }

    std.debug.print("Chars: {any}\n", .{chars});
    std.debug.print("Counts: {any}\n", .{count});
    sort_lists(&chars, &count);
    std.debug.print("Chars: {any}\n", .{chars});
    std.debug.print("Counts: {any}\n", .{count});
    const node = try buildHuffmanTree(&chars, &count, allocator);
    std.debug.print("Chars: {any}\n", .{chars});
    std.debug.print("Counts: {any}\n", .{count});
    std.debug.print("{any}\n", .{node});

    std.debug.print("\n\n\n", .{});
    printHuffmanTree(node);
    deleteHuffmanTree(node, allocator);

}
