const std = @import("std");
const print = std.debug.print;

const EXIT_FAILURE = 1;

pub fn main() !void {
    print("Begin\n", .{});
    const f = std.fs.cwd().openFile("filetest.zig", .{}) catch |err| {
        print("Error while open file {}\n", .{err});
        std.posix.exit(EXIT_FAILURE);
    };

    const reader = f.reader();
    var buf: [512:0]u8 = .{0} ** 512;

    while (reader.readUntilDelimiterOrEof(&buf, '\n')) |number| {
        if (number == null) {
            break;
        } else {
            print("Read: {s}\n", .{number.?});
        }
    } else |err| {
        print("Error while read file {}\n", .{err});
    }
}
