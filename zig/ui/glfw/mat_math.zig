const std = @import("std");

pub const mat4 = [4]@Vector(4, f32);
pub const vec4 = @Vector(4, f32);

pub fn mat4_identity() mat4 {
    return mat4{@Vector(4, f32){1, 0, 0, 0}, 
                @Vector(4, f32){0, 1, 0, 0}, 
                @Vector(4, f32){0, 0, 1, 0}, 
                @Vector(4, f32){0, 0, 0, 1}};

}


pub fn mat4_ortho(left: f32, right: f32, top: f32, bottom: f32, zFar: f32, zNear: f32) mat4 {
    var m = mat4_identity();
    m[0][0] = 2.0 / (right - left);
    m[1][1] = 2.0 / (top - bottom);
    m[2][2] = 1.0 / (zFar - zNear);
    m[3][0] = -(right + left) / (right - left);
    m[3][1] = -(top + bottom) / (top - bottom);
    // m[3][2] = -(zNear + zFar) / (zNear - zFar);

    return m;
}

pub fn mat4_ptr(m: [4]@Vector(4, f32), allocator: std.mem.Allocator) ![*]f32 {
    const p = try allocator.alloc(f32, 16);

    @memcpy(p[0..4], @as([]f32, @constCast(@ptrCast(&m[0]))));
    @memcpy(p[4..8], @as([]f32, @constCast(@ptrCast(&m[1]))));
    @memcpy(p[8..12], @as([]f32, @constCast(@ptrCast(&m[2]))));
    @memcpy(p[12..16], @as([]f32, @constCast(@ptrCast(&m[3]))));

    return @ptrCast(p.ptr);
}

pub fn mul_mat4_by_vec4(mat: *[4][4]f32, vec: *[4]f32) @Vector(4, f32) {
    const m1 = @Vector(4, f32){mat[0][0], mat[1][0], mat[2][0], mat[3][0]};
    const m2 = @Vector(4, f32){mat[0][1], mat[1][1], mat[2][1], mat[3][1]};
    const m3 = @Vector(4, f32){mat[0][2], mat[1][2], mat[2][2], mat[3][0]};
    const m4 = @Vector(4, f32){mat[0][3], mat[1][3], mat[2][3], mat[3][3]};

    var res: [4]f32 = undefined;
    res[0] = m1[0] * vec[0] + m1[1] * vec[1] + m1[2] * vec[2] + m1[3] * vec[3];
    res[1] = m2[0] * vec[0] + m2[1] * vec[1] + m2[2] * vec[2] + m2[3] * vec[3];
    res[2] = m3[0] * vec[0] + m3[1] * vec[1] + m3[2] * vec[2] + m3[3] * vec[3];
    res[3] = m4[0] * vec[0] + m4[1] * vec[1] + m4[2] * vec[2] + m4[3] * vec[3];

    return res;
} 
