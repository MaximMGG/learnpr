const std = @import("std");
const gl = @cImport(@cInclude("GL/glew.h"));
const VertexArray = @import("vertex_array.zig").VertexArray;
const IndexBuffer = @import("index_buffer.zig").IndexBuffer;
const Shader = @import("shader.zig").Shader;

pub inline fn GLLogError(s: std.builtin.SourceLocation) void {
    var gl_err: u32 = gl.glGetError().?();
    while(gl_err != gl.GL_NO_ERROR) : (gl_err = gl.glGetError().?()) {
        std.debug.print("[OpenGL Error] (0x{X}): {s}:{d}\n", .{gl_err, s.fn_name, s.line});
    }
}

pub const Renderer = struct {


    pub fn clear(self: *Renderer) void {
        _ = &self;
        gl.glClear(gl.GL_COLOR_BUFFER_BIT);

    }

    pub fn draw(self: *Renderer, va: *VertexArray, ib: *IndexBuffer, shader: *Shader) void {
        _ = &self;
        shader.bind();
        va.bind();
        ib.bind();

        gl.glDrawElements(gl.GL_TRIANGLES, @intCast(ib.count), gl.GL_UNSIGNED_INT, null);
    }
};

