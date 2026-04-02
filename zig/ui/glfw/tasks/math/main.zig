const std = @import("std");

const c = @cImport({
    @cInclude("cglm/cglm.h");
    @cInclude("cglm/types-struct.h");
});


pub fn main() void {
    var a = [4][4]f32{
        [4]f32{0, 0, 0, 0},
        [4]f32{0, 0, 0, 0},
        [4]f32{0, 0, 0, 0},
        [4]f32{0, 0, 0, 0},
    };
    c.glm_mat4_identity(@ptrCast(&a));
    std.debug.print("{any}\n", .{a});
}

