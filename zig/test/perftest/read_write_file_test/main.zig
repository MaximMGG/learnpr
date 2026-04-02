const std = @import("std");

const Buf = struct {
    data: []u8,
    size: usize
};


fn addToBuffer(buf: *Buf, src: []u8) bool {
    if (buf.data.len - buf.size <= src.len) {
        return false;
    }
    @memcpy(buf.data[buf.size..buf.size + src.len], src);
    buf.size += src.len;
    return true;
}


fn genAndWriteToFile(it_size: usize) !void {
    const tmp_f = try std.fs.cwd().createFile("TMP.txt", .{});
    defer tmp_f.close();
    var tmp_buf: [4096]u8 = .{0} ** 4096;
    var buf: Buf = .{.data = &tmp_buf, .size = 0};

    for(0..it_size) |_| {
        const rand_num = std.crypto.random.int(u16);
        var rand_num_buf: [128]u8 = .{0} ** 128;
        const num = try std.fmt.bufPrint(&rand_num_buf, "{d}\n", .{rand_num});
        while (!addToBuffer(&buf, num)) {
            _ = try tmp_f.write(buf.data[0..buf.size]);
            @memset(buf.data, 0);
            buf.size = 0;
        }
    }
    if (buf.size != 0) {
        _ = try tmp_f.write(buf.data[0..buf.size]);
    }
}

fn readFromFile(allocator: std.mem.Allocator) !usize {
    var res: usize = 0;
    const tmp_f = try std.fs.cwd().openFile("TMP.txt", .{.mode = .read_only});
    const tmp_r = tmp_f.reader();
    const file_cont = try tmp_r.readAllAlloc(allocator, 40960000);
    defer allocator.free(file_cont);

    var it = std.mem.splitScalar(u8, file_cont, '\n');

    while(it.next()) |num_line| {
        if (num_line.len == 0) break;
        const num = try std.fmt.parseInt(u16, num_line, 10);
        res += @intCast(num);
    }

    tmp_f.close();
    try std.fs.cwd().deleteFile("TMP.txt");

    return res;
}

pub fn main() !void {
    const allocator = std.heap.c_allocator;
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len != 3) {
        std.debug.print("Bad usage <main> <iteration count>\n", .{});
        return;
    }


    const it_count = try std.fmt.parseInt(usize, args[1], 10);
    const it_size = try std.fmt.parseInt(usize, args[2], 10);

    for(0..it_count) |i| {
        var write_to_file = try std.time.Timer.start();
        try genAndWriteToFile(it_size);
        const write_to_file_time = write_to_file.lap();
        var read_from_file = try std.time.Timer.start();
        const res = try readFromFile(allocator);
        const read_from_file_time = read_from_file.lap();
        std.debug.print("Iteration: {d}, result: {d}\n", .{i, res});
        std.debug.print("Write to file time: {d}ms\n", .{write_to_file_time / std.time.ns_per_ms});
        std.debug.print("Read from file time: {d}ms\n", .{read_from_file_time / std.time.ns_per_ms});
    }
}
