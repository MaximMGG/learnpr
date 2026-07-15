package transformation


import "vendor:glfw"
import gl "vendor:OpenGL"
import "shader"
import "texture"
import "core:os"
import "core:log"
import "base:runtime"
import "core:fmt"
import la "core:math/linalg"

WIDTH :: 640
HEIGHT :: 480


init_logger :: proc() -> runtime.Logger {
  f: ^os.File
  f_err: os.Error
  if os.exists("./gl_log.log") {
    f, f_err = os.open("./gl_log.log", {.Append, .Write, .Read})
    if f_err != nil {
      fmt.eprintln("Can't open gl_log.log")
      os.exit(1)
    }
  } else {
    f, f_err = os.open("./gl_log.log", {.Create, .Write, .Append})
    if f_err != nil {
      fmt.eprintln("Can't create gl_log.log")
      os.exit(1)
    }
  }
  return log.create_file_logger(f)
}

deinit_logger :: proc() {
  log.destroy_file_logger(context.logger)
}

framebuffer_callback :: proc "c" (window: glfw.WindowHandle, width, height: i32) {
  gl.Viewport(0, 0, width, height)
}

main :: proc() {
  context.logger = init_logger()
  defer deinit_logger()

  if !glfw.Init() {
    log.error("glfwInit error")
    return
  }

  window := glfw.CreateWindow(WIDTH, HEIGHT, "Transformation window", nil, nil)
  if window == nil {
    log.error("Can't create window")
    glfw.Terminate()
    return
  }
  log.info("Create glfw Window")

  glfw.WindowHint(glfw.VERSION_MAJOR, 3)
  glfw.WindowHint(glfw.VERSION_MINOR, 3)
  glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)

  glfw.MakeContextCurrent(window)
  glfw.SetFramebufferSizeCallback(window, framebuffer_callback)

  gl.load_up_to(3, 3, glfw.gl_set_proc_address)

  program, program_err := shader.load_program("./vertex.glsl", "./fragment.glsl")
  if program_err != nil {
    log.error("load_program error:", program_err)
  }

  tex1, tex1_err := texture.load_jpg("./container.jpg")
  if tex1_err != nil {
    log.error("load_jpg error:", tex1_err)
  }
  tex2, tex2_err := texture.load_png("./awesomeface.png")
  if tex2_err != nil {
    log.error("load_png error:", tex1_err)
  }

  vertices := [?]f32 {
    // positions          // texture coords
     0.5,  0.5, 0.0,   1.0, 1.0, // top right
     0.5, -0.5, 0.0,   1.0, 0.0, // bottom right
    -0.5, -0.5, 0.0,   0.0, 0.0, // bottom left
    -0.5,  0.5, 0.0,   0.0, 1.0  // top left 
  }
  indices := [?]u32 {
    0, 1, 3, // first triangle
    1, 2, 3  // second triangle
  }

  VBO, EBO, VAO: u32
  gl.GenVertexArrays(1, &VAO)
  gl.GenBuffers(1, &VBO)
  gl.GenBuffers(1, &EBO)

  gl.BindVertexArray(VAO)

  gl.BindBuffer(gl.ARRAY_BUFFER, VBO)
  gl.BufferData(gl.ARRAY_BUFFER, size_of(vertices), &vertices[0], gl.STATIC_DRAW)

  gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, EBO)
  gl.BufferData(gl.ELEMENT_ARRAY_BUFFER, size_of(indices), &indices[0], gl.STATIC_DRAW)

  gl.VertexAttribPointer(0, 3, gl.FLOAT, gl.FALSE, 5 * size_of(f32), uintptr(0))
  gl.EnableVertexAttribArray(0)

  gl.VertexAttribPointer(1, 2, gl.FLOAT, gl.FALSE, 5 * size_of(f32), uintptr(3 * size_of(f32)))
  gl.EnableVertexAttribArray(1)
  
  gl.BindBuffer(gl.ARRAY_BUFFER, 0)
  gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, 0)
  gl.BindVertexArray(0)

  gl.UseProgram(program)
  shader.set_uniform1i(program, "texture1", 0)
  shader.set_uniform1i(program, "texture2", 1)


  for !glfw.WindowShouldClose(window) {
    gl.ClearColor(0.2, 0.3, 0.3, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT)

    process_input(window)

    gl.ActiveTexture(gl.TEXTURE0)
    gl.BindTexture(gl.TEXTURE_2D, tex1)
    gl.ActiveTexture(gl.TEXTURE1)
    gl.BindTexture(gl.TEXTURE_2D, tex2)


    transform := la.Matrix4f32(1.0)
    transform *= la.matrix4_translate(la.Vector3f32{0.5, -0.5, 0.0})
    transform *= la.matrix4_rotate(f32(glfw.GetTime()), la.Vector3f32{0.0, 0.0, 1.0})

    gl.UseProgram(program)
    shader.set_unfiromMat4(program, "transform", transform)

    gl.BindVertexArray(VAO)
    gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, EBO)
    gl.DrawElements(gl.TRIANGLES, 6, gl.UNSIGNED_INT, nil)

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
