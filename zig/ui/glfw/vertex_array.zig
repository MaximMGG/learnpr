const std = @import("std");
const gl = @cImport(@cInclude("GL/glew.h"));
const vertex_buffer = @import("vertex_buffer.zig");
const vertex_buffer_layout = @import("vertex_buffer_layout.zig");
const VertexBuffer = vertex_buffer.VertexBuffer;
const VertexBufferLayout = vertex_buffer_layout.VertexBufferLayout;


pub const VertexArray = struct {
    rendererID: u32 = 0,



    pub fn destroy(self: *VertexArray) void {
        gl.glDeleteVertexArrays().?(1, &self.rendererID);
    }

    pub fn addBuffer(self: *VertexArray, vb: *VertexBuffer, layout: *VertexBufferLayout) void {
        vb.bind();
        self.bind();

        var offset: usize = 0;
        for(0.., layout.elements.items) |i, *element| {
            gl.glEnableVertexAttribArray().?(@intCast(i));
            gl.glVertexAttribPointer().?(@intCast(i), @intCast(element.count), element._type, @as(u8, @intFromBool(element.normalized)), 
                @intCast(layout.stride), @ptrFromInt(offset));
            offset += element.count * element.bufferElementGetSize();
        }
    }

    pub fn bind(self: *VertexArray) void {
        gl.glBindVertexArray().?(self.rendererID);

    }

    pub fn unbind(self: *VertexArray) void {
        _ = &self;
        gl.glBindVertexArray().?(0);
    }

};

pub fn vertexArray() VertexArray {
    var va: VertexArray = .{};
    gl.glGenVertexArrays().?(1, &va.rendererID);
    return va;
}
