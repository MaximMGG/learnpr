package app

import "vendor:glfw"
import GL "vendor:OpenGL"
import "core:fmt"

WIDTH :: 640
HEIGHT :: 480

main :: proc() {
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

    fmt.printfln("GL Version %s", GL.GetString(GL.VERSION))


    position: [6]f32 = {
	    -0.5, -0.5,
	     0.0,  0.5,
	     0.5, -0.5
    }

    buffer: u32
    GL.GenBuffers(1, &buffer)
    GL.BindBuffer(GL.ARRAY_BUFFER, buffer)
    GL.BufferData(GL.ARRAY_BUFFER, size_of(position), raw_data(position[:]), GL.STATIC_DRAW)

    GL.EnableVertexAttribArray(0)
    GL.VertexAttribPointer(0, 2, GL.FLOAT, GL.FALSE, size_of(f32) * 2, uintptr(0))

    for !bool(glfw.WindowShouldClose(window)) {
	GL.Clear(GL.COLOR_BUFFER_BIT)

	GL.DrawArrays(GL.TRIANGLES, 0, 3)
	glfw.SwapBuffers(window)
	glfw.PollEvents()
    }

    glfw.DestroyWindow(window)
    glfw.Terminate()
}
