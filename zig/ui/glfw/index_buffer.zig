const std = @import("std");
const gl = @cImport(@cInclude("GL/glew.h"));

pub const IndexBuffer = struct {
    rendererID: u32 = 0,
    count: u32 = 0,


    pub fn destroy(self: *IndexBuffer) void {
        gl.glDeleteBuffers().?(1, &self.rendererID);
    }

    pub fn bind(self: *IndexBuffer) void {
        gl.glBindBuffer().?(gl.GL_ELEMENT_ARRAY_BUFFER, self.rendererID);
    }

    pub fn unbind(self: *IndexBuffer) void {
        _ = &self;
        gl.glBindBuffer().?(gl.GL_ELEMENT_ARRAY_BUFFER, 0);
    }
};


pub fn indexBuffer(data: []u32) IndexBuffer {
    var ib: IndexBuffer = .{};
    comptime if (@sizeOf(u32) != @sizeOf(gl.GLuint)) {
        @panic("u32 not equalse GLuint");
    };

    gl.glGenBuffers().?(1, &ib.rendererID);
    gl.glBindBuffer().?(gl.GL_ELEMENT_ARRAY_BUFFER, ib.rendererID);
    gl.glBufferData().?(gl.GL_ELEMENT_ARRAY_BUFFER, @intCast(@sizeOf(u32) * data.len), data.ptr, gl.GL_STATIC_DRAW);
    ib.count = @intCast(data.len);

    return ib;
}
