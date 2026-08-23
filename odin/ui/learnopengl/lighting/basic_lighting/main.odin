package basic_lighting

import "core:log"
import "core:os"
import "base:runtime"
import "shader"
import "core:fmt"

import "vendor:glfw"
import gl "vendor:OpenGL"
import la "core:math/linalg"


Vec3 :: la.Vector3f32
Mat4 :: la.Matrix4x4f32



WIDTH :: 1280
HEIGHT :: 720
delta_time: f32
last_frame: f32
light_pos :: Vec3{1.2, 1.0, 2.0}
lastX: f32 = f32(WIDTH) / 2.0
lastY: f32 = f32(HEIGHT) / 2.0
first_mouse := true


framebuffer_callback :: proc "c" (window: glfw.WindowHandle, width, height: i32) {
  gl.Viewport(0, 0, width, height)
}

process_input :: proc(window: glfw.WindowHandle) {
  if glfw.GetKey(window, glfw.KEY_ESCAPE) == glfw.PRESS {
    glfw.SetWindowShouldClose(window, true)
  }
}

init_logger :: proc() -> runtime.Logger {
  f: ^os.File
  f_err: os.Error
  if os.exists("gl_log.log") {

    f, f_err = os.open("gl_log.log", {.Append})
    if f_err != nil {
      fmt.eprintln("Can't open gl_log:", f_err)
    }

    return log.create_file_logger(f)
  } else {
    f, f_err = os.open("gl_log.log", {.Create, .Write, .Append})
    return log.create_file_logger(f)
  }
}

deinit_logger :: proc() {
  log.destroy_file_logger(context.logger)
}

main :: proc() {
  context.logger = init_logger()
  defer deinit_logger()

  glfw.Init()
  defer glfw.Terminate()

  window := glfw.CreateWindow(WIDTH, HEIGHT, "Basic color", nil, nil)
  defer glfw.DestroyWindow(window)
  if window == nil {
    log.error("glfwCreateWindow error")
    return
  }


  glfw.WindowHint(glfw.VERSION_MAJOR, 3)
  glfw.WindowHint(glfw.VERSION_MINOR, 3)
  glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)
  glfw.SetFramebufferSizeCallback(window, framebuffer_callback)


  glfw.MakeContextCurrent(window)

  gl.load_up_to(3, 3, glfw.gl_set_proc_address)
  gl.Enable(gl.DEPTH_TEST)

  log.info("Init glfw and OpenGL")


  cube_shader := shader.load("cube_vertex.glsl", "cube_framgnet.glsl")
  if cube_shader.id == 0 {
    log.error("Cant load cube shader")
    return
  }
  light_shader := shader.load("light_vertex.glsl", "light_fragment.glsl")
  if light_shader.id == 0 {
    log.error("Cant' load light shader")
    return
  }

  vertices := [?]f32 {
        -0.5, -0.5, -0.5,  0.0,  0.0, -1.0,
         0.5, -0.5, -0.5,  0.0,  0.0, -1.0,
         0.5,  0.5, -0.5,  0.0,  0.0, -1.0,
         0.5,  0.5, -0.5,  0.0,  0.0, -1.0,
        -0.5,  0.5, -0.5,  0.0,  0.0, -1.0,
        -0.5, -0.5, -0.5,  0.0,  0.0, -1.0,

        -0.5, -0.5,  0.5,  0.0,  0.0,  1.0,
         0.5, -0.5,  0.5,  0.0,  0.0,  1.0,
         0.5,  0.5,  0.5,  0.0,  0.0,  1.0,
         0.5,  0.5,  0.5,  0.0,  0.0,  1.0,
        -0.5,  0.5,  0.5,  0.0,  0.0,  1.0,
        -0.5, -0.5,  0.5,  0.0,  0.0,  1.0,

        -0.5,  0.5,  0.5, -1.0,  0.0,  0.0,
        -0.5,  0.5, -0.5, -1.0,  0.0,  0.0,
        -0.5, -0.5, -0.5, -1.0,  0.0,  0.0,
        -0.5, -0.5, -0.5, -1.0,  0.0,  0.0,
        -0.5, -0.5,  0.5, -1.0,  0.0,  0.0,
        -0.5,  0.5,  0.5, -1.0,  0.0,  0.0,

         0.5,  0.5,  0.5,  1.0,  0.0,  0.0,
         0.5,  0.5, -0.5,  1.0,  0.0,  0.0,
         0.5, -0.5, -0.5,  1.0,  0.0,  0.0,
         0.5, -0.5, -0.5,  1.0,  0.0,  0.0,
         0.5, -0.5,  0.5,  1.0,  0.0,  0.0,
         0.5,  0.5,  0.5,  1.0,  0.0,  0.0,

        -0.5, -0.5, -0.5,  0.0, -1.0,  0.0,
         0.5, -0.5, -0.5,  0.0, -1.0,  0.0,
         0.5, -0.5,  0.5,  0.0, -1.0,  0.0,
         0.5, -0.5,  0.5,  0.0, -1.0,  0.0,
        -0.5, -0.5,  0.5,  0.0, -1.0,  0.0,
        -0.5, -0.5, -0.5,  0.0, -1.0,  0.0,

        -0.5,  0.5, -0.5,  0.0,  1.0,  0.0,
         0.5,  0.5, -0.5,  0.0,  1.0,  0.0,
         0.5,  0.5,  0.5,  0.0,  1.0,  0.0,
         0.5,  0.5,  0.5,  0.0,  1.0,  0.0,
        -0.5,  0.5,  0.5,  0.0,  1.0,  0.0,
        -0.5,  0.5, -0.5,  0.0,  1.0,  0.0
    }


    cubeVAO, lightVAO, VBO: u32

    gl.GenVertexArrays(1, &cubeVAO)
    gl.GenVertexArrays(1, &lightVAO)
    gl.GenBuffers(1, &VBO)

    gl.BindVertexArray(cubeVAO)
    gl.BindBuffer(gl.ARRAY_BUFFER, VBO)

    gl.BufferData(gl.ARRAY_BUFFER, size_of(vertices), &vertices[0], gl.STATIC_DRAW)

    gl.VertexAttribPointer(0, 3, gl.FLOAT, gl.FALSE, 6 * size_of(f32), uintptr(0))
    gl.EnableVertexAttribArray(0)

    gl.VertexAttribPointer(1, 3, gl.FLOAT, gl.FALSE, 6 * size_of(f32), uintptr(3 * size_of(f32)))
    gl.EnableVertexAttribArray(1)

    gl.BindVertexArray(lightVAO)
    gl.BindBuffer(gl.ARRAY_BUFFER, VBO)

    gl.VertexAttribPointer(0, 3, gl.FLOAT, gl.FALSE, 6 * size_of(f32), uintptr(0))
    gl.EnableVertexAttribArray(0)


    for !glfw.WindowShouldClose(window) {
      current_frame := f32(glfw.GetTime())
      delta_time = current_frame - last_frame
      last_frame = current_frame

      process_input(window)

      gl.ClearColor(0.1, 0.1, 0.1, 1.0);
      gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)

      shader.use(&cube_shader)
      shader.set_vec3(&cube_shader, "objectColor", Vec3{1.0, 0.5, 0.31})
      shader.set_vec3(&cube_shader, "lightColor", Vec3{1.0, 1.0, 1.0})
      shader.set_vec3(&cube_shader, "lightPos", Vec3{1.0, 0.5, 0.31})
      shader.set_vec3(&cube_shader, "viewPos", Vec3{1.0, 0.5, 0.31})





    }



}
