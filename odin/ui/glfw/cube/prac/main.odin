package main

import "core:fmt"
import "vendor:glfw"
import gl "vendor:OpenGL"
import "core:log"
import "util"

WIDTH :: 1280
HEIGHT :: 720
CUBE_POSITIONS :: 1

main :: proc() {
  log.info("Init prac app")
  glfw.Init()
  defer glfw.Terminate()

  window := glfw.CreateWindow(WIDTH, HEIGHT, "prac", nil, nil)
  defer glfw.DestroyWindow(window)
  log.info("Create window handle")
  glfw.MakeContextCurrent(window)

  gl.load_up_to(3, 3, proc(p: rawptr, name: cstring) {
    (^rawptr)(p)^ = glfw.GetProcAddress(name)
  })
  gl.Enable(gl.DEPTH_TEST)

  shader := util.compileShader("vertex.glsl", "fragment.glsl")


  log.info("Shutdown prac app")
}
