const std = @import("std");

fn Mat4(comptime T: type) type {
    return struct {
        const Self = @This();
        data: [16]T,

        pub fn init(val: [16]T) Self {
            return .{
                .data = val,
            };
        }

        pub fn mul(self: *Self, o: Mat4(T)) void {
            const x1 = self.data[0] * o.data[0] + self.data[1] * o.data[4] + self.data[2] * o.data[8] + self.data[3] * o.data[12];
            const x2 = self.data[0] * o.data[1] + self.data[1] * o.data[5] + self.data[2] * o.data[9] + self.data[3] * o.data[13];
            const x3 = self.data[0] * o.data[2] + self.data[1] * o.data[6] + self.data[2] * o.data[10] + self.data[3] * o.data[14];
            const x4 = self.data[0] * o.data[3] + self.data[1] * o.data[7] + self.data[2] * o.data[11] + self.data[3] * o.data[15];

            const x5 = self.data[4] * o.data[0] + self.data[5] * o.data[4] + self.data[6] * o.data[8] + self.data[7] * o.data[12];
            const x6 = self.data[4] * o.data[1] + self.data[5] * o.data[5] + self.data[6] * o.data[9] + self.data[7] * o.data[13];
            const x7 = self.data[4] * o.data[2] + self.data[5] * o.data[6] + self.data[6] * o.data[10] + self.data[7] * o.data[14];
            const x8 = self.data[4] * o.data[3] + self.data[5] * o.data[7] + self.data[6] * o.data[11] + self.data[7] * o.data[15];

            const x9 = self.data[8] * o.data[0] + self.data[9] * o.data[4] + self.data[10] * o.data[8] + self.data[11] * o.data[12];
            const x10 = self.data[8] * o.data[1] + self.data[9] * o.data[5] + self.data[10] * o.data[9] + self.data[11] * o.data[13];
            const x11 = self.data[8] * o.data[2] + self.data[9] * o.data[6] + self.data[10] * o.data[10] + self.data[11] * o.data[14];
            const x12 = self.data[8] * o.data[3] + self.data[9] * o.data[7] + self.data[10] * o.data[11] + self.data[11] * o.data[15];

            const x13 = self.data[12] * o.data[0] + self.data[13] * o.data[4] + self.data[14] * o.data[8] + self.data[15] * o.data[12];
            const x14 = self.data[12] * o.data[1] + self.data[13] * o.data[5] + self.data[14] * o.data[9] + self.data[15] * o.data[13];
            const x15 = self.data[12] * o.data[2] + self.data[13] * o.data[6] + self.data[14] * o.data[10] + self.data[15] * o.data[14];
            const x16 = self.data[12] * o.data[3] + self.data[13] * o.data[7] + self.data[14] * o.data[11] + self.data[15] * o.data[15];

            self.data[0] = x1;
            self.data[1] = x2;
            self.data[2] = x3;
            self.data[3] = x4;
            self.data[4] = x5;
            self.data[5] = x6;
            self.data[6] = x7;
            self.data[7] = x8;
            self.data[8] = x9;
            self.data[9] = x10;
            self.data[10] = x11;
            self.data[11] = x12;
            self.data[12] = x13;
            self.data[13] = x14;
            self.data[14] = x15;
            self.data[15] = x16;

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
        // std.debug.print("{any}\n", .{m});
    }
}
