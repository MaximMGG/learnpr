const std = @import("std");
const zglm = @import("zglm.zig");
const shader = @import("shader.zig");
const gl = @cImport(@cInclude("glad/glad.h"));
const glfw = @cImport(@cInclude("GLFW/glfw3.h"));
const texture = @import("texture.zig");


const WIDTH = 1280;
const HEIGHT = 720;

pub fn framebufferCallback(window: *glfw.GLFWwindow, width: i32, height: i32) void {
    _ = window;
    gl.glViewport(0, 0, width, height);
}

pub fn processInput(window: *glfw.GLFWwindow) void {
    if (glfw.glfwGetKey(window, glfw.GLFW_KEY_ESCAPE) == glfw.GLFW_PRESS)  {
        glfw.glfwSetWindowShouldClose(window, 1);
    }
} 


pub fn main(init: std.process.Init) void {

    const allocator = std.heap.PageAllocator;

    _ = glfw.glfwInit();
    defer _ = glfw.glfwTerminate();

    const window = glfw.glfwCreateWindow(WIDTH, HEIGHT, "Coordinate windwo", null, null).?;
    defer glfw.glfwDestroyWindow(window);

    glfw.glfwWindowHint(glfw.GLFW_VERSION_MAJOR, 3);
    glfw.glfwWindowHint(glfw.GLFW_VERSION_MINOR, 3);
    glfw.glfwWindowHint(glfw.GLFW_OPENGL_PROFILE, glfw.GLFW_OPENGL_CORE_PROFILE);

    _ = glfw.glfwSetFramebufferSizeCallback(window, @ptrCast(&framebufferCallback));

    glfw.glfwMakeContextCurrent(window);
    _ = gl.gladLoadGLLoader(@ptrCast(&glfw.glfwGetProcAddress));

    const s = try shader.Shader(allocator).createProgram("vertex.glsl", "fragment.glsl", init.io);
    const tex1 = try texture.loadJpg("container.jpg");
    if (tex1 == 0) {
        return;
    }
    const tex2 = try texture.loadPng("awesomeface.png");
    if (tex2 == 0) {
        return;
    }

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


    const VAO: u32 = undefined;
    const VBO: u32 = undefined;

    gl.glGenVertexArrays(1, &VAO);
    gl.glGenBuffers(1, &VBO);

    gl.glBindVertexArray(VAO);
    gl.glBindBuffer(gl.GL_ARRAY_BUFFER, VBO);
    gl.glBufferData(gl.GL_ARRAY_BUFFER, vertices.len * @sizeOf(f32), @ptrCast(&vertices[0]), gl.GL_STATIC_DRAW);

    gl.glVertexAttribPointer(0, 3, gl.GL_FLOAT, gl.GL_FALSE, 5 * @sizeOf(f32), @ptrFromInt(0));
    gl.glEnableVertexAttribArray(0);
    gl.glVertexAttribPointer(1, 2, gl.GL_FLOAT, gl.GL_FALSE, 5 * @sizeOf(f32), @ptrFromInt(3 * @sizeOf(f32)));
    gl.glEnableVertexAttribArray(1);

    while(glfw.glfwWindowShouldClose(window) == 0) {
        processInput(window);

        gl.glClearColor(0.2, 0.3, 0.3, 1.0);
        gl.glClear(gl.GL_COLOR_BUFFER_BIT);

        s.use();

        glfw.glfwSwapBuffers(window);
        glfw.glfwPollEvents();
    }
}
