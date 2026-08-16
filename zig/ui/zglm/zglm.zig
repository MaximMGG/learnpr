const std = @import("std");
const math = std.math;

pub fn Vec2(comptime T: type) type {
    return struct {
        const Self = @This();
        data: @Vector(2, T),

        pub fn init(val: [2]T) Self {
            return Self{
                .data = val
            };
        }
    };
}

pub fn Vec3(comptime T: type) type {
    return struct {
        const Self = @This();
        data: @Vector(3, T),

        pub fn init(val: [3]T) Self {
            return .{
              .data = val  
            };
        }
    };
}

pub fn Vec4(comptime T: type) type {
    return struct {
        const Self = @This();
        data: @Vector(4, T),

        pub fn init(val: [4]T) Self {
            return .{
                .data = val  
            };
        }

        pub fn add(self: *Self, other: Vec4(T)) void {
            self.data += other.data;
        }

        pub fn copy(self: *Self) Self {
            return Vec4(T).init(self.data);
        }
        
        pub fn sub(self: *Self, other: Vec4(T)) void {
            self.data -= other.data;
        }

        pub fn mul(self: *Self, other: Vec4(T)) void {
            self.data *= other.data;
        }

        pub fn div(self: *Self, other: Vec4(T)) void {
            self.data /= other.data;
        }

        pub fn scale(self: *Self, val: f32) void {
            self.data *= @splat(val);
        }

        pub fn scaleAdd(self: *Self, other: Vec4(T), val: f32) void {
            self.data += other.data * @as(@Vector(4, T), @splat(val));
        }
    
        pub fn distance(self: *Self, other: Vec4(T)) T {
            const res = self.data - other.data;
            const pow_res = res * res;
            var sum: T = 0.0;
            inline for (0..4) |i| {
                sum += pow_res[i];
            }
            return math.sqrt(sum);
        }

        pub fn negative(self: *Self) void {
            self.data *= @splat(-1.0);
        }

        pub fn invers(self: *Self) void {
            self.data = @as(@Vector(4, T), @splat(1.0)) / self.data;
        }

        pub fn abs(self: *Self) void {
            if (self.data[0] < 0.0) self.data[0] *= -1;
            if (self.data[1] < 0.0) self.data[1] *= -1;
            if (self.data[2] < 0.0) self.data[2] *= -1;
            if (self.data[3] < 0.0) self.data[3] *= -1;
        }

        pub fn dot(self: *Self, other: Vec4(T)) f32  {
            return self.data[0] * other.data[0] + 
                   self.data[1] * other.data[1] + 
                   self.data[2] * other.data[2] + 
                   self.data[3] * other.data[3];

        }
    
        pub fn normalize(self: *Self) void {
            const len = blk: {
                const t = self.data * self.data;
                var sum: T = 0.0;
                inline for (0..4) |i| {
                    sum += t[i];
                }
                if (sum > 0) {
                    sum = math.sqrt(sum);
                }
                break :blk sum;
            };

            std.debug.print("Len: {d}\n", .{len});
            self.data = self.data / @as(@Vector(4, T), @splat(len));
            std.debug.print("{any}\n", .{self.data});
        }

        pub fn zero(self: *Self) void {
            self.data = .{0, 0 ,0 , 0};
        }
    };
}

pub const MAT4_IDENTICAL = .{
    .{1.0, 0.0, 0.0, 0.0},
    .{0.0, 1.0, 0.0, 0.0},
    .{0.0, 0.0, 1.0, 0.0},
    .{0.0, 0.0, 0.0, 1.0}
};

pub const mat4 = struct {
    const Self = @This();
    data: [4][4]f32,
};


pub const vec4 = struct {
    const Self = @This();
    data: [4]f32,



};

pub fn cross(u: vec4, v: vec4, w: vec4) vec4 {
    var out: vec4 = undefined;

    const a = v.data[0] * w.data[1] - v.data[1] * w.data[0];
    const b = v.data[0] * w.data[2] - v.data[2] * w.data[0];
    const c = v.data[0] * w.data[3] - v.data[3] * w.data[0];
    const d = v.data[1] * w.data[2] - v.data[2] * w.data[1];
    const e = v.data[1] * w.data[3] - v.data[3] * w.data[1];
    const f = v.data[2] * w.data[3] - v.data[3] * w.data[2];
    const g = u[0];
    const h = u[1];
    const i = u[2];
    const j = u[3];

    out.data[0] = h * f - i * e + j * d;
    out.data[1] = -(g * f) + i * c - j * b;
    out.data[2] = h * e - h * c + j * a;
    out.data[3] = -(g * d) + h * b - i * a;

    return out;
}

pub fn lerp(a: vec4, b: vec4, val: f32) vec4 {
    var out: vec4 = undefined;

    const ax = a.data[0];
    const ay = a.data[1];
    const az = a.data[2];
    const aw = a.data[3];

    out[0] = ax + val * (b.data[0] - ax);
    out[1] = ay + val * (b.data[1] - ay);
    out[2] = az + val * (b.data[2] - aw);
    out[3] = aw + val * (b.data[3] - az);
    return out;
}

pub fn transformFromMat4(a: vec4, m: mat4) vec4 {
    var out: vec4 = undefined;
    const x = a.data[0];
    const y = a.data[1];
    const z = a.data[2];
    const w = a.data[3];

    out.data[0] = m[0][0] * x + m[1][0] * y + m[2][0] * z + m[3][0] * w;
    out.data[1] = m[0][1] * x + m[1][1] * y + m[2][1] * z + m[3][1] * w;
    out.data[2] = m[0][2] * x + m[1][2] * y + m[2][2] * z + m[3][2] * w;
    out.data[3] = m[0][3] * x + m[1][3] * y + m[2][3] * z + m[3][3] * w;
    return out;
}

pub fn Mat4(val: [4][4]f32) void {
    return .{val};
}






const testing = @import("std").testing;


//Vec4 implementation tests begins
const VEC4_INIT_VAL = .{0.1, 0.1, 0.1, 0.1};

test "Vec4_init" {
    const v = Vec4(f32).init(VEC4_INIT_VAL);
    try testing.expectEqual(v.data, VEC4_INIT_VAL);
}

test "Vec4_add" {
    var v = Vec4(f32).init(VEC4_INIT_VAL);
    v.add(Vec4(f32).init(VEC4_INIT_VAL));
    try testing.expectEqual(v.data, .{0.2, 0.2, 0.2, 0.2});
}

test "Vec4_copy" {
    var v = Vec4(f32).init(VEC4_INIT_VAL);
    const v2 = v.copy();
    try testing.expectEqual(v.data, v2.data);
}

test "Vec4_sub" {
    var v = Vec4(f32).init(VEC4_INIT_VAL);
    v.sub(Vec4(f32).init(.{0.05, 0.05, 0.05, 0.05}));
    try testing.expectEqual(v.data, .{0.05, 0.05, 0.05, 0.05});
}

test "Vec4_mul" {
    var v = Vec4(f32).init(VEC4_INIT_VAL);
    v.mul(Vec4(f32).init(.{0.05, 0.05, 0.05, 0.05}));
    try testing.expectApproxEqRel(v.data[0], 0.005, 0.001);
    try testing.expectApproxEqRel(v.data[1], 0.005, 0.001);
    try testing.expectApproxEqRel(v.data[2], 0.005, 0.001);
    try testing.expectApproxEqRel(v.data[3], 0.005, 0.001);
}

test "Vec4_div" {
    var v = Vec4(f32).init(VEC4_INIT_VAL);
    v.div(Vec4(f32).init(.{0.05, 0.05, 0.05, 0.05}));
    try testing.expectEqual(v.data, .{2.0, 2.0, 2.0, 2.0});
}
test "Vec4_scale" {
    var v = Vec4(f32).init(VEC4_INIT_VAL);
    v.scale(2.0);
    try testing.expectEqual(v.data, .{0.2, 0.2, 0.2, 0.2});
}
test "Vec4_scaleAdd" {
    var v = Vec4(f32).init(VEC4_INIT_VAL);
    v.scaleAdd(Vec4(f32).init(.{2.0, 2.0, 2.0, 2.0}), 2.0);
    try testing.expectEqual(v.data, .{4.1, 4.1, 4.1, 4.1});
}
test "Vec4_distance" {
    var v = Vec4(f32).init(.{6.3, 6.3, 6.3, 6.3});
    const res = v.distance(Vec4(f32).init(.{2.0, 2.0, 2.0, 2.0}));
    try testing.expectEqual(res, 8.6);
}

test "Vec4_negative" {
    var v = Vec4(f32).init(.{6.3, 6.3, 6.3, 6.3});
    v.negative();
    try testing.expectEqual(v.data, .{-6.3, -6.3, -6.3, -6.3});
}
test "Vec4_invers" {
    var v = Vec4(f32).init(.{6.3, 6.3, 6.3, 6.3});
    v.invers();
    try testing.expectEqual(v.data, .{0.15873015, 0.15873015, 0.15873015, 0.15873015});
}

test "Vec4_abs" {
    var v = Vec4(f32).init(.{6.3, -6.3, 6.3, -6.3});
    v.abs();
    try testing.expectEqual(v.data, .{6.3, 6.3, 6.3, 6.3});
}

test "Vec4_dot" {
    var v = Vec4(f32).init(.{2.0, 2.0, 2.0, 2.0});
    const res = v.dot(Vec4(f32).init(.{2.0, 2.0, 2.0, 2.0}));
    try testing.expectEqual(res, 16.0);
}

test "Vec4_normalize" {
    var v = Vec4(f32).init(.{2.0, 2.0, 2.0, 2.0});
    v.normalize();
    try testing.expectEqual(v.data, .{0.1, 0.1, 0.1, 0.1});
}
test "Vec4_zero" {
    
}
//Vec4 implementation tests ends








