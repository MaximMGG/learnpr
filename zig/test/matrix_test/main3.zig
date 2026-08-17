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

        pub fn mul(self: *Self, o: Mat4(T)) void {
            const x = @Vector(16, T){
                o.data[4], o.data[5], o.data[6], o.data[7], 
                o.data[8], o.data[9], o.data[10], o.data[11], 
                o.data[12], o.data[13], o.data[14], o.data[15], 
                o.data[0], o.data[1], o.data[2], o.data[3], 
            };
            const y = @Vector(16, T){
                o.data[8], o.data[9], o.data[10], o.data[11], 
                o.data[12], o.data[13], o.data[14], o.data[15], 
                o.data[0], o.data[1], o.data[2], o.data[3], 
                o.data[4], o.data[5], o.data[6], o.data[7], 
            };
            const z = @Vector(16, T){
                o.data[12], o.data[13], o.data[14], o.data[15], 
                o.data[0], o.data[1], o.data[2], o.data[3], 
                o.data[4], o.data[5], o.data[6], o.data[7], 
                o.data[8], o.data[9], o.data[10], o.data[11], 
            };

            const res1 = self.data * o.data;
            const res2 = self.data * x;
            const res3 = self.data * y;
            const res4 = self.data * z;


            // const x1 = self.data[0] * o.data[0] + self.data[1] * o.data[4] + self.data[2] * o.data[8] + self.data[3] * o.data[12];
            // const x2 = self.data[0] * o.data[1] + self.data[1] * o.data[5] + self.data[2] * o.data[9] + self.data[3] * o.data[13];
            // const x3 = self.data[0] * o.data[2] + self.data[1] * o.data[6] + self.data[2] * o.data[10] + self.data[3] * o.data[14];
            // const x4 = self.data[0] * o.data[3] + self.data[1] * o.data[7] + self.data[2] * o.data[11] + self.data[3] * o.data[15];

            const res = @Vector(16, T){
                self.data[0] * res1[0] + self.data[1] * res2[0] + self.data[2] * res3[0] + self.data[3] * res4[0],
            self.data[0] * res1[1] + self.data[1] * res2[1] + self.data[2] * res3[1] + self.data[3] * res4[1],
            self.data[0] * res1[2] + self.data[1] * res2[2] + self.data[2] * res3[2] + self.data[3] * res4[2],
            self.data[0] * res1[3] + self.data[1] * res2[3] + self.data[2] * res3[3] + self.data[3] * res4[3],
            self.data[4] * res1[4] + self.data[5] * res2[4] + self.data[6] * res3[4] + self.data[7] * res4[4],
            self.data[4] * res1[5] + self.data[5] * res2[5] + self.data[6] * res3[5] + self.data[7] * res4[5],
            self.data[4] * res1[6] + self.data[5] * res2[6] + self.data[6] * res3[6] + self.data[7] * res4[6],
            self.data[4] * res1[7] + self.data[5] * res2[7] + self.data[6] * res3[7] + self.data[7] * res4[7],
            self.data[8] * res1[8] + self.data[9] * res2[8] + self.data[10] * res3[8] + self.data[11] * res4[8],
            self.data[8] * res1[9] + self.data[9] * res2[9] + self.data[10] * res3[9] + self.data[11] * res4[9],
             self.data[8] * res1[10] + self.data[9] * res2[10] + self.data[10] * res3[10] + self.data[11] * res4[10],
             self.data[8] * res1[11] + self.data[9] * res2[11] + self.data[10] * res3[11] + self.data[11] * res4[11],
             self.data[12] * res1[12] + self.data[13] * res2[12] + self.data[14] * res3[12] + self.data[15] * res4[12],
             self.data[12] * res1[13] + self.data[13] * res2[13] + self.data[14] * res3[13] + self.data[15] * res4[13],
             self.data[12] * res1[14] + self.data[13] * res2[14] + self.data[14] * res3[14] + self.data[15] * res4[14],
             self.data[12] * res1[15] + self.data[13] * res2[15] + self.data[14] * res3[15] + self.data[15] * res4[15]};

            self.data = res;
        }
    };
}

const m1 = Mat4(f32).init(.{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 17, 18, 19, 20});
const m2 = Mat4(f32).init(.{17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32});
const ITERATIONS = 10000;

pub fn main() void {

    for(0..ITERATIONS) |_| {
        var m = Mat4(f32).init(m1.data);
        m.mul(m2);
        std.debug.print("{any}\n", .{m});
    }
}
