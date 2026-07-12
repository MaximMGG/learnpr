package creat_window


import "core:fmt"
import gl "vendor:OpenGL"
import glfw "vendor:glfw"
import "core:log"

WIDTH :: 640
HEIGHT :: 480

main :: proc() {

		if !glfw.Init() {
				log.error("glfwInit error")
				return
		}
		window: glfw.WindowHandle = glfw.CreateWindow(WIDTH, HEIGHT, "Create Window Test", nil, nil)
	  log.info("Create window")
		defer glfw.DestroyWindow(window)
		glfw.MakeContextCurrent(window)
		gl.load_up_to(3, 3, glfw.gl_set_proc_address)
		
		if window == nil {
				log.error("glfwCreateWindow error")
				return
		}

		for !glfw.WindowShouldClose(window) {


				glfw.SwapBuffers(window)
				glfw.PollEvents()
		}
		
}


