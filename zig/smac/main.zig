const std = @import("std");
const stdout = std.io.getStdOut().writer();
const heap_allo = std.heap.page_allocator;



pub fn main() !void {
    const X = 4;
    var t: [X]std.Thread = undefined;

    var list: [X]std.ArrayList(u8) = undefined;

    var index:u32 = 0;

    while(index < X) : (index += 1) {
        list[index] = std.ArrayList(u8).init(heap_allo);
        defer list[index].deinit();
        t[index] = try std.Thread.spawn(.{}, count_it, .{index, &list[index]});

    }
    index = 0;
    while(index < X) : (index += 1) {
        t[index].join();
        try print_list(&list[index]);
        list[index].clearAndFree();
    }
}

fn count_it(id: u32, list: *std.ArrayList(u8)) !void {
    var addr: usize = 0;
    if (id == 3) addr += 1;

    var index: usize = id * 250000;
    while(index < (id * 250_000 + 250000 + addr)) : (index += 1) {
        if (index == 0) continue;
        if (index % 10 == 7 or index % 7 == 0) {
            try list.writer().print("{s}\n", .{"SMAC"});
        } else {
            try list.writer().print("{d}\n", .{index});
        }
    }
}



fn print_list(list: *std.ArrayList(u8)) !void {
    var iter = std.mem.splitSequence(u8, list.items, "\n");
    while(iter.next()) |item| {
        try stdout.print("{s}\n", .{item});
    }
}
