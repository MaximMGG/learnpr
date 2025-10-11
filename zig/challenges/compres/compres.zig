const std = @import("std");

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
    const test_file = try std.fs.cwd().openFile("test.txt", .{.mode = .read_only});
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

    var total: u64 = 0;
    for(chars.items, count.items) |c, i| {
        std.debug.print("Char: {d} - {d}\n", .{@as(u32, @intCast(c)), i});
        total += i;
    }
    std.debug.print("Total chars: {d}\n", .{total});
}
