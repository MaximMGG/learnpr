const std = @import("std");

var user_name: [128]u8 = .{0} ** 128;
const tmplate = "/home/{s}/.local/share/";

pub fn main() !void {
    var buf: [128]u8 = .{0} ** 128; 
    const cwd = try std.posix.getcwd(&buf);
    var index = std.mem.indexOfScalar(u8, cwd[1..cwd.len], '/') orelse return;
    index += 2;
    for(0..user_name.len) |i| {
        if (cwd[index] == '/') {
            break;
        }
        user_name[i] = cwd[index];
        index += 1;
    }

    @memset(&buf, 0);

    
    const full_path = try std.fmt.bufPrint(&buf, tmplate, .{user_name[0..6]});
    std.debug.print("{s}\n", .{full_path});
}
