const std = @import("std");
const math = std.math;



pub fn Vec2(comptime T: type) type {
    return struct {
        const Self = @This();
        data: [2]T,

        pub fn init(val: [2]T) Self {
            return Self{
                .data = val
            };
        }
    };
}


pub fn hypot(args: anytype) f64 {
    const args_type = @TypeOf(args);
    const info = @typeInfo(args_type);
    if (info != .@"struct" || !info.@"struct".is_tuple) {
        @compileError("Exept multiple arguments");
    }

    var max: f32 = 0.0;

    inline for (info.@"struct".fields) |field| {
        const val = @as(f32, @field(f32, field.name));
        if (math.isNan(val)) return math.nan(f32);
        if (math.isInf(val)) return math.inf(f32);
        if (val > max) max = val;
    }

    if (max == 0.0) return 0.0;

    var sum_squares: f32 = 0.0;

    inline for (info.@"struct".fields) |field| {
        const val = @as(f32, @field(f32, field.name));
        sum_squares += val * val;
    }

    return math.sqrt(sum_squares) * max;
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


    pub fn copy(self: *Self) Self {
        return self;
    }

    pub fn add(self: *Self, other: vec4) void {
        self.data[0] += other.data[0];
        self.data[1] += other.data[1];
        self.data[2] += other.data[2];
        self.data[3] += other.data[3];
    }

    pub fn sub(self: *Self, other: vec4) void {
        self.data[0] -= other.data[0];
        self.data[1] -= other.data[1];
        self.data[2] -= other.data[2];
        self.data[3] -= other.data[3];
    }

    pub fn mul(self: *Self, other: vec4) void {
        self.data[0] *= other.data[0];
        self.data[1] *= other.data[1];
        self.data[2] *= other.data[2];
        self.data[3] *= other.data[3];
    }

    pub fn div(self: *Self, other: vec4) void {
        self.data[0] /= other.data[0];
        self.data[1] /= other.data[1];
        self.data[2] /= other.data[2];
        self.data[3] /= other.data[3];
    }

    pub fn scale(self: *Self, val: f32) void {
        self.data[0] *= val;
        self.data[1] *= val;
        self.data[2] *= val;
        self.data[3] *= val;
    }

    pub fn scaleAdd(self: *Self, other: vec4, val: f32) void {
        self.data[0] += other.data[0] * val;
        self.data[1] += other.data[1] * val;
        self.data[2] += other.data[2] * val;
        self.data[3] += other.data[3] * val;
    }
    
    pub fn distance(self: *Self, other: vec4) f32 {
        const x = self.data[0] - other.data[0];
        const y = self.data[1] - other.data[1];
        const z = self.data[2] - other.data[2];
        const w = self.data[3] - other.data[3];

        return hypot(.{x, y, z, w});
    }

    pub fn squareDistance(self: *Self, other: vec4) f32 {
        const x = self.data[0] - other.data[0];
        const y = self.data[1] - other.data[1];
        const z = self.data[2] - other.data[2];
        const w = self.data[3] - other.data[3];

        return x * x + y * y + z * z + w * w;
    }

    pub fn negative(self: *Self) void {
        self.data[0] *= -1;
        self.data[1] *= -1;
        self.data[2] *= -1;
        self.data[3] *= -1;
    }

    pub fn invert(self: *Self) void {
        self.data[0] = 1.0 / self.data[0];
        self.data[1] = 1.0 / self.data[1];
        self.data[2] = 1.0 / self.data[2];
        self.data[3] = 1.0 / self.data[3];
    }

    pub fn abs(self: *Self) void {
        if (self.data[0] < 0.0) self.data[0] *= -1;
        if (self.data[1] < 0.0) self.data[1] *= -1;
        if (self.data[2] < 0.0) self.data[2] *= -1;
        if (self.data[3] < 0.0) self.data[3] *= -1;
    }

    pub fn dot(self: *Self, other: vec4) f32 {
        return self.data[0] * other.data[0] + 
               self.data[1] * other.data[1] + 
               self.data[2] * other.data[2] + 
               self.data[3] * other.data[3];

    }
    
    pub fn normalize(self: *Self) void {
        const x = self.data[0];
        const y = self.data[1];
        const z = self.data[2];
        const w = self.data[3];

        var len = x * x + y * y + z * z + w * w;
        if (len > 0) {
            len = 1 / math.sqrt(len);
        }

        self.data[0] = x * len;
        self.data[1] = y * len;
        self.data[2] = w * len;
        self.data[3] = z * len;
    }

    pub fn zero(self: *Self) void {
        self.data[0] = 0.0;
        self.data[1] = 0.0;
        self.data[2] = 0.0;
        self.data[3] = 0.0;
    }
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


pub fn Vec4(val: [4]f32) vec4 {
    return .{val};
}

pub fn Mat4(val: [4][4]f32) void {
    return .{val};
}
