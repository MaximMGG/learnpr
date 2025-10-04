const std = @import("std");
const gl = @cImport(@cInclude("GL/glew.h"));

pub inline fn GLLogError(s: std.builtin.SourceLocation) void {
    var gl_err: u32 = gl.glGetError().?();
    while(gl_err != gl.GL_NO_ERROR) : (gl_err = gl.glGetError().?()) {
        std.debug.print("[OpenGL Error] (0x{X}): {s}:{d}\n", .{gl_err, s.fn_name, s.line});
    }
}
