const std = @import("std");
const Vector = @import("vec.zig");
const ray = @import("ray.zig");

const stdout = std.io.getStdOut().writer();
const errout = std.io.getStdErr().writer();

const Vec3 = Vector.Vec3;
const Point3 = Vector.Point3;
const Ray = ray.Ray;




pub fn main() !void {

    const image_width = 256;
    const image_height = 256;

    // Image

    // const aspect_ratio = 16.0 / 9.0;
    // const image_width: i32 = 400;
    //
    // var image_height: i32 = @intFromFloat(image_width / aspect_ratio);
    // image_height = if (image_height < 1) 1 else image_height;
    //
    // // Camera
    //
    // const focal_length = 1.0;
    // const viewport_height = 2.0;
    // const viewport_width = viewport_height * @as(f64, @floatFromInt(image_width / image_height));
    // const camera_center = Point3{0, 0, 0};
    //
    // const viewport_u = Vec3{viewport_width, 0, 0};
    // const viewport_v = Vec3{0, -viewport_height, 0};
    //
    // const pixel_delta_u = viewport_u / @as(Vec3, .{
    //     @as(f64, @floatFromInt(image_width)), 
    //     @as(f64, @floatFromInt(image_width)), 
    //     @as(f64, @floatFromInt(image_width))
    // });
    //
    // const pixel_delta_v = viewport_v / @as(Vec3, .{
    //     @as(f64, @floatFromInt(image_height)), 
    //     @as(f64, @floatFromInt(image_height)), 
    //     @as(f64, @floatFromInt(image_height))
    // });


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
            try Vector.write_color(&bw, vec);
            //std.debug.print("{any}\n", .{@typeInfo(@TypeOf(writer))});
        }
    }
    try errout.print("\rDone.           \n", .{});
}
