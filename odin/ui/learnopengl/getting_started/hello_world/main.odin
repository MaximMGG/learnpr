package hello_wolrd


import gl "vendor:OpenGL"
import glfw "vendor:glfw"
import "core:log"


WIDTH :: 640
HEIGHT :: 480

framebuffer_size_callback :: proc "c" (window: glfw.WindowHandle, width, height: i32) {
		gl.Viewport(0, 0, WIDTH, HEIGHT)
}

main :: proc() {
		if !glfw.Init() {
				log.error("glfwInit error")
		}

		glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, 3)
		glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, 3)
		glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)

		window := glfw.CreateWindow(WIDTH, HEIGHT, "Hello world!", nil, nil)

		if window == nil {
				log.error("glfwCreateWindow error")
				return
		}
		log.info("Create Window")

		glfw.MakeContextCurrent(window)

		gl.load_up_to(3, 3, glfw.gl_set_proc_address)

		glfw.SetFramebufferSizeCallback(window, framebuffer_size_callback)

		for !glfw.WindowShouldClose(window) {
				gl.ClearColor(0.2, 0.3, 0.3, 1.0)
				gl.Clear(gl.COLOR_BUFFER_BIT)
				
				process_input(window)

				glfw.SwapBuffers(window)
				glfw.PollEvents()
		}

		glfw.DestroyWindow(window)
		glfw.Terminate()
}

process_input :: proc(window: glfw.WindowHandle) {
		if glfw.GetKey(window, glfw.KEY_ESCAPE) == glfw.PRESS {
				glfw.SetWindowShouldClose(window, true)
		}
}
