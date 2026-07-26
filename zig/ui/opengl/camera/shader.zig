const std = @import("std");
const gl = @import("glad.zig");


const ShaderType = enum {
    VERTEX_SHADER, FRAGMENT_SHADER, PROGRAM
};

const ShaderError = error {
    COMPILE_SHADER_ERROR,
    LINK_PROGRAM_ERROR,
};

pub const Shader = struct {

    pub fn init(allocator: std.mem.Allocator) type {
        return struct {
            const This = @This();
            id: u32,
            allocator: std.Allocator = allocator,


            fn checkStatus(element: u32, shader_type: ShaderType) bool {
                switch(shader_type) {
                    .VERTEX_SHADER => {
                        var status: i32 = 0;
                        gl.glGetShaderiv(element, gl.GL_COMPILE_STATUS, @ptrCast(&status));
                        if (status == @as(i32, @intCast(gl.GL_FALSE))) {
                            var buf: [512]u8 = .{0} ** 512;
                            gl.glGetShaderInfoLog(element, 512, null, @ptrCast(&buf));
                            std.debug.print("Compile VERTEX shader error: {s}\n", .{&buf});
                            return false;
                        }

                    },
                    .FRAGMENT_SHADER => {
                        var status: i32 = 0;
                        gl.glGetShaderiv(element, gl.GL_COMPILE_STATUS, @ptrCast(&status));
                        if (status == @as(i32, @intCast(gl.GL_FALSE))) {
                            var buf: [512]u8 = .{0} ** 512;
                            gl.glGetShaderInfoLog(element, 512, null, @ptrCast(&buf));
                            std.debug.print("Compile FRAGMENT shader error: {s}\n", .{&buf});
                            return false;
                        }
                    },
                    .PROGRAM => {
                        var status: i32 = 0;
                        gl.glGetProgramiv(element, gl.GL_LINK_STATUS, @ptrCast(&status));
                        if (status == @as(i32, @intCast(gl.GL_FALSE))) {
                            var buf: [512]u8 = .{0} ** 512;
                            gl.glGetProgramInfoLog(element, 512, null, @ptrCast(&buf));
                            std.debug.print("Progarm link shader error: {s}\n", .{&buf});
                            return false;
                        }
                    },
                }
                return true;
            }

            pub fn createProgram(vertex_path: []const u8, fragment_path: []const u8, io: std.Io) !u32 {
                var buf: [1024]u8 = .{0} ** 1024;
                const v_f = try std.Io.Dir.cwd().openFile(io, vertex_path, .{});
                defer v_f.close(io);
                var vf_reader = v_f.readerStreaming(io, &buf);
                const f_size = try v_f.length(io);
                const vertex_source = try vf_reader.interface.readAlloc(allocator, f_size);
                defer allocator.free(vertex_source);

                const v_s = gl.glCreateShader(gl.GL_VERTEX_SHADER);
                gl.glShaderSource(v_s, 1, @ptrCast(&vertex_source), null);
                gl.glCompileShader(v_s);
                if (!checkStatus(v_s, .VERTEX_SHADER)) {
                    return ShaderError.COMPILE_SHADER_ERROR;
                }

                const f_f = try std.Io.Dir.cwd().openFile(io, fragment_path, .{});
                defer f_f.close(io);
                var ff_reader = f_f.readerStreaming(io, &buf);
                const ff_size = try f_f.length(io);
                const fragment_source = try ff_reader.interface.readAlloc(allocator, ff_size);
                defer allocator.free(fragment_source);

                const f_s = gl.glCreateShader(gl.GL_FRAGMENT_SHADER);
                gl.glShaderSource(f_s, 1, @ptrCast(&fragment_source), null);
                gl.glCompileShader(f_s);
                if (!checkStatus(f_s, .FRAGMENT_SHADER)) {
                    return ShaderError.COMPILE_SHADER_ERROR;
                }

                const prog = gl.glCreateProgram();
                gl.glAttachShader(prog, v_s);
                gl.glAttachShader(prog, f_s);
                gl.glLinkProgram(prog);
                if (!checkStatus(prog, .PROGRAM)) {
                    return ShaderError.LINK_PROGRAM_ERROR;
                }
                gl.glDeleteShader(v_s);
                gl.glDeleteShader(f_s);

                return prog;
            }
        };
    }
};

