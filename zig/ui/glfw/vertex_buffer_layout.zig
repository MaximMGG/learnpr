const std = @import("std");
const ArrayList = std.ArrayList;
const gl = @cImport(@cInclude("GL/glew.h"));


pub const VertexBufferElement = struct {
    count: u32,
    _type: u32,
    normalized: bool,

    pub fn bufferElementGetSize(self: *VertexBufferElement) u32 {
        switch(@as(i32, @intCast(self._type))) {
            gl.GL_FLOAT => {
                return @sizeOf(gl.GLfloat);
            },
            gl.GL_UNSIGNED_INT => {
                return @sizeOf(gl.GLuint);
            },
            gl.GL_INT => {
                return @sizeOf(gl.GLint);
            },
            gl.GL_UNSIGNED_BYTE => {
                return @sizeOf(gl.GLbyte);
            },
            else => {}
        }
        return 0;
    }
};



pub const VertexBufferLayout = struct {
    elements: ArrayList(VertexBufferElement),
    stride: u32,
    allocator: std.mem.Allocator,

    pub fn destroy(self: *VertexBufferLayout) void {
        self.elements.deinit(self.allocator);
    }

    pub fn pushf32(self: *VertexBufferLayout, count: u32, normalized: bool) void {
        self.elements.append(VertexBufferElement{.count = count, ._type = gl.GL_FLOAT, .normalized = normalized});
        self.stride += VertexBufferElement.bufferElementGetSize(gl.GL_FLOAT) * count;
    }

    pub fn pushu32(self: *VertexBufferLayout, count: u32, normalized: bool) void {
        self.elements.append(VertexBufferElement{.count = count, ._type = gl.GL_UNSIGNED_INT, .normalized = normalized});
        self.stride += VertexBufferElement.bufferElementGetSize(gl.GL_UNSIGNED_INT) * count;
    }

    pub fn pushu8(self: *VertexBufferLayout, count: u32, normalized: bool) void {
        self.elements.append(VertexBufferElement{.count = count, ._type = gl.GL_UNSIGNED_BYTE, .normalized = normalized});
        self.stride += VertexBufferElement.bufferElementGetSize(gl.GL_UNSIGNED_BYTE) * count;
    }
};


pub fn vertexBufferLayout(allocator: std.mem.Allocator) !VertexBufferLayout {
    const vbl: VertexBufferLayout = .{.elements = try ArrayList(VertexBufferElement).initCapacity(allocator, 0),
                                   .stride = 0, .allocator = allocator};

    return vbl;
}
