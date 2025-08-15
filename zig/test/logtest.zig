const std = @import("std");
const filelog = std.filelog.Logger;



pub fn main() !void {
    var logger = try filelog.init("test_file.txt");
    defer logger.deinit();


    try logger.log(.ERROR, @src(), "Tets log {d}", .{0});
    try logger.log(.WARN, @src(), "Test log2 {d}", .{0});

}
