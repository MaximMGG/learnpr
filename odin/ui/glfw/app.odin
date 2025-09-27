
package app


import "vendor:glfw"
import GL "vendor:OpenGL"
import "core:fmt"

WIDTH :: 640
HEIGHT :: 480

main :: proc() {
    if !bool(glfw.Init()) {
	fmt.eprintln("Error glfw Init")
	return
    }
    defer glfw.Terminate()

    window := glfw.CreateWindow(WIDTH, HEIGHT, "Test window", nil, nil)
    
    if window == nil {
	fmt.eprintln("CreaetWindow error")
	glfw.Terminate()
	return
    }

    glfw.MakeContextCurrent(window)

    for !bool(glfw.WindowShouldClose(window)) {
	GL.Clear(GL.COLOR_BUFFER_BIT)

	glfw.SwapBuffers(window)

	glfw.PollEvents()
    }

    glfw.DestroyWindow(window)
    glfw.Terminate()
}
