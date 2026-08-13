const std = @import("std");
const stb = @cImport({
    @cDefine("STB_IMAGE_IMPLEMENTATION", "");
    @cInclude("stb_image.h");
});
const gl = @cImport(@cInclude("glad/glad.h"));

pub const Texture = struct {
    const Self = @This();
    id: u32,

    pub fn destroy(self: Self) void {
        gl.glDeleteTextures(1, @ptrCast(&self.id));
    }

};

pub fn loadJpg(path: []const u8) Texture {
    const t: Texture = .{};

    const index_of_png = std.mem.lastIndexOf(u8, path, ".jpg") orelse {
        return Texture{.id = 0};
    };
    if (index_of_png != path.len - 4) {
        std.debug.print("Execept .jpg file, got {s}\n", .{path});
    }

    gl.glGenTextures(1, @ptrCast(&t.id));
    gl.glBindTexture(gl.GL_TEXTURE_2D, t.id);
    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_R, gl.GL_REPEAT);
    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_S, gl.GL_REPEAT);
    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MIN_FILTER, gl.GL_LENEAR);
    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MAG_FILTER, gl.GL_LENEAR);

    var width: i32 = undefined;
    var height: i32 = undefined;
    var nrChannels: i32 = undefined;

    stb.stbi_set_flip_vertically_on_load_thread(@as(c_int, 1));
    const data = stb.stbi_load(path, @ptrCast(&width), @ptrCast(&height), @ptrCast(&nrChannels), @as(c_int, 0));

    if (data != null) {
        gl.glTexImage2D(gl.GL_TEXTURE_2D, gl.GL_RGB, @as(c_int, 0), @intCast(width), @intCast(height), gl.GL_RGB, gl.GL_UNSIGNED_INT, data);
        gl.glGenerateMipmap(gl.GL_TEXTURE_2D);
    } else {
        std.debug.print("stbi_load error\n", .{});
        return Texture{.id = 0};
    }
    stb.stbi_image_free(data);
    return t;
}

pub fn loadPng(path: []const u8) Texture {
    const t: Texture = .{};

    const index_of_png = std.mem.lastIndexOf(u8, path, ".png") orelse {
        return Texture{.id = 0};
    };
    if (index_of_png != path.len - 4) {
        std.debug.print("Execept .png file, got {s}\n", .{path});
    }

    gl.glGenTextures(1, @ptrCast(&t.id));
    gl.glBindTexture(gl.GL_TEXTURE_2D, t.id);
    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_R, gl.GL_REPEAT);
    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_S, gl.GL_REPEAT);
    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MIN_FILTER, gl.GL_LENEAR);
    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MAG_FILTER, gl.GL_LENEAR);

    var width: i32 = undefined;
    var height: i32 = undefined;
    var nrChannels: i32 = undefined;

    stb.stbi_set_flip_vertically_on_load_thread(@as(c_int, 1));
    const data = stb.stbi_load(path, @ptrCast(&width), @ptrCast(&height), @ptrCast(&nrChannels), @as(c_int, 0));

    if (data != null) {
        gl.glTexImage2D(gl.GL_TEXTURE_2D, gl.GL_RGB, @as(c_int, 0), @intCast(width), @intCast(height), gl.GL_RGBA, gl.GL_UNSIGNED_INT, data);
        gl.glGenerateMipmap(gl.GL_TEXTURE_2D);
    } else {
        std.debug.print("stbi_load error\n", .{});
        return Texture{.id = 0};
    }
    stb.stbi_image_free(data);
    return t;
}


