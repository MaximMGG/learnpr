package coordinate

import "shader"
import "texture"
import gl "vendor:OpenGL"
import "vendor:glfw"
import "core:os"
import "core:log"
import "base:runtime"
import la "core:math/linalg"

WIDTH :: 1280
HEIGHT :: 960

init_logger :: proc() -> runtime.Logger {
  f: ^os.File
  f_err: os.Error
  if os.exists("gl_log.log") {
    f, f_err = os.open("gl_log.log", {.Write, .Append})
  } else {
    f, f_err = os.open("gl_log.log", {.Create, .Write, .Append})
  }

  return log.create_file_logger(f)
}

framebuffer_callback :: proc "c" (window: glfw.WindowHandle, width, height: i32) {
  gl.Viewport(0, 0, width, height)
}

deinit_logger :: proc() {
  log.destroy_file_logger(context.logger)
}

main :: proc() {
  context.logger = init_logger()
  defer deinit_logger()
  if !glfw.Init() {
    log.error("glfwInit error")
    return
  }
  log.info("glfwInit")

  window := glfw.CreateWindow(WIDTH, HEIGHT, "Coordinate window", nil, nil)

  glfw.WindowHint(glfw.VERSION_MAJOR, 3)
  glfw.WindowHint(glfw.VERSION_MINOR, 3)
  glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)

  glfw.MakeContextCurrent(window)

  glfw.SetFramebufferSizeCallback(window, framebuffer_callback)
  gl.load_up_to(3, 3, glfw.gl_set_proc_address)
  gl.Enable(gl.DEPTH_TEST)

  log.info("Init OpenGL")

  program, program_err := shader.load_program("vertex.glsl", "fragment.glsl")
  if program_err != nil {
    log.error("Load Pogram Error")
  }
  tex1, tex1_err := texture.load_jpg("container.jpg")
  if tex1_err != nil {
    log.error("Load Jpg error")
  }
  tex2, tex2_err := texture.load_png("awesomeface.png")
  if tex2_err != nil {
    log.error("Load Png error")
  }

  vertices := [?]f32 {
    -0.5, -0.5, -0.5,  0.0, 0.0,
     0.5, -0.5, -0.5,  1.0, 0.0,
     0.5,  0.5, -0.5,  1.0, 1.0,
     0.5,  0.5, -0.5,  1.0, 1.0,
    -0.5,  0.5, -0.5,  0.0, 1.0,
    -0.5, -0.5, -0.5,  0.0, 0.0,

    -0.5, -0.5,  0.5,  0.0, 0.0,
     0.5, -0.5,  0.5,  1.0, 0.0,
     0.5,  0.5,  0.5,  1.0, 1.0,
     0.5,  0.5,  0.5,  1.0, 1.0,
    -0.5,  0.5,  0.5,  0.0, 1.0,
    -0.5, -0.5,  0.5,  0.0, 0.0,

    -0.5,  0.5,  0.5,  1.0, 0.0,
    -0.5,  0.5, -0.5,  1.0, 1.0,
    -0.5, -0.5, -0.5,  0.0, 1.0,
    -0.5, -0.5, -0.5,  0.0, 1.0,
    -0.5, -0.5,  0.5,  0.0, 0.0,
    -0.5,  0.5,  0.5,  1.0, 0.0,

     0.5,  0.5,  0.5,  1.0, 0.0,
     0.5,  0.5, -0.5,  1.0, 1.0,
     0.5, -0.5, -0.5,  0.0, 1.0,
     0.5, -0.5, -0.5,  0.0, 1.0,
     0.5, -0.5,  0.5,  0.0, 0.0,
     0.5,  0.5,  0.5,  1.0, 0.0,

    -0.5, -0.5, -0.5,  0.0, 1.0,
     0.5, -0.5, -0.5,  1.0, 1.0,
     0.5, -0.5,  0.5,  1.0, 0.0,
     0.5, -0.5,  0.5,  1.0, 0.0,
    -0.5, -0.5,  0.5,  0.0, 0.0,
    -0.5, -0.5, -0.5,  0.0, 1.0,

    -0.5,  0.5, -0.5,  0.0, 1.0,
     0.5,  0.5, -0.5,  1.0, 1.0,
     0.5,  0.5,  0.5,  1.0, 0.0,
     0.5,  0.5,  0.5,  1.0, 0.0,
    -0.5,  0.5,  0.5,  0.0, 0.0,
    -0.5,  0.5, -0.5,  0.0, 1.0
  }

  cube_positions := [?]la.Vector3f32{
    la.Vector3f32{ 0.0,  0.0,  0.0}, 
    la.Vector3f32{ 2.0,  5.0, -15.0}, 
    la.Vector3f32{-1.5, -2.2, -2.5},  
    la.Vector3f32{-3.8, -2.0, -12.3},  
    la.Vector3f32{ 2.4, -0.4, -3.5},  
    la.Vector3f32{-1.7,  3.0, -7.5},  
    la.Vector3f32{ 1.3, -2.0, -2.5},  
    la.Vector3f32{ 1.5,  2.0, -2.5}, 
    la.Vector3f32{ 1.5,  0.2, -1.5}, 
    la.Vector3f32{-1.3,  1.0, -1.5}
  }

  VBO, VAO: u32
  gl.GenVertexArrays(1, &VAO)
  gl.GenBuffers(1, &VBO)

  gl.BindVertexArray(VAO)

  gl.BindBuffer(gl.ARRAY_BUFFER, VBO)
  gl.BufferData(gl.ARRAY_BUFFER, size_of(vertices), &vertices[0], gl.STATIC_DRAW)

  gl.VertexAttribPointer(0, 3, gl.FLOAT, gl.FALSE, 5 * size_of(f32), uintptr(0))
  gl.EnableVertexAttribArray(0)

  gl.VertexAttribPointer(1, 2, gl.FLOAT, gl.FALSE, 5 * size_of(f32), uintptr(3 * size_of(f32)))
  gl.EnableVertexAttribArray(1)

  gl.UseProgram(program)
  shader.set_uniform1i(program, "texture1", 0)
  shader.set_uniform1i(program, "texture2", 1)


  for !glfw.WindowShouldClose(window) {
    process_input(window)

    gl.ClearColor(0.2, 0.3, 0.3, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)

    gl.ActiveTexture(gl.TEXTURE0)
    gl.BindTexture(gl.TEXTURE_2D, tex1)

    gl.ActiveTexture(gl.TEXTURE1)
    gl.BindTexture(gl.TEXTURE_2D, tex2)


    view := la.MATRIX4F32_IDENTITY
    projection := la.MATRIX4F32_IDENTITY
    view *= la.matrix4_translate_f32(la.Vector3f32{0.0, 0.0, -4.0})
    projection  *= la.matrix4_perspective_f32(f32(la.to_radians(45.0)), f32(WIDTH) / f32(HEIGHT), 0.1, 100.0)

    shader.set_unfiromMat4(program, "view", view)
    shader.set_unfiromMat4(program, "projection", projection)


    gl.BindVertexArray(VAO)
    for i in 0..<len(cube_positions) {
      model := la.MATRIX4F32_IDENTITY
      model *= la.matrix4_translate_f32(cube_positions[i])
      model *= la.matrix4_rotate_f32(f32(glfw.GetTime()) * 0.125 * f32(i), la.Vector3f32{1.0, 0.3, 0.5})
      shader.set_unfiromMat4(program, "model", model)
      gl.DrawArrays(gl.TRIANGLES, 0, 36)

    }

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
