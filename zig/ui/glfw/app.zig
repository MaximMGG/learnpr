const std = @import("std");
const c = @cImport(@cInclude("stdio.h"));
const glew = @cImport(@cInclude("GL/glew.h"));
const gl = @cImport(@cInclude("GL/gl.h"));
const glfw = @cImport(@cInclude("GLFW/glfw3.h"));
const shader = @import("shader.zig");
const va = @import("vertex_array.zig");
const vb = @import("vertex_buffer.zig");
const vbl = @import("vertex_buffer_layout.zig");
const renderer = @import("renderer.zig");
const ib = @import("index_buffer.zig");
const texture = @import("texture.zig");



const WIDTH = 640;
const HEIGHT = 480;


pub fn main() !void {

    const allocator = std.heap.page_allocator;

    if (glfw.glfwInit() == 0) {
        std.debug.print("glfwInit Fail\n", .{});
        return;
    }

    std.debug.print("glfwInit\n", .{});

    glfw.glfwWindowHint(glfw.GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfw.glfwWindowHint(glfw.GLFW_CONTEXT_VERSION_MINOR, 3);
    glfw.glfwWindowHint(glfw.GLFW_OPENGL_PROFILE, glfw.GLFW_OPENGL_CORE_PROFILE);

    const window: *glfw.GLFWwindow = glfw.glfwCreateWindow(WIDTH, HEIGHT, "TEST WINDOW", null, null) orelse {
        std.debug.print("GLFWwindow in null", .{});
        return;
    }; 

    std.debug.print("Ceate window\n", .{});

    glfw.glfwMakeContextCurrent(window);

    if (glew.glewInit() != glew.GLEW_OK) {
        std.debug.print("glewInit fail\n", .{});
        glfw.glfwDestroyWindow(window);
        glfw.glfwTerminate();
        return;
    }

    std.debug.print("glewInit\n", .{});
    glfw.glfwSwapInterval(1);


    var positions = [_]f32{
        -0.5, -0.5, 0.0, 0.0,
         0.5, -0.5, 1.0, 0.0,
         0.5,  0.5, 1.0, 1.0,
        -0.5,  0.5, 0.0, 1.0
    };

    var indeces = [_]u32{
        0, 1, 2, 2, 3, 0
    };

    var vertexArray = va.vertexArray();
    var vertexBuffer = vb.vertexBuffer(@ptrCast(&positions[0]), @sizeOf(f32) * positions.len);

    var vertexBufferLayout = try vbl.vertexBufferLayout(std.heap.page_allocator);
    try vertexBufferLayout.pushf32(2, false);
    try vertexBufferLayout.pushf32(2, false);
    vertexArray.addBuffer(&vertexBuffer, &vertexBufferLayout);

    var indexBuffer = ib.indexBuffer(&indeces);

    var s = try shader.create("./res/shaders/basic.glsl", allocator);
    s.bind();
    //try s.setUniform4f("u_Color", 0.2, 0.3, 0.8, 1.0);

    var t = texture.texture("./res/textures/file.png");
    t.bind(0);
    try s.setUniform1i("u_Texture", 0);


    vertexArray.unbind();
    s.unbind();
    vertexBuffer.unbind();
    indexBuffer.unbind();
    std.debug.print("Setup done\n", .{});

    std.debug.print("GL Version: {s}\n", .{gl.glGetString(gl.GL_VERSION)});


    var render = renderer.Renderer{};
    var r: f32 = 0.0;
    var increment: f32 = 0.05;

    while(glfw.glfwWindowShouldClose(window) == 0) {
        render.clear();

        s.bind();
        try s.setUniform1i("u_Texture", 0);
        //try s.setUniform4f("u_Color", r, 0.3, 0.8, 1.0);

        render.draw(&vertexArray, &indexBuffer, &s);

        if (r > 1.0) {
            increment = -0.05;
        } else if (r < 0.0) {
            increment = 0.05;
        }
        r += increment;

        glfw.glfwSwapBuffers(window);
        glfw.glfwPollEvents();
        std.Thread.sleep(50000000);
    }


    vertexBuffer.destroy();
    indexBuffer.destroy();
    vertexArray.destroy();
    vertexBufferLayout.destroy();
    s.destroy();
    t.destroy();

    glfw.glfwDestroyWindow(window);
    glfw.glfwTerminate();

}

