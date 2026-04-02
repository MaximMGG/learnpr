const std = @import("std");
const Vector = @import("vec.zig");
const Vec3 = Vector.Vec3;
const Point3 = Vector.Point3;


pub const Ray = struct {
    orig: Point3,
    dir: Vec3,

    pub fn init(origin: *Point3, direction: *Vec3) Ray{
        return Ray{.orig = origin.*, .dir = direction.*};
    }

    pub fn at(self: *Ray, t: f64) Point3 {
        return self.orig + (@as(Vec3, .{t, t, t}) * self.dir);
    }

};
