package app

import "vendor:glfw"
import GL "vendor:OpenGL"
import "core:fmt"
import "core:c"

foreign import lib {
    "system:GLEW",
};

@(default_calling_convention="c")
foreign lib {
    glewInit :: proc() -> c.int ---
}


WIDTH :: 640
HEIGHT :: 480

main :: proc() {

    glfw.WindowHint(glfw.RESIZABLE, glfw.TRUE)
    glfw.WindowHint(glfw.OPENGL_FORWARD_COMPAT, glfw.TRUE)
    glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)
    glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, c.int(3))
    glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, c.int(3))



    if !bool(glfw.Init()) {
        fmt.eprintln("glfw Init error")
        return
    }

    window := glfw.CreateWindow(WIDTH, HEIGHT, "TEST WINDOW", nil, nil)
    if window == nil {
        fmt.eprintln("Create window error")
        return
    }

    glfw.MakeContextCurrent(window)
    glfw.SwapInterval(1)
    GL.Enable(GL.BLEND)

    // if glewInit() != 0 {
    //     fmt.eprintln("GLEW error")
    //     return
    // }

    fmt.printfln("GL Version %s", GL.GetString(GL.VERSION))


    position: [6]f32 = {
       -0.5, -0.5,
        0.0,  0.5,
        0.5, -0.5
    }

    buffer: u32
    vao: u32
    GL.GenVertexArrays(1, &vao)
    GL.GenBuffers(1, &buffer)

    GL.BindVertexArray(vao)
    GL.BindBuffer(GL.ARRAY_BUFFER, buffer)
    GL.BufferData(GL.ARRAY_BUFFER, size_of(position), raw_data(&position), GL.STATIC_DRAW)

    GL.EnableVertexAttribArray(0)
    GL.VertexAttribPointer(0, 2, GL.FLOAT, GL.FALSE, size_of(f32) * 2, 0)

    GL.BindVertexArray(0)

    for !bool(glfw.WindowShouldClose(window)) {
        GL.Clear(GL.COLOR_BUFFER_BIT)

        GL.DrawArrays(GL.TRIANGLES, 0, 3)
        glfw.SwapBuffers(window)
        glfw.PollEvents()
    }

    glfw.DestroyWindow(window)
    glfw.Terminate()
}
