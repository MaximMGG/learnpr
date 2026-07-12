package shaders

import "shader"
import gl "vendor:OpenGL"
import "vendor:glfw"
import "core:log"
import "core:math"

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

  glfw.MakeContextCurrent(window)
  gl.load_up_to(3, 3, glfw.gl_set_proc_address)

  glfw.SetFramebufferSizeCallback(window, framebuffer_callback)

  program, program_ok := shader.load_program("./vertex.glsl", "./fragment.glsl")
  if program_ok != nil {
    log.error("load program error:", program_ok)
  }

  vertices := [?]f32 {
     0.5, -0.5, 0.0, 1.0, 0.0, 0.0,
    -0.5, -0.5, 0.0, 0.0, 1.0, 0.0,
     0.0,  0.5, 0.0, 0.0, 0.0, 1.0,

  }

  VBO, VAO: u32
  gl.GenVertexArrays(1, &VAO)
  gl.GenBuffers(1, &VBO)

  gl.BindVertexArray(VAO)
  gl.BindBuffer(gl.ARRAY_BUFFER, VBO)
  gl.BufferData(gl.ARRAY_BUFFER, size_of(vertices), &vertices[0], gl.STATIC_DRAW)

  gl.VertexAttribPointer(0, 3, gl.FLOAT, gl.FALSE, 6 * size_of(f32), uintptr(0))
  gl.EnableVertexAttribArray(0)

  gl.VertexAttribPointer(1, 3, gl.FLOAT, gl.FALSE, 6 * size_of(f32), uintptr(3 * size_of(f32)))
  gl.EnableVertexAttribArray(1)

  gl.BindBuffer(gl.ARRAY_BUFFER, 0)
  gl.BindVertexArray(0)

  horizontal_offset: f32 = 0.0
  oposite: bool = false

  for !glfw.WindowShouldClose(window) {
    gl.ClearColor(0.2, 0.3, 0.3, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT)

    process_input(window)

    if !oposite {
      horizontal_offset -= 0.01
      if horizontal_offset < -0.5 {
        oposite = true
      }
    } else {
      horizontal_offset += 0.01
      if horizontal_offset > 0.5 {
        oposite = false
      }
    }

    gl.UseProgram(program)
    if shader.set_uniform1f(program, "offset", horizontal_offset) != nil {
      log.error("Set Uniform error")
    }

    gl.BindVertexArray(VAO)
    gl.DrawArrays(gl.TRIANGLES, 0, 3)

    glfw.SwapBuffers(window)
    glfw.PollEvents()
  }
}

process_input :: proc(window: glfw.WindowHandle) {
  if glfw.GetKey(window, glfw.KEY_ESCAPE) == glfw.PRESS {
    glfw.SetWindowShouldClose(window, true)
  }
}
