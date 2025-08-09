const std = @import("std");


pub const Vec3 = @Vector(3, f64);
pub const Point3 = Vec3;
const BufWriter = std.io.BufferedWriter(4096, std.fs.File.Writer);

pub fn write_color(writer: *BufWriter, v: Vec3) !void {
    try writer.writer().print("{d} {d} {d}\n", .{
        @as(i32, @intFromFloat(255.999 * v[0])),
        @as(i32, @intFromFloat(255.999 * v[1])),
        @as(i32, @intFromFloat(255.999 * v[2]))
    });
}
