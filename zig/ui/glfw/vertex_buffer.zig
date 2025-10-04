const std = @import("std");
const gl = @cImport(@cInclude("GL/glew.h"));


pub const VertexBuffer = struct {
    rendererID: u32 = 0,

    pub fn destroy(self: *VertexBuffer) void {
        gl.glDeleteBuffers().?(1, &self.rendererID);

    }

    pub fn bind(self: VertexBuffer) void {
        gl.glBindBuffer().?(gl.GL_ARRAY_BUFFER, self.rendererID);

    }

    pub fn unbind(self: VertexBuffer) void {
        _ = self;
        gl.glBindBuffer().?(gl.GL_ARRAY_BUFFER, 0);
    }
};


pub fn vertexBuffer(data: anyopaque, size: u32) VertexBuffer {
    var vb: VertexBuffer = {};
    gl.glGenBuffers().?(1, &vb.rendererID);
    gl.glBindBuffer().?(gl.GL_ARRAY_BUFFER, vb.rendererID);
    gl.glBufferData().?(gl.GL_ARRAY_BUFFER, data, size, gl.GL_STATIC_DRAW);
    return vb;
}
