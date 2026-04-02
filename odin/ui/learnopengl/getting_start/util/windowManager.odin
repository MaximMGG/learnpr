package util

import "vendor:glfw"
import gl "vendor:OpenGL"

windowCreate :: proc(width, height: i32, name: string) -> glfw.WindowHandle {
  glfw.Init()
  window := glfw.CreateWindow(width, height, cstring(raw_data(name)), nil, nil)
  glfw.MakeContextCurrent(window)

  gl.load_up_to(3, 3, proc(p: rawptr, name: cstring) {
    (^rawptr)(p)^ = glfw.GetProcAddress(name)
  })

  gl.Enable(gl.DEPTH_TEST)

  return window
}

windowDestroy :: proc(window: glfw.WindowHandle) {
  glfw.DestroyWindow(window)
  glfw.Terminate()
}
