const std = @import("std");
var del: u8 = ' ';

fn print_fields(allocator: std.mem.Allocator, reader: *std.Io.Reader, field_count: usize) !void {
    
    _ = allocator;
    var line = try reader.takeDelimiterExclusive('\n');
    while(line.len != 0) {
        var beg_index: usize = 0;
        var index: usize = 0;
        for(0..field_count) |_| {
            beg_index = index;
            index = std.mem.indexOfScalar(u8, line, del).?;
        }
        std.debug.print("{s}\n", .{line[beg_index + 1..index]});
    }
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);


    if (args.len <= 2) {
        std.debug.print("Usage: cat [flags...] file_name", .{});
        return;
    }

    const file = try std.fs.cwd().openFile(args[args.len - 1], .{.mode = .read_only});
    defer file.close();

    var buf: [4096]u8 = undefined;
    var file_reader = file.reader(&buf);
    const reader = &file_reader.interface;
    try print_fields(allocator, reader, 2);

}

