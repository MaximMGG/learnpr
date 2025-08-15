const std = @import("std");
const filelog = std.filelog.Logger;



pub fn main() !void {
    var logger = try filelog.init("test_file.txt");
    defer logger.deinit();


    try logger.log(.ERROR, "Tets log {d}", .{0});

}
