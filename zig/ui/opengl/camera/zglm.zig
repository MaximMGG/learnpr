const std = @import("std");
const math = std.math;


//TODO
//Vec2[x]
//Vec3[x]
//Vec4[x]
//Mat4[x]
//dot[x]
//cross[] for Vec3[x]
//normalize for vec2[x], vec3[x], vec4[x] done[x]
//translate[x]
//rotate[x]
//scale[x]
//ortho[x]
//perspective[x]
//lookAt[x]

const TAU = 6.28318530717958647692528676655900576;
const RAD_PER_DEG = TAU/360.0;

pub fn to_rad(value: anytype) @TypeOf(value) {
    return @as(@TypeOf(value), value * @as(@TypeOf(value), RAD_PER_DEG));
}

pub fn Vec2(comptime T: type) type {
    return struct {
        const Self = @This();
        data: @Vector(2, T),

        pub fn init(val: [2]T) Self {
            return Self{
                .data = val
            };
        }

        pub fn add(self: *Self, other: Vec2(T)) void {
            self.data += other.data;
        }

        pub fn copy(self: *Self) Self {
            return Vec2(T).init(self.data);
        }
        
        pub fn sub(self: *Self, other: Vec2(T)) void {
            self.data -= other.data;
        }

        pub fn mul(self: *Self, other: Vec2(T)) void {
            self.data *= other.data;
        }

        pub fn div(self: *Self, other: Vec2(T)) void {
            self.data /= other.data;
        }

        pub fn scale(self: *Self, val: T) void {
            self.data *= @splat(val);
        }

        pub fn scaleAdd(self: *Self, other: Vec2(T), val: T) void {
            self.data += other.data * @as(@Vector(2, T), @splat(val));
        }
    
        pub fn distance(self: *Self, other: Vec2(T)) T {
            const res = self.data - other.data;
            const pow_res = res * res;
            var sum: T = 0.0;
            inline for (0..2) |i| {
                sum += pow_res[i];
            }
            return math.sqrt(sum);
        }

        pub fn negative(self: *Self) void {
            self.data *= @splat(-1.0);
        }

        pub fn invers(self: *Self) void {
            self.data = @as(@Vector(2, T), @splat(1.0)) / self.data;
        }

        pub fn abs(self: *Self) void {
            if (self.data[0] < 0.0) self.data[0] *= -1;
            if (self.data[1] < 0.0) self.data[1] *= -1;
        }

        pub fn dot(self: *Self, other: Vec2(T)) T {
            return self.data[0] * other.data[0] + 
                   self.data[1] * other.data[1];
        }
    
        pub fn normalize(self: *Self) void {
            const len = blk: {
                const t = self.data * self.data;
                var sum: T = 0.0;
                inline for (0..2) |i| {
                    sum += t[i];
                }
                if (sum > 0) {
                    sum = math.sqrt(sum);
                }
                break :blk sum;
            };

            self.data = self.data / @as(@Vector(2, T), @splat(len));
        }

        pub fn zero(self: *Self) void {
            self.data = .{0, 0};
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

        pub fn add(self: *Self, other: Vec3(T)) void {
            self.data += other.data;
        }

        pub fn copy(self: *Self) Self {
            return Vec3(T).init(self.data);
        }
        
        pub fn sub(self: *Self, other: Vec3(T)) void {
            self.data -= other.data;
        }

        pub fn mul(self: *Self, other: Vec3(T)) void {
            self.data *= other.data;
        }

        pub fn div(self: *Self, other: Vec3(T)) void {
            self.data /= other.data;
        }

        pub fn scale(self: *Self, val: T) void {
            self.data *= @splat(val);
        }

        pub fn scaleAdd(self: *Self, other: Vec3(T), val: T) void {
            self.data += other.data * @as(@Vector(3, T), @splat(val));
        }
    
        pub fn distance(self: *Self, other: Vec3(T)) T {
            const res = self.data - other.data;
            const pow_res = res * res;
            var sum: T = 0.0;
            inline for (0..3) |i| {
                sum += pow_res[i];
            }
            return math.sqrt(sum);
        }

        pub fn negative(self: *Self) void {
            self.data *= @splat(-1.0);
        }

        pub fn invers(self: *Self) void {
            self.data = @as(@Vector(3, T), @splat(1.0)) / self.data;
        }

        pub fn abs(self: *Self) void {
            if (self.data[0] < 0.0) self.data[0] *= -1;
            if (self.data[1] < 0.0) self.data[1] *= -1;
            if (self.data[2] < 0.0) self.data[2] *= -1;
        }

        pub fn dot(self: *Self, other: Vec3(T)) T {
            return self.data[0] * other.data[0] + 
                   self.data[1] * other.data[1] + 
                   self.data[2] * other.data[2]; 
        }
    
        pub fn normalize(self: *Self) void {
            const len = blk: {
                const t = self.data * self.data;
                var sum: T = 0.0;
                inline for (0..3) |i| {
                    sum += t[i];
                }
                if (sum > 0) {
                    sum = math.sqrt(sum);
                }
                break :blk sum;
            };

            self.data = self.data / @as(@Vector(3, T), @splat(len));
        }

        pub fn zero(self: *Self) void {
            self.data = .{0, 0, 0};
        }

        pub fn cross(a: Vec3(T), b: Vec3(T)) Vec3(T) {
            return Vec3(T).init(.{
                a.data[1] * b.data[2] - a.data[2] * b.data[1],
                a.data[2] * b.data[0] - a.data[0] * b.data[2],
                a.data[0] * b.data[1] - a.data[1] * b.data[0]
            });
        }
    };
}


pub fn vec3Sub(comptime T: type, a: Vec3(T), b: Vec3(T)) Vec3(T) {
    return Vec3(T).init(.{a.data[0] - b.data[0], a.data[1] - b.data[1], a.data[2] - b.data[2]});
}

pub fn vec3Mul(comptime T: type, a: Vec3(T), b: Vec3(T)) Vec3(T) {
    return Vec3(T).init(.{a.data[0] * b.data[0], a.data[1] * b.data[1], a.data[2] * b.data[2]});
}

pub fn vec3Add(comptime T: type, a: Vec3(T), b: Vec3(T)) Vec3(T) {
    return Vec3(T).init(.{a.data[0] + b.data[0], a.data[1] + b.data[1], a.data[2] + b.data[2]});
}

pub fn vec3Div(comptime T: type, a: Vec3(T), b: Vec3(T)) Vec3(T) {
    return Vec3(T).init(.{a.data[0] / b.data[0], a.data[1] / b.data[1], a.data[2] / b.data[2]});
}

pub fn vec3Normalize(comptime T: type, v: Vec3(T)) Vec3(T) {
    var r = Vec3(T).init(.{v.data[0], v.data[1], v.data[2]});
    r.normalize();
    return r;
}

pub fn vec3Dot(comptime T: type, a: Vec3(T), b: Vec3(T)) T {
    return a.data[0] * b.data[0] + 
           a.data[1] * b.data[1] + 
           a.data[2] * b.data[2]; 
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

        pub fn scale(self: *Self, val: T) void {
            self.data *= @splat(val);
        }

        pub fn scaleAdd(self: *Self, other: Vec4(T), val: T) void {
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

        pub fn dot(self: *Self, other: Vec4(T)) T {
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

            self.data = self.data / @as(@Vector(4, T), @splat(len));
        }

        pub fn zero(self: *Self) void {
            self.data = .{0, 0, 0, 0};
        }
    };
}


pub const MAT4_IDENTITY_INIT = .{1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1};

pub fn Mat4(comptime T: type) type {
    return struct {
        const Self = @This();
        data: @Vector(16, T),

        pub fn init(val: [16]T) Self {
            return .{
                .data = val,
            };
        }

        pub fn zero(self: *Self) void {
            self.data = @as(@Vector(16, T), @splat(0.0));
        }

        pub fn add(self: *Self, other: Mat4(T)) void {
            self.data += other.data;
        }

        pub fn sub(self: *Self, other: Mat4(T)) void {
            self.data -= other.data;
        }

        pub fn mul(self: *Self, other: Mat4(T)) void {
            var res: @Vector(16, T) = undefined;
            inline for(0..4) |col| {
                inline for(0..4) |row| {
                    res[col * 4 + row] = 
                        self.data[col * 4 + 0] * other.data[0 * 4 + row] +
                        self.data[col * 4 + 1] * other.data[1 * 4 + row] +
                        self.data[col * 4 + 2] * other.data[2 * 4 + row] +
                        self.data[col * 4 + 3] * other.data[3 * 4 + row];

                }
            }
            self.data = res;
        }

        pub fn translate(self: *Self, v: Vec3(T)) void {
            self.mul(Mat4(T).init(.{
                1, 0, 0, v.data[0],
                0, 1, 0, v.data[1],
                0, 0, 1, v.data[2],
                0, 0, 0, 1}));
        }

        pub fn scale(self: *Self, v: Vec3(T)) void {
            self.mul(Mat4(T).init(.{
                v.data[0], 0, 0, 0,
                0, v.data[1], 0, 0,
                0, 0, v.data[2], 0,
                0, 0, 0, 1
            }));
        }

        pub fn rotate(self: *Self, a: T, axis: Vec3(T)) void {
            const s = @sin(a);
            const c = @cos(a);
            const C = 1 - c;

            const ax = vec3Normalize(T, axis);
            const x = ax.data[0];
            const y = ax.data[1];
            const z = ax.data[2];

            var res = Mat4(T).init(MAT4_IDENTITY_INIT);

            res.data[0] = c + (x * x) * C;
            res.data[1] = (x * y) * C - z * s;
            res.data[2] = (x * z) * C + y * s;
            res.data[3] = 0;
            res.data[4] = (y * x) * C + z * s;
            res.data[5] = c + (y * y) * C;
            res.data[6] = (y * z) * C - x * s;
            res.data[7] = 0;
            res.data[8] = (z * x) * C - y * s;
            res.data[9] = (z * y) * C + x * s;
            res.data[10] = c + (z * z) * C;

            self.mul(res);
        }

        pub fn perspective(self: *Self, fovy: f32, aspect: f32, near: f32, far: f32) void {
            const tan_half_fovy = @tan(fovy * 0.5);

            const f = 1.0 / tan_half_fovy;
            //const F = 1.0 / (near - far);

            var res = Mat4(f32).init(.{
                f / aspect, 0, 0, 0,
                0, f, 0, 0,
                0, 0, (far + near) / (far - near), (2 * far * near / (far - near)),
                0, 0, -1, 0
            });
            res.data[10] *= -1.0;
            res.data[11] *= -1.0;
            self.mul(res);
        }

        pub fn ortho(left: f32, right: f32, bottom: f32, top: f32, near: f32, far: f32) Mat4(T) {
            const res = Mat4(T).init(.{
                2.0 / (right - left), 0.0, 0.0, -(right + left) / (right - left),
                0.0, 2.0 / (top - bottom), 0.0, -(top + bottom) / (top - bottom),
                0.0, 0.0, -2.0 / (far - near), 0.0,
                0.0, 0.0, 0.0, 1.0
            });
            return res;
        }

        pub fn lookAt(eye: Vec3(T), center: Vec3(T), up: Vec3(T)) Mat4(T) {
            const f = vec3Normalize(T, vec3Sub(T, center, eye));
            const s = vec3Normalize(T, Vec3(T).cross(f, up));
            const u = Vec3(T).cross(s, f);

            const fe = vec3Dot(T, f, eye);

            return Mat4(T).init(.{
                s.data[0], s.data[1], s.data[2], -vec3Dot(T, s, eye),
                u.data[0], u.data[1], u.data[2], -vec3Dot(T, u, eye),
                -f.data[0], -f.data[1], -f.data[2], fe,
                0.0, 0.0, 0.0, 1.0
            });
        }
    };
}
