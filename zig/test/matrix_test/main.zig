const std = @import("std");

fn Mat4(comptime T: type) type {
    return struct {
        const Self = @This();
        data: @Vector(16, T),

        pub fn init(val: [16]T) Self {
            return .{
                .data = val,
            };
        }

        pub fn mul(self: *Self, other: Mat4(T)) void {
            const a = @Vector(4, T){other.data[0], other.data[4], other.data[8], other.data[12]};
            const b = @Vector(4, T){other.data[1], other.data[5], other.data[9], other.data[13]};
            const c = @Vector(4, T){other.data[2], other.data[6], other.data[10], other.data[14]};
            const d = @Vector(4, T){other.data[3], other.data[7], other.data[11], other.data[15]};

            var x1 = @Vector(4, T){self.data[0], self.data[1], self.data[2], self.data[3]} * a;
            var x2 = @Vector(4, T){self.data[0], self.data[1], self.data[2], self.data[3]} * b;
            var x3 = @Vector(4, T){self.data[0], self.data[1], self.data[2], self.data[3]} * c;
            var x4 = @Vector(4, T){self.data[0], self.data[1], self.data[2], self.data[3]} * d;
            self.data[0] = x1[0] + x1[1] + x1[2] + x1[3];
            self.data[1] = x2[0] + x2[1] + x2[2] + x2[3];
            self.data[2] = x3[0] + x3[1] + x3[2] + x3[3];
            self.data[3] = x4[0] + x4[1] + x4[2] + x4[3];

            x1 = @Vector(4, T){self.data[4], self.data[5], self.data[6], self.data[7]} * a;
            x2 = @Vector(4, T){self.data[4], self.data[5], self.data[6], self.data[7]} * b;
            x3 = @Vector(4, T){self.data[4], self.data[5], self.data[6], self.data[7]} * c;
            x4 = @Vector(4, T){self.data[4], self.data[5], self.data[6], self.data[7]} * d;
            self.data[4] = x1[0] + x1[1] + x1[2] + x1[3];
            self.data[5] = x2[0] + x2[1] + x2[2] + x2[3];
            self.data[6] = x3[0] + x3[1] + x3[2] + x3[3];
            self.data[7] = x4[0] + x4[1] + x4[2] + x4[3];

            x1 = @Vector(4, T){self.data[8], self.data[9], self.data[10], self.data[11]} * a;
            x2 = @Vector(4, T){self.data[8], self.data[9], self.data[10], self.data[11]} * b;
            x3 = @Vector(4, T){self.data[8], self.data[9], self.data[10], self.data[11]} * c;
            x4 = @Vector(4, T){self.data[8], self.data[9], self.data[10], self.data[11]} * d;
            self.data[8] = x1[0] + x1[1] + x1[2] + x1[3];
            self.data[9] = x2[0] + x2[1] + x2[2] + x2[3];
            self.data[10] = x3[0] + x3[1] + x3[2] + x3[3];
            self.data[11] = x4[0] + x4[1] + x4[2] + x4[3];

            x1 = @Vector(4, T){self.data[12], self.data[13], self.data[14], self.data[15]} * a;
            x2 = @Vector(4, T){self.data[12], self.data[13], self.data[14], self.data[15]} * b;
            x3 = @Vector(4, T){self.data[12], self.data[13], self.data[14], self.data[15]} * c;
            x4 = @Vector(4, T){self.data[12], self.data[13], self.data[14], self.data[15]} * d;
            self.data[12] = x1[0] + x1[1] + x1[2] + x1[3];
            self.data[13] = x2[0] + x2[1] + x2[2] + x2[3];
            self.data[14] = x3[0] + x3[1] + x3[2] + x3[3];
            self.data[15] = x4[0] + x4[1] + x4[2] + x4[3];
        }
    };
}

const m1 = Mat4(f32).init(.{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16});
const m2 = Mat4(f32).init(.{17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32});
const ITERATIONS = 10000;

pub fn main() void {

    for(0..ITERATIONS) |_| {
        var m = Mat4(f32).init(m1.data);
        m.mul(m2);
        std.debug.print("{any}\n", .{m});
    }
}
