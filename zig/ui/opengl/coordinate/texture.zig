const std = @import("std");

const d = @cImport(
    {
        @cInclude("stdio.h");
        @cDefine("STB_IMAGE_IMPLEMENTATION", 0);
    }); 
const stb = @cImport({
    //@cDefine("STB_IMAGE_IMPLEMENTATION", 0);
    @cInclude("stb_image.h");
});
const gl = @cImport(@cInclude("glad/glad.h"));

pub fn loadPng(path: []const u8) u32 {
    _ = std.mem.lastIndexOf(u8, path, ".png") orelse {
        std.debug.print("loadJpg but get not jpg file: {s}\n", .{path});
        return 0;
    };
    var t: u32 = 0;
    gl.glGenTextures(1, &t);

    gl.glBindTexture(gl.GL_TEXTURE_2D);
    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_T, gl.GL_REPEAT);
    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_S, gl.GL_REPEAT);
    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MIN_FILTER, gl.GL_LENEAR);
    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MAG_FILTER, gl.GL_LENEAR);

    stb.stbi_set_flip_vertically_on_load(1);
    const width: i32 = 0;
    const height: i32 = 0;
    const nrChannels: i32 = 0;
    const data = stb.stbi_load(path, &width, &height, &nrChannels, 0);
    defer stb.stbi_image_free(data);
    if (data != null) {
        gl.glTexImage2D(gl.GL_TEXTURE_2D, 0, gl.GL_RGB, width, height, 0, gl.GL_RGBA, gl.GL_UNSIGNED_BYTE, data);
        gl.glGenerateMipmap(gl.GL_TEXTURE_2D);
    } else {
        std.debug.print("Cant load image: {s}\n", .{path});
        return 0;
    }
    return t;
}

pub fn loadJpg(path: []const u8) u32 {
    _ = std.mem.lastIndexOf(u8, path, ".jpg") orelse {
        std.debug.print("loadJpg but get not jpg file: {s}\n", .{path});
        return 0;
    };
    var t: u32 = 0;
    gl.glGenTextures(1, &t);

    gl.glBindTexture(gl.GL_TEXTURE_2D);
    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_T, gl.GL_REPEAT);
    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_S, gl.GL_REPEAT);
    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MIN_FILTER, gl.GL_LENEAR);
    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MAG_FILTER, gl.GL_LENEAR);

    stb.stbi_set_flip_vertically_on_load(1);
    const width: i32 = 0;
    const height: i32 = 0;
    const nrChannels: i32 = 0;
    const data = stb.stbi_load(path, &width, &height, &nrChannels, 0);
    defer stb.stbi_image_free(data);
    if (data != null) {
        gl.glTexImage2D(gl.GL_TEXTURE_2D, 0, gl.GL_RGB, width, height, 0, gl.GL_RGB, gl.GL_UNSIGNED_BYTE, data);
        gl.glGenerateMipmap(gl.GL_TEXTURE_2D);
    } else {
        std.debug.print("Cant load image: {s}\n", .{path});
        return 0;
    }
    return t;
}
