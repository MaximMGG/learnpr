package glfw_win

import "core:fmt"
import "vendor:glfw"
import gl "vendor:OpenGL"


WIDTH :: 1600
HEIGHT :: 900
TITLE :: "My Window!"


GL_MAJOR_VERSION :: 4
GL_MINOR_VERSION :: 5

main :: proc() {
    if !bool(glfw.Init()) {
	fmt.eprintln("GLFW has failed to load.")
	return
    }

    window_handle := glfw.CreateWindow(WIDTH, HEIGHT, TITLE, nil, nil)
    if window_handle == nil {
	fmt.eprintln("GLFW has failed to load the window.")
	return
    }
    defer glfw.Terminate()
    defer glfw.DestroyWindow(window_handle)

    glfw.MakeContextCurrent(window_handle)

    gl.load_up_to(GL_MAJOR_VERSION, GL_MINOR_VERSION,
		  glfw.gl_set_proc_address)

    for !glfw.WindowShouldClose(window_handle) {
	glfw.PollEvents()

	gl.ClearColor(0.5, 0.0, 1.0, 1.0)

	gl.Clear(gl.COLOR_BUFFER_BIT)

	glfw.SwapBuffers(window_handle)
    }
    
    
}
