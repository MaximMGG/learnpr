const std = @import("std");

pub fn main() !void {

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    //_ = try std.fs.cwd().createFile("test.txt", .{});
    var file = std.fs.cwd().openFile("test.txt", .{.mode = .read_write}) catch |err| blk: {
        switch(err) {
            error.FileNotFound => {
                break :blk try std.fs.cwd().createFile("test.txt", .{});
            },
            else => {return;}
        }
    };
    // const end_seek = try file.getEndPos();
    // try file.seekTo(end_seek);
    defer file.close();

    try file.seekFromEnd(0);
    var file_writer = std.io.bufferedWriter(file.writer());
    const bufwriter = file_writer.writer();


    const msg = "This is super msg, and I whant to repeat it several temes - PP\n" ** 40;
    try bufwriter.writeAll(msg);
    try file_writer.flush();

    std.debug.print("File - {d}\n", .{@as(u64, @intCast(file.handle))});

    if (args.len < 2) {

    } else {
        if (std.mem.eql(u8, args[1][0..2], "-d")) {
            try std.fs.cwd().deleteFile("test.txt");
        }
    }
}
