const std = @import("std");

const stdout = std.io.getStdOut().writer();
const errout = std.io.getStdErr().writer();


fn write_color(handle: ) void {

}

pub fn main() !void {
    const image_width: i32 = 256;
    const image_height: i32 = 256;

    std.io.getStdOut().handle;

    try stdout.print("P3\n{d} {d}\n255\n", .{image_width, image_height});

    for(0..image_height) |j| {
        try errout.print("\rScanlines remaining: {d}", .{image_height - j});
        for(0..image_width) |i| {
            const r: f64 = @as(f64, @floatFromInt(i)) / (image_width - 1);
            const g: f64 = @as(f64, @floatFromInt(j)) / (image_height - 1);
            const b: f64 = 0.0;

            const ir: i32 = @intFromFloat(255.999 * r);
            const ig: i32 = @intFromFloat(255.999 * g);
            const ib: i32 = @intFromFloat(255.999 * b);


            try stdout.print("{d} {d} {d}\n", .{ir, ig, ib});

        }
    }


}
