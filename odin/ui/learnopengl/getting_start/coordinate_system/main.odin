package coordinate_system


import "core:fmt"
import "core:os"

import "vendor:glfw"
import gl "vendor:OpenGL"
import "vendor:stb/image"

import "shader"

WIDTH :: 800
HEIGHT :: 600

main :: proc() {
  glfw.Init()
  window := glfw.CreateWindow(WIDTH, HEIGHT, "Test scrin", nil, nil)
  if window == nil {
    fmt.eprintln("glfw.CreateWindow error")
    return
  }

  glfw.MakeContextCurrent(window)
  gl.load_up_to(3, 3, proc(p: rawptr, name: cstring) {
    (^rawptr)(p)^ = glfw.GetProcAddress(name)
  })

  gl.Enable(gl.DEPTH_TEST)

  program, program_ok := shader.createShader("./vertex.glsl", "./fragment.glsl")
  if !program_ok {
    fmt.eprintln("CreateShader error")
    glfw.DestroyWindow(window)
    glfw.Terminate()
    return
  }

}
