package basic_lighting

import "core:log"
import "core:os"
import "base:runtime"
import "shader"
import cam "camera"
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
light_pos := Vec3{1.2, 1.0, 2.0}
lastX: f32 = f32(WIDTH) / 2.0
lastY: f32 = f32(HEIGHT) / 2.0
first_mouse := true
camera: cam.Camera


framebuffer_callback :: proc "c" (window: glfw.WindowHandle, width, height: i32) {
  gl.Viewport(0, 0, width, height)
}

process_input :: proc(window: glfw.WindowHandle) {
  if glfw.GetKey(window, glfw.KEY_ESCAPE) == glfw.PRESS {
    glfw.SetWindowShouldClose(window, true)
  }

  if glfw.GetKey(window, glfw.KEY_W) == glfw.PRESS {
    cam.process_keyboard(&camera, .FORWARD, delta_time)
  }
  if glfw.GetKey(window, glfw.KEY_S) == glfw.PRESS {
    cam.process_keyboard(&camera, .BACKWARD, delta_time)
  }
  if glfw.GetKey(window, glfw.KEY_A) == glfw.PRESS {
    cam.process_keyboard(&camera, .LEFT, delta_time)
  }
  if glfw.GetKey(window, glfw.KEY_D) == glfw.PRESS {
    cam.process_keyboard(&camera, .RIGHT, delta_time)
  }
  if glfw.GetKey(window, glfw.KEY_LEFT) == glfw.PRESS {
    light_pos.x -= 0.1
  }
  if glfw.GetKey(window, glfw.KEY_RIGHT) == glfw.PRESS {
    light_pos.x += 0.1
  }
  if glfw.GetKey(window, glfw.KEY_UP) == glfw.PRESS {
    light_pos.y += 0.1
  }
  if glfw.GetKey(window, glfw.KEY_DOWN) == glfw.PRESS {
    light_pos.y -= 0.1
  }
  if glfw.GetKey(window, glfw.KEY_Q) == glfw.PRESS {
    light_pos.z -= 0.1
  }
  if glfw.GetKey(window, glfw.KEY_E) == glfw.PRESS {
    light_pos.z += 0.1
  }
}

mouse_callback :: proc "c" (window: glfw.WindowHandle, xpos_in, ypos_in: f64) {
  context = runtime.default_context()
  xpos := f32(xpos_in)
  ypos := f32(ypos_in)

  if first_mouse {
    lastX = xpos
    lastY = ypos
    first_mouse = false
  }

  xoffset := xpos - lastX
  yoffset := lastY - ypos

  lastX = xpos
  lastY = ypos

  cam.process_mouse_movement(&camera, xoffset, yoffset)
}

scroll_callback :: proc "c" (window: glfw.WindowHandle, xoffset, yoffset: f64) {
  context = runtime.default_context()
  cam.process_mouse_scroll(&camera, f32(yoffset))
}

init_logger :: proc() -> runtime.Logger {
  f: ^os.File
  f_err: os.Error
  if os.exists("gl_log.log") {

    f, f_err = os.open("gl_log.log", {.Append, .Write})
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


  camera = cam.create(Vec3{0.0, 0.0, 3.0})

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
  glfw.SetCursorPosCallback(window, mouse_callback)
  glfw.SetScrollCallback(window, scroll_callback)


  glfw.MakeContextCurrent(window)
  glfw.SetInputMode(window, glfw.CURSOR, glfw.CURSOR_NORMAL)

  gl.load_up_to(3, 3, glfw.gl_set_proc_address)
  gl.Enable(gl.DEPTH_TEST)

  log.info("Init glfw and OpenGL")

  light_shader := shader.load("light_vertex.glsl", "light_fragment.glsl")
  if light_shader.id == 0 {
    log.error("Cant' load light shader")
    return
  }
  defer shader.destroy(&light_shader)

  cube_shader := shader.load("cube_vertex.glsl", "cube_fragment.glsl")
  if cube_shader.id == 0 {
    log.error("Cant load cube shader")
    return
  }
  defer shader.destroy(&cube_shader)

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

      shader.set_vec3(&cube_shader, "light.position", light_pos)
      shader.set_vec3(&cube_shader, "viewPos", camera.position)

      light_color: Vec3
      light_color.x = f32(la.sin(glfw.GetTime() * 2.0))
      light_color.y = f32(la.sin(glfw.GetTime() * 0.7))
      light_color.z = f32(la.sin(glfw.GetTime() * 1.3))

      diffuse_color := light_color * Vec3(0.5)
      ambient_color := diffuse_color * Vec3(0.2)

      shader.set_vec3(&cube_shader, "light.ambient", ambient_color)
      shader.set_vec3(&cube_shader, "light.diffuse", diffuse_color)
      shader.set_vec3(&cube_shader, "light.specular", 1.0, 1.0, 1.0)

      shader.set_vec3(&cube_shader, "material.ambient", 1.0, 0.5, 0.31)
      shader.set_vec3(&cube_shader, "material.diffuse", 1.0, 0.5, 0.31)
      shader.set_vec3(&cube_shader, "material.specular", 0.5, 0.5, 0.5)
      shader.set_float(&cube_shader, "material.shininess", 32.0)


      projection := la.matrix4_perspective(la.to_radians(camera.zoom), f32(WIDTH) / f32(HEIGHT), 0.1, 100.0)
      view := cam.get_view_matrix(&camera)
      shader.set_mat4(&cube_shader, "projection", projection)
      shader.set_mat4(&cube_shader, "view", view)

      model := la.MATRIX4F32_IDENTITY
      shader.set_mat4(&cube_shader, "model", model)

      gl.BindVertexArray(cubeVAO)
      gl.DrawArrays(gl.TRIANGLES, 0, 36)


      shader.use(&light_shader)
      shader.set_mat4(&cube_shader, "projection", projection)
      shader.set_mat4(&cube_shader, "view", view)

      model *= la.matrix4_translate(light_pos)
      model *= la.matrix4_scale(Vec3(0.2))
      shader.set_mat4(&cube_shader, "model", model)

      gl.BindVertexArray(lightVAO)
      gl.DrawArrays(gl.TRIANGLES, 0, 36)


      glfw.SwapBuffers(window)
      glfw.PollEvents()
    }

    gl.DeleteVertexArrays(1, &cubeVAO)
    gl.DeleteVertexArrays(1, &lightVAO)
    gl.DeleteBuffers(1, &VBO)
}
