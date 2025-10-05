const std = @import("std");
const png_load = @import("png_load.zig");
const gl = @cImport(@cInclude("GL/glew.h"));



pub const Texture = struct {
    rendererID: u32 = 0,
    file_path: []const u8 = "",
    local_buffer: []u8 = "",
    width: i32 = 0,
    height: i32 = 0,
    bpp: i32 = 0,
    slot: u32 = 0,


    pub fn destroy(self: *Texture) void {
        gl.glDeleteTextures(1, &self.rendererID);
        std.heap.c_allocator.free(self.local_buffer);
    }

    pub fn bind(self: *Texture, slot: u32) void {
        gl.glActiveTexture(gl.GL_TEXTURE0 + @as(c_int, @intCast(slot)));
        gl.glBindTexture().?(gl.GL_TEXTURE_2D, @intCast(self.rendererID));
        self.slot = slot;
    }

    pub fn unbind(self: *Texture) void {
        _ = &self;
        gl.glBindTexture().?(gl.GL_TEXTURE_2D, 0);
    }

};


pub fn texture(file_path: []const u8) Texture {
    var t: Texture = .{};
    gl.glGenTextures().?(1, &t.rendererID);
    gl.glBindTexture().?(gl.GL_TEXTURE_2D, t.rendererID);
    t.local_buffer = png_load.load_png(file_path, &t.width, &t.height);

    gl.glTexParameteri().?(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MIN_FILTER, gl.GL_LINEAR);
    gl.glTexParameteri().?(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MAG_FILTER, gl.GL_LINEAR);
    gl.glTexParameteri().?(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_S, gl.GL_CLAMP);
    gl.glTexParameteri().?(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_T, gl.GL_CLAMP);

    gl.glTexImage2D().?(gl.GL_TEXTURE_2D, 0, gl.GL_RGBA8, t.width, t.height, 0, gl.GL_RGBA, gl.GL_UNSIGNED_INT, t.local_buffer.ptr);
    gl.glBindTexture().?(gl.GL_TEXTURE_2D, 0);

}
