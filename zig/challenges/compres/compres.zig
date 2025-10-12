const std = @import("std");

pub fn sort_lists(chars: *std.ArrayList(u8), count: *std.ArrayList(u32)) void {
    var start: usize = 0;
    const end: usize = chars.items.len;
    var char_slice = chars.items[start..end];
    var count_slice = count.items[start..end];

    while(char_slice.len > 1) {
        var min: u32 = 1 << 31;
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
}

const Node = struct {
    weight: u32,
    val:    u8,
    leaf:   bool,
    left:   ?*Node = null,
    right:  ?*Node = null,
};

pub fn buildHuffmanTree(chars: *std.ArrayList(u8), count: *std.ArrayList(u32)) Node {
    var cur_node: Node = undefined;
    cur_node.left.?.* = Node{.weight = count.items[0], .val = chars.items[0], .leaf = true};
    cur_node.right.?.* = Node{.weight = count.items[1], .val = chars.items[1], .leaf = true};
    cur_node.leaf = false;
    cur_node.weight = cur_node.left.?.weight + cur_node.right.?.weight;
    cur_node.val = 0;

    var i: usize = 2;

    while(i < chars.items.len) {
        var left: Node = undefined;
        var right: Node = undefined;

        if (cur_node.weight < count.items[i]) {
            left = cur_node;
            right = .{.weight = count.items[i], .val = chars.items[i], .leaf = true};

        } else {
            right = cur_node;
            left = .{.weight = count.items[i], .val = chars.items[i], .leaf = true};
        }

        cur_node.weight = left.weight + right.weight;
        cur_node.leaf = false;
        cur_node.left.?.* = left;
        cur_node.right.?.* = right;

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

    sort_lists(&chars, &count);
    const node = buildHuffmanTree(&chars, &count);

    std.debug.print("{any}\n", .{node});
}
