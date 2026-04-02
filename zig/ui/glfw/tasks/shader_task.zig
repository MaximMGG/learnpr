const std = @import("std");
const glew = @cImport(@cInclude("GL/glew.h"));
const gl = @cImport(@cInclude("GL/gl.h"));
const glfw = @cImport(@cInclude("GLFW/glfw3.h"));

const WIDTH = 720;
const HEIGHT = 480;
const log = std.log;

fn load_shader(shader_file: []const u8, shader_type: u32, allocator: std.mem.Allocator) !u32 {
    const f = try std.fs.cwd().openFile(shader_file, .{ .mode =  .read_only});
    defer f.close();
    var buf: [4096]u8 = undefined;
    var f_reader = f.reader(&buf);
    const f_stat = try f.stat();
    const shader_source = try f_reader.interface.readAlloc(allocator, f_stat.size);
    defer allocator.free(shader_source);
    if (shader_source.len != f_stat.size) {
        log.err("{s} size not equal stat.size", .{shader_file});
        return error.ShaderSourceLenErr;
    }
    const shader = glew.glCreateShader().?(shader_type);
    glew.glShaderSource().?(shader, 1, @ptrCast(&shader_source.ptr), null);
    glew.glCompileShader().?(shader);
    var res: i32 = 0;
    glew.glGetShaderiv().?(shader, glew.GL_COMPILE_STATUS, &res); 
    if (res == gl.GL_FALSE) {
        var err_buf_len: i32 = 0;
        glew.glGetShaderiv().?(shader, gl.GL_INFO_LOG_LENGTH, &err_buf_len);
        const err_buf = try allocator.alloc(u8, @intCast(err_buf_len));
        defer allocator.free(err_buf);

        glew.glGetShaderInfoLog().?(shader, err_buf_len, null, @ptrCast(err_buf.ptr));
        log.err("Compile shader error: {s}", .{err_buf});
        return 0;
    }
    return shader;
} 



pub fn main() !void {
    const allocator = std.heap.page_allocator;

    _ = glfw.glfwInit();
    log.info("Init glfw", .{});

    const window: *glfw.GLFWwindow = glfw.glfwCreateWindow(WIDTH, HEIGHT, "Task window", null, null) orelse {
        log.err("glfwCreateWindow failed", .{});
        return;
    };

    glfw.glfwMakeContextCurrent(window);
    log.info("Make context", .{});

    if (glew.glewInit() != gl.GL_NO_ERROR) {
        log.err("glewInit error", .{});
        return;
    }


    const vertex_shader = try load_shader("vertex.glsl", gl.GL_VERTEX_SHADER, allocator);
    const fragment_shader = try load_shader("fragment.glsl", gl.GL_FRAGMENT_SHADER, allocator);

    const program = glew.glCreateProgram().?();
    glew.glAttachShader().?(program, vertex_shader);
    glew.glAttachShader().?(program, fragment_shader);
    glew.glLinkProgram().?(program);
    glew.glUseProgram().?(program);

    glew.glDeleteShader().?(vertex_shader);
    glew.glDeleteShader().?(fragment_shader);
    log.info("Shader load", .{});

    const pos = [_]f32{
        0.0,  0.5, 1.0, 0.0, 0.0,
       -0.5, -0.5, 0.0, 1.0, 0.0,
        0.5, -0.5, 0.0, 0.0, 1.0,
    };

    var VBO: u32 = 0;
    var VAO: u32 = 0;

    glew.glGenBuffers().?(1, &VBO);
    glew.glGenVertexArrays().?(1, &VAO);
    glew.glBindVertexArray().?(VAO);
    glew.glBindBuffer().?(gl.GL_ARRAY_BUFFER, VBO);
    glew.glBufferData().?(gl.GL_ARRAY_BUFFER, @sizeOf(f32) * pos.len, &pos[0], gl.GL_STATIC_DRAW);
    glew.glVertexAttribPointer().?(0, 2, gl.GL_FLOAT, gl.GL_FALSE, @sizeOf(f32) * 5, @ptrFromInt(0));
    glew.glEnableVertexAttribArray().?(0);
    glew.glVertexAttribPointer().?(1, 3, gl.GL_FLOAT, gl.GL_FALSE, @sizeOf(f32) * 5, @ptrFromInt(2 * @sizeOf(f32)));
    glew.glEnableVertexAttribArray().?(1);
    log.info("Gen buffers and vertex arrays", .{});


    var offset: f32 = 0.001;
    var inc: f32 = 0.001;
    log.info("Start main looooooop", .{});
    while(glfw.glfwWindowShouldClose(window) == 0) {


        glew.glUniform1f().?(glew.glGetUniformLocation().?(program, "u_Offset"), offset);

        if (offset > 0.5) {
            inc = -0.001;
        } else if (offset < 0.00001) {
            inc = 0.001;
        }
        offset += inc;

        glew.glClear(gl.GL_COLOR_BUFFER_BIT);

        glew.glDrawArrays(gl.GL_TRIANGLES, 0, 3);

        glfw.glfwSwapBuffers(window);
        glfw.glfwPollEvents();
    }

    glfw.glfwDestroyWindow(window);
    glfw.glfwTerminate();
    log.info("OpenGL shutdown", .{});
}
