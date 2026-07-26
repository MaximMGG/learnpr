package camera


import "core:log"
import "core:os"
import "base:runtime"
import gl "vendor:OpenGL"
import "vendor:glfw"
import "shader"
import "texture"

WIDTH :: 1280
HEIGHT :: 720

init_logger :: proc() -> runtime.Logger {

  f: ^os.File
  f_err: os.Error

  if os.exists("gl_log.log") {
    f, f_err = os.open("gl_log.log", {.Append})
  } else {
    f, f_err = os.open("gl_log.log", {.Create, .Write, .Append})
  }
    return log.create_file_logger(f)
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

    log.info("initGlfw")

    window := glfw.CreateWindow(WIDTH, HEIGHT, "Camera window", nil, nil)
    glfw.WindowHint(glfw.VERSION_MAJOR, 3)
    glfw.WindowHint(glfw.VERSION_MINOR, 3)
    glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)

    glfw.MakeContextCurrent(window)

    gl.load_up_to(3, 3, glfw.gl_set_proc_address)

    log.info("setup window and load OpenGL library")

    prog, prog_err := shader.load_program("vertex.glsl", "fragment.glsl")
    if prog_err != nil {
      log.error("Load shader program error")
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


}

