const std = @import("std");


const vec4 = @Vector(4, f32);
const mat4 = [4]vec4;


fn vec4_mul_mat4(v: vec4, m2: mat4) vec4 {
    const v1 = @Vector(4, f32){m2[0][0], m2[1][0], m2[2][0], m2[3][0]};
    const v2 = @Vector(4, f32){m2[0][1], m2[1][1], m2[2][1], m2[3][1]};
    const v3 = @Vector(4, f32){m2[0][2], m2[1][2], m2[2][2], m2[3][2]};
    const v4 = @Vector(4, f32){m2[0][3], m2[1][3], m2[2][3], m2[3][3]};

    var res: vec4 = undefined;
    var tmp: vec4 = undefined;
    tmp = v * v1;
    res[0] = tmp[0] + tmp[1] + tmp[2] + tmp[3];
    tmp = v * v2;
    res[1] = tmp[0] + tmp[1] + tmp[2] + tmp[3];
    tmp = v * v3;
    res[2] = tmp[0] + tmp[1] + tmp[2] + tmp[3];
    tmp = v * v4;
    res[3] = tmp[0] + tmp[1] + tmp[2] + tmp[3];

    return res;
}


pub fn mat4_mul_mat4(m1: mat4, m2: mat4) mat4 {
    var res: mat4 = undefined;
    res[0] = vec4_mul_mat4(m1[0], m2);
    res[1] = vec4_mul_mat4(m1[1], m2);
    res[2] = vec4_mul_mat4(m1[2], m2);
    res[3] = vec4_mul_mat4(m1[3], m2);

    return res;
}


pub fn main() void {
    const m = mat4{.{1, 2, 3, 4}, .{3, 4, 5, 6}, .{3, 8, 8 ,1}, .{0, 0, 2, 1}};
    const m2 = mat4{.{3, 1, 8, 0}, .{1, 3, 3, 3}, .{8, 8, 8 ,9}, .{5, 4, 6, 2}};

    var sum: u64 = 0;
    for(0..1000000) |_| {
        const res = mat4_mul_mat4(m, m2);
        sum += @intFromFloat(res[0][0]);
    }
    const res = mat4_mul_mat4(m, m2);
    std.debug.print("{d}\n", .{sum});
    std.debug.print("{any}\n", .{res});
}

