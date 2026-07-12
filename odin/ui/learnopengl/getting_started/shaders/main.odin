package shaders


import gl "vendor:OpenGL"
import "vendor:glfw"
import "core:log"

WIDTH :: 640
HEIGHT :: 480

framebuffer_callback :: proc "c" (window: glfw.WindowHandle, width, height: i32) {
  gl.Viewport(0, 0, width, height)
}

main :: proc() {
  if !glfw.Init() {
    log.error("glfwInit error")
    return
  }

  window := glfw.CreateWindow(WIDTH, HEIGHT, "Shaders window", nil, nil)
  if window == nil {
    log.error("glfwCreateWindow error")
    glfw.Terminate()
    return
  }

  glfw.WindowHint(glfw.VERSION_MAJOR, 3)
  glfw.WindowHint(glfw.VERSION_MINOR, 3)
  glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)

  glfw.SetFramebufferSizeCallback(window, framebuffer_callback)
  glfw.MakeContextCurrent(window)

  gl.load_up_to(3, 3, glfw.gl_set_proc_address)

  for !glfw.WindowShouldClose(window) {

  }
}

process_input :: proc(window: glfw.WindowHandle) {
  if glfw.GetKey(window, glfw.KEY_ESCAPE) == glfw.PRESS {
    glfw.SetWindowShouldClose(window, true)
  }
}
