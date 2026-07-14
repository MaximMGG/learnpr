package textures

import "vendor:glfw"
import gl "vendor:OpenGL"
import "shader"
import "texture"
import stbi "vendor:stb/image"
import "core:log"
import "core:os"
import "core:fmt"
import "base:runtime"

WIDTH :: 640
HEIGHT :: 480

framebuffer_callback :: proc "c" (window: glfw.WindowHandle, width, height: i32) {
  gl.Viewport(0, 0, width, height)
}

init_logger :: proc() -> runtime.Logger {
  f: ^os.File
  err: os.Error
  if !os.exists("gl_log.log") {
    f, err = os.open("gl_log.log", {.Create, .Write, .Read})
    if err != nil {
      fmt.eprintln("Failed to create gl_log.log file")
      return log.create_file_logger(f)
    }
  } else {
    f, err = os.open("gl_log.log", {.Write})
  }
  return log.create_file_logger(f, .Debug)
}

deinit_logger :: proc() {
    log.destroy_file_logger(context.logger)
} 

main :: proc() {
  context.logger = init_logger()
  defer deinit_logger()

  if !glfw.Init() {
    log.error("glfwInit error")
  }

  log.info("glfw Init")

  window := glfw.CreateWindow(WIDTH, HEIGHT, "Texture window", nil, nil)
  if window == nil {
    log.error("glfwCreateWindow error")
    glfw.Terminate()
    return
  }

  log.info("Create Window")

  glfw.WindowHint(glfw.VERSION_MAJOR, 3)
  glfw.WindowHint(glfw.VERSION_MINOR, 3)
  glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)

  glfw.MakeContextCurrent(window)
  glfw.SetFramebufferSizeCallback(window, framebuffer_callback)

  gl.load_up_to(3, 3, glfw.gl_set_proc_address)

  log.info("Load OpenGL 3.3")


  tex, tex_err := texture.load("wall.jpg")
  if tex_err != nil {
    glfw.Terminate()
  }

  program, p_err := shader.load_program("./vertex.glsl", "./fragment.glsl")
  if p_err != nil {
    log.error("Load program error:", p_err)
    glfw.Terminate()
  }

  vertices := [?]f32 {
    //position       //colors         //texture coords 
     0.5,  0.5, 0.0,   1.0, 0.0, 0.0,   1.0, 1.0, // top right
     0.5, -0.5, 0.0,   0.0, 1.0, 0.0,   1.0, 0.0, // bottom right
    -0.5, -0.5, 0.0,   0.0, 0.0, 1.0,   0.0, 0.0, // bottom left
    -0.5,  0.5, 0.0,   1.0, 0.0, 0.0,   0.0, 1.0, // top left
  }
  indecies := [?]u32 {
    0, 1, 2,
    2, 3, 0
  }

  VBO, EBO, VAO: u32
  gl.GenVertexArrays(1, &VAO)
  gl.GenBuffers(1, &VBO)
  gl.GenBuffers(1, &EBO)

  gl.BindVertexArray(VAO)
  gl.BindBuffer(gl.ARRAY_BUFFER, VBO)
  gl.BufferData(gl.ARRAY_BUFFER, size_of(vertices), &vertices[0], gl.STATIC_DRAW)

  gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, EBO)
  gl.BufferData(gl.ELEMENT_ARRAY_BUFFER, size_of(indecies), &indecies[0], gl.STATIC_DRAW)

  gl.VertexAttribPointer(0, 3, gl.FLOAT, gl.FALSE, 8 * size_of(f32), uintptr(0))
  gl.EnableVertexAttribArray(0)

  gl.VertexAttribPointer(1, 3, gl.FLOAT, gl.FALSE, 8 * size_of(f32), uintptr(3 * size_of(f32)))
  gl.EnableVertexAttribArray(1)

  gl.VertexAttribPointer(2, 2, gl.FLOAT, gl.FALSE, 8 * size_of(f32), uintptr(6 * size_of(f32)))
  gl.EnableVertexAttribArray(2)

  gl.BindBuffer(gl.ARRAY_BUFFER, 0)
  gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, 0)
  gl.BindVertexArray(0)

  for !glfw.WindowShouldClose(window) {
    gl.ClearColor(0.2, 0.3, 0.3, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT)

    process_input(window)

    gl.UseProgram(program)
    gl.BindTexture(gl.TEXTURE_2D, tex)
    gl.BindVertexArray(VAO)
    gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, EBO)
    gl.DrawElements(gl.TRIANGLES, 6, gl.UNSIGNED_INT, nil)

    glfw.SwapBuffers(window)
    glfw.PollEvents()
  }

  gl.DeleteTextures(1, &tex)
  glfw.DestroyWindow(window)
  glfw.Terminate()
  log.info("Terminate")
}

process_input :: proc(window: glfw.WindowHandle) {
  if glfw.GetKey(window, glfw.KEY_ESCAPE) == glfw.PRESS {
    glfw.SetWindowShouldClose(window, true)
  }
}
