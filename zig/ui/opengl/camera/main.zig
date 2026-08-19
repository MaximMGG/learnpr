const std = @import("std");
const gl = @cImport(@cInclude("glad/glad.h"));
const glfw = @cImport(@cInclude("GLFW/glfw3.h"));
const zglm = @import("zglm.zig");

const shader = @import("shader.zig");

const WIDTH = 1280;
const HEIGHT = 720;

pub fn main(init: std.process.Init) !void {
    _ = glfw.glfwInit();
    defer glfw.glfwTerminate();
    const allocator = std.heap.page_allocator;

    const window = glfw.glfwCreateWindow(WIDTH, HEIGHT, "Camera window", null, null).?;
    defer glfw.glfwDestroyWindow(window);

    glfw.glfwWindowHint(glfw.GLFW_VERSION_MAJOR, 3);
    glfw.glfwWindowHint(glfw.GLFW_VERSION_MINOR, 3);
    glfw.glfwWindowHint(glfw.GLFW_OPENGL_PROFILE, glfw.GLFW_OPENGL_CORE_PROFILE);

    glfw.glfwMakeContextCurrent(window);

    _ = gl.gladLoadGLLoader(@ptrCast(&glfw.glfwGetProcAddress));
    gl.glEnable(gl.GL_DEPTH_TEST);

    var s = try shader.Shader(allocator).createProgram("vertex.glsl", "fragment.glsl", init.io);
    defer s.destroy();

    const vertices = [_]f32{ 
        -0.5, -0.5, -0.5,  0.0, 0.0,
         0.5, -0.5, -0.5,  1.0, 0.0,
         0.5,  0.5, -0.5,  1.0, 1.0,
         0.5,  0.5, -0.5,  1.0, 1.0,
        -0.5,  0.5, -0.5,  0.0, 1.0,
        -0.5, -0.5, -0.5,  0.0, 0.0,

        -0.5, -0.5,  0.5,  0.0, 0.0,
         0.5, -0.5,  0.5,  1.0, 0.0,
         0.5,  0.5,  0.5,  1.0, 1.0,
         0.5,  0.5,  0.5,  1.0, 1.0,
        -0.5,  0.5,  0.5,  0.0, 1.0,
        -0.5, -0.5,  0.5,  0.0, 0.0,

        -0.5,  0.5,  0.5,  1.0, 0.0,
        -0.5,  0.5, -0.5,  1.0, 1.0,
        -0.5, -0.5, -0.5,  0.0, 1.0,
        -0.5, -0.5, -0.5,  0.0, 1.0,
        -0.5, -0.5,  0.5,  0.0, 0.0,
        -0.5,  0.5,  0.5,  1.0, 0.0,

         0.5,  0.5,  0.5,  1.0, 0.0,
         0.5,  0.5, -0.5,  1.0, 1.0,
         0.5, -0.5, -0.5,  0.0, 1.0,
         0.5, -0.5, -0.5,  0.0, 1.0,
         0.5, -0.5,  0.5,  0.0, 0.0,
         0.5,  0.5,  0.5,  1.0, 0.0,

        -0.5, -0.5, -0.5,  0.0, 1.0,
         0.5, -0.5, -0.5,  1.0, 1.0,
         0.5, -0.5,  0.5,  1.0, 0.0,
         0.5, -0.5,  0.5,  1.0, 0.0,
        -0.5, -0.5,  0.5,  0.0, 0.0,
        -0.5, -0.5, -0.5,  0.0, 1.0,

        -0.5,  0.5, -0.5,  0.0, 1.0,
         0.5,  0.5, -0.5,  1.0, 1.0,
         0.5,  0.5,  0.5,  1.0, 0.0,
         0.5,  0.5,  0.5,  1.0, 0.0,
        -0.5,  0.5,  0.5,  0.0, 0.0,
        -0.5,  0.5, -0.5,  0.0, 1.0
    };


    const cubePositions = [_]zglm.Vec3(f32){ 
        zglm.Vec3(f32).init(.{ 0.0, 0.0, 0.0 }), 
        zglm.Vec3(f32).init(.{ 2.0, 5.0, -15.0 }), 
        zglm.Vec3(f32).init(.{ -1.5, -2.2, -2.5 }), 
        zglm.Vec3(f32).init(.{ -3.8, -2.0, -12.3 }), 
        zglm.Vec3(f32).init(.{ 2.4, -0.4, -3.5 }), 
        zglm.Vec3(f32).init(.{ -1.7, 3.0, -7.5 }), 
        zglm.Vec3(f32).init(.{ 1.3, -2.0, -2.5 }), 
        zglm.Vec3(f32).init(.{ 1.5, 2.0, -2.5 }), 
        zglm.Vec3(f32).init(.{ 1.5, 0.2, -1.5 }), 
        zglm.Vec3(f32).init(.{ -1.3, 1.0, -1.5 } )};

    var VAO: u32 = undefined;

    var VBO: u32 = undefined;

    gl.glGenVertexArrays(1, @ptrCast(&VAO));
    defer gl.glDeleteVertexArrays(1, @ptrCast(&VAO));
    gl.glGenBuffers(1, @ptrCast(&VBO));
    defer gl.glDeleteBuffers(1, @ptrCast(&VBO));
    gl.glBindVertexArray(VAO);

    gl.glBindBuffer(gl.GL_ARRAY_BUFFER, VBO);
    gl.glBufferData(gl.GL_ARRAY_BUFFER, @sizeOf(f32) * vertices.len, &vertices[0], gl.GL_STATIC_DRAW);

    gl.glVertexAttribPointer(0, 3, gl.GL_FLOAT, gl.GL_FALSE, 5 * @sizeOf(f32), @ptrFromInt(0));
    gl.glEnableVertexAttribArray(0);

    gl.glVertexAttribPointer(1, 2, gl.GL_FLOAT, gl.GL_FALSE, 5 * @sizeOf(f32), @ptrFromInt(3 * @sizeOf(f32)));
    gl.glEnableVertexAttribArray(1);

    s.use();
    s.setInt("texture1", 0);
    s.setInt("texture2", 1);

    var projection = zglm.Mat4(f32).init(zglm.MAT4_IDENTITY_INIT);
    var view = zglm.Mat4(f32).init(zglm.MAT4_IDENTITY_INIT);
    projection.perspective(zglm.to_rad(45.0), @as(f32, @floatFromInt(WIDTH)) / @as(f32, @floatFromInt(HEIGHT)), 0.1, 100.0);
    view.translate(zglm.Vec3(f32).init(.{0.0, 0.0, -3.0}));

    s.setMat4("projection", projection);
    s.setMat4("view", view);

    while (glfw.glfwWindowShouldClose(window) == 0) {
        processWindow(window);

        gl.glClearColor(0.2, 0.3, 0.3, 1.0);
        gl.glClear(gl.GL_COLOR_BUFFER_BIT | gl.GL_DEPTH_BUFFER_BIT);

        gl.glBindVertexArray(VAO);
        for (cubePositions[0..]) |pos| {
            var model = zglm.Mat4(f32).init(zglm.MAT4_IDENTITY_INIT);
            model.translate(pos);
            model.rotate(@floatCast(glfw.glfwGetTime()), zglm.Vec3(f32).init(.{1.0, 0.3, 0.5}));
            s.setMat4("model", model);

            gl.glDrawArrays(gl.GL_TRIANGLES, 0, 36);
        }

        glfw.glfwSwapBuffers(window);
        glfw.glfwPollEvents();
    }
}

pub fn processWindow(window: *glfw.GLFWwindow) void {
    if (glfw.glfwGetKey(window, glfw.GLFW_KEY_ESCAPE) == glfw.GLFW_PRESS) {
        glfw.glfwSetWindowShouldClose(window, @as(c_int, 1));
    }
}
