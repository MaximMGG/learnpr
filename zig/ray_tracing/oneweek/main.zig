const std = @import("std");

const stdout = std.io.getStdOut().writer();
const errout = std.io.getStdErr().writer();

const BufWriter = std.io.BufferedWriter(4096, std.fs.File.Writer);

const Vec3 = @Vector(3, f64);

fn write_color(writer: *BufWriter, v: Vec3) !void {
    try writer.writer().print("{d} {d} {d}\n", .{
        @as(i32, @intFromFloat(255.999 * v[0])),
        @as(i32, @intFromFloat(255.999 * v[1])),
        @as(i32, @intFromFloat(255.999 * v[2]))
    });
}



pub fn main() !void {
    const image_width: i32 = 256;
    const image_height: i32 = 256;

    try stdout.print("P3\n{d} {d}\n255\n", .{image_width, image_height});
    var bw = std.io.bufferedWriter(stdout);
    defer bw.flush() catch {};

    for(0..image_height) |j| {
        try errout.print("\rScanlines remaining: {d}", .{image_height - j});
        for(0..image_width) |i| {
            const vec = Vec3{
                @as(f64, @floatFromInt(i)) / (image_width - 1),
                @as(f64, @floatFromInt(j)) / (image_height - 1),
                0.0
            };
            try write_color(&bw, vec);
            //std.debug.print("{any}\n", .{@typeInfo(@TypeOf(writer))});
        }
    }
}
