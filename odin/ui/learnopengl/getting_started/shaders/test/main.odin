package test_package

import "../shader"
import gl "vendor:OpenGL"
import "vendor:glfw"
import "core:log"
import la "core:math/linalg"
import "core:fmt"

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
    f32(WIDTH * 0.75), f32(HEIGHT * 0.75),
    f32(WIDTH * 0.25), f32(HEIGHT * 0.75),
    f32(WIDTH * 0.25), f32(HEIGHT * 0.25),

    f32(WIDTH * 0.75), f32(HEIGHT * 0.75),
    f32(WIDTH * 0.25), f32(HEIGHT * 0.25),
    f32(WIDTH * 0.75), f32(HEIGHT * 0.25)
  }

  VBO, VAO: u32
  gl.GenVertexArrays(1, &VAO)
  gl.GenBuffers(1, &VBO)

  gl.BindVertexArray(VAO)
  gl.BindBuffer(gl.ARRAY_BUFFER, VBO)
  gl.BufferData(gl.ARRAY_BUFFER, size_of(vertices), &vertices[0], gl.STATIC_DRAW)

  gl.VertexAttribPointer(0, 2, gl.FLOAT, gl.FALSE, 2 * size_of(f32), uintptr(0))
  gl.EnableVertexAttribArray(0)

  gl.BindBuffer(gl.ARRAY_BUFFER, 0)
  gl.BindVertexArray(0)

  projection := la.matrix_ortho3d_f32(0.0, f32(WIDTH), 0.0, f32(HEIGHT), -1.0, 100.0)
  gl.UseProgram(program)
  shader.set_uniformMat4(program, "projection", projection)

  inside: bool = false
  inside_color: f32 = 0.2
  not_inside_color: f32 = 0.4

  for !glfw.WindowShouldClose(window) {
    gl.ClearColor(0.2, 0.3, 0.3, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT)

    process_input(window)


    gl.UseProgram(program)
    if inside {
      shader.set_uniform1f(program, "inside", inside_color)
    } else {
      shader.set_uniform1f(program, "inside", not_inside_color)
    }

    gl.BindVertexArray(VAO)
    gl.DrawArrays(gl.TRIANGLES, 0, 6)

    x, y := glfw.GetCursorPos(window)
    if (x >= f64(WIDTH * 0.25) && x <= f64(WIDTH * 0.75) && y >= f64(HEIGHT * 0.25) && y <= f64(HEIGHT * 0.75)) {
      inside = true
      fmt.println("inside", x, y)
    } else {
      inside = false
    }

    glfw.SwapBuffers(window)
    glfw.PollEvents()
  }
}

process_input :: proc(window: glfw.WindowHandle) {
  if glfw.GetKey(window, glfw.KEY_ESCAPE) == glfw.PRESS {
    glfw.SetWindowShouldClose(window, true)
  }
}
