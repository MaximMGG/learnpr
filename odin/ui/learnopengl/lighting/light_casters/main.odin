package light_castres


import "base:runtime"
import "core:log"
import "core:os"
import "core:fmt"
import la "core:math/linalg"

import "vendor:glfw"
import gl "vendor:OpenGL"

import "shader"
import "camera"
import "texture"



logger_init :: proc() -> runtime.Logger {
  f: ^os.File
  f_err: os.Error

  if os.exists("gl_log.log") {
    f, f_err = os.open("gl_log.log", {.Write, .Append})
    if f_err != nil {
      fmt.eprintln("Can't open gl_log.log")
      os.exit(1)
    } else {
      return log.create_file_logger(f)
    }
  } else {
    f, f_err = os.open("lg_log.log", {.Create, .Write, .Append})
    if f_err != nil {
      fmt.eprintln("Can't open gl_log.log")
      os.exit(1)
    } else {
      return log.create_file_logger(f)
    }
  }
}

logger_deinit :: proc() {
  log.destroy_file_logger(context.logger)
}


Vec3 :: la.Vector3f32
Mat4 :: la.Matrix4x4f32



WIDTH :: 1280
HEIGHT :: 720
cam: camera.Camera
lastX: f32
lastY: f32

delta_time: f32
last_frame: f32
first_mouse := true



main :: proc() {
  context.logger = logger_init()
  defer logger_deinit()


  glfw.Init()
  defer glfw.Terminate()
  cam = camera.create(Vec3{0.0, 0.0, 3.0})

  window := glfw.CreateWindow(WIDTH, HEIGHT, "Light casters", nil, nil)
  if window == nil {
    log.error("glfwCreateWindow error")
    return
  }
  defer glfw.DestroyWindow(window)


  glfw.WindowHint(glfw.VERSION_MAJOR, 3)
  glfw.WindowHint(glfw.VERSION_MINOR, 3)
  glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)
  glfw.SetInputMode(window, glfw.CURSOR, glfw.CURSOR_DISABLED)

  glfw.MakeContextCurrent(window)
  glfw.SetCursorPosCallback(window, mouse_callback)
  glfw.SetScrollCallback(window, scroll_callback)
  glfw.SetFramebufferSizeCallback(window, framebuffer_callback)

  gl.load_up_to(3, 3, glfw.gl_set_proc_address)
  gl.Enable(gl.DEPTH_TEST)

  cube_shader, cube_shader_err := shader.load("cube_vertex.glsl", "cube_fragment.glsl")
  if cube_shader_err != nil {
    log.error("Failed to load cube shaders")
    return
  }
  defer shader.destroy(&cube_shader)

  light_shader, light_shader_err := shader.load("light_vertex.glsl", "light_fragment.glsl")
  if light_shader_err != nil {
    log.error("Failed to load light shaders")
    return
  }
  defer shader.destroy(&light_shader)


  diffuse_map, diffuse_map_err := texture.load("container2.png")
  if diffuse_map_err != nil {
    log.error("Load texture container2 error")
    return
  }
  defer texture.destroy(&diffuse_map)

  specular_map, specular_map_err := texture.load("container2_specular.png")
  if specular_map_err != nil {
    log.error("Load texture container2_specular error")
    return
  }
  defer texture.destroy(&specular_map)


  vertices := [?]f32 {
    // positions          // normals           // texture coords
    -0.5, -0.5, -0.5,  0.0,  0.0, -1.0,  0.0,  0.0,
    0.5, -0.5, -0.5,  0.0,  0.0, -1.0,  1.0,  0.0,
    0.5,  0.5, -0.5,  0.0,  0.0, -1.0,  1.0,  1.0,
    0.5,  0.5, -0.5,  0.0,  0.0, -1.0,  1.0,  1.0,
    -0.5,  0.5, -0.5,  0.0,  0.0, -1.0,  0.0,  1.0,
    -0.5, -0.5, -0.5,  0.0,  0.0, -1.0,  0.0,  0.0,

    -0.5, -0.5,  0.5,  0.0,  0.0,  1.0,  0.0,  0.0,
    0.5, -0.5,  0.5,  0.0,  0.0,  1.0,  1.0,  0.0,
    0.5,  0.5,  0.5,  0.0,  0.0,  1.0,  1.0,  1.0,
    0.5,  0.5,  0.5,  0.0,  0.0,  1.0,  1.0,  1.0,
    -0.5,  0.5,  0.5,  0.0,  0.0,  1.0,  0.0,  1.0,
    -0.5, -0.5,  0.5,  0.0,  0.0,  1.0,  0.0,  0.0,

    -0.5,  0.5,  0.5, -1.0,  0.0,  0.0,  1.0,  0.0,
    -0.5,  0.5, -0.5, -1.0,  0.0,  0.0,  1.0,  1.0,
    -0.5, -0.5, -0.5, -1.0,  0.0,  0.0,  0.0,  1.0,
    -0.5, -0.5, -0.5, -1.0,  0.0,  0.0,  0.0,  1.0,
    -0.5, -0.5,  0.5, -1.0,  0.0,  0.0,  0.0,  0.0,
    -0.5,  0.5,  0.5, -1.0,  0.0,  0.0,  1.0,  0.0,

    0.5,  0.5,  0.5,  1.0,  0.0,  0.0,  1.0,  0.0,
    0.5,  0.5, -0.5,  1.0,  0.0,  0.0,  1.0,  1.0,
    0.5, -0.5, -0.5,  1.0,  0.0,  0.0,  0.0,  1.0,
    0.5, -0.5, -0.5,  1.0,  0.0,  0.0,  0.0,  1.0,
    0.5, -0.5,  0.5,  1.0,  0.0,  0.0,  0.0,  0.0,
    0.5,  0.5,  0.5,  1.0,  0.0,  0.0,  1.0,  0.0,

    -0.5, -0.5, -0.5,  0.0, -1.0,  0.0,  0.0,  1.0,
    0.5, -0.5, -0.5,  0.0, -1.0,  0.0,  1.0,  1.0,
    0.5, -0.5,  0.5,  0.0, -1.0,  0.0,  1.0,  0.0,
    0.5, -0.5,  0.5,  0.0, -1.0,  0.0,  1.0,  0.0,
    -0.5, -0.5,  0.5,  0.0, -1.0,  0.0,  0.0,  0.0,
    -0.5, -0.5, -0.5,  0.0, -1.0,  0.0,  0.0,  1.0,

    -0.5,  0.5, -0.5,  0.0,  1.0,  0.0,  0.0,  1.0,
    0.5,  0.5, -0.5,  0.0,  1.0,  0.0,  1.0,  1.0,
    0.5,  0.5,  0.5,  0.0,  1.0,  0.0,  1.0,  0.0,
    0.5,  0.5,  0.5,  0.0,  1.0,  0.0,  1.0,  0.0,
    -0.5,  0.5,  0.5,  0.0,  1.0,  0.0,  0.0,  0.0,
    -0.5,  0.5, -0.5,  0.0,  1.0,  0.0,  0.0,  1.0
  }

  cubePositions := [?]Vec3{
    Vec3{ 0.0,  0.0,  0.0},
    Vec3{ 2.0,  5.0, -15.0},
    Vec3{-1.5, -2.2, -2.5},
    Vec3{-3.8, -2.0, -12.3},
    Vec3{ 2.4, -0.4, -3.5},
    Vec3{-1.7,  3.0, -7.5},
    Vec3{ 1.3, -2.0, -2.5},
    Vec3{ 1.5,  2.0, -2.5},
    Vec3{ 1.5,  0.2, -1.5},
    Vec3{-1.3,  1.0, -1.5}
  }

  cubeVAO, lightVAO, VBO: u32

  gl.GenVertexArrays(1, &cubeVAO)
  gl.GenVertexArrays(1, &lightVAO)
  gl.GenBuffers(1, &VBO)

  gl.BindVertexArray(cubeVAO)
  gl.BindBuffer(gl.ARRAY_BUFFER, VBO)
  gl.BufferData(gl.ARRAY_BUFFER, size_of(vertices), &vertices[0], gl.STATIC_DRAW)

  gl.VertexAttribPointer(0, 3, gl.FLOAT, gl.FALSE, 8 * size_of(f32), uintptr(0))
  gl.EnableVertexAttribArray(0)
  gl.VertexAttribPointer(1, 3, gl.FLOAT, gl.FALSE, 8 * size_of(f32), uintptr(3 * size_of(f32)))
  gl.EnableVertexAttribArray(1)
  gl.VertexAttribPointer(2, 2, gl.FLOAT, gl.FALSE, 8 * size_of(f32), uintptr(6 * size_of(f32)))
  gl.EnableVertexAttribArray(2)

  gl.BindVertexArray(lightVAO)
  gl.BindBuffer(gl.ARRAY_BUFFER, VBO)

  gl.VertexAttribPointer(0, 3, gl.FLOAT, gl.FALSE, 8 * size_of(f32), uintptr(0))
  gl.EnableVertexAttribArray(0)


  shader.use(&cube_shader)
  shader.set_int(&cube_shader, "material.diffuse", 0)
  shader.set_int(&cube_shader, "material.specular", 1)
  shader.set_float(&cube_shader, "material.shininess", 32.0)


  for !glfw.WindowShouldClose(window) {
    current_frame := f32(glfw.GetTime())
    delta_time = current_frame - last_frame
    last_frame = current_frame

    process_input(window)

    gl.ClearColor(0.1, 0.1, 0.1, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)

    shader.use(&cube_shader)
    shader.set_vec3(&cube_shader, "light.direction", cam.front)
    shader.set_vec3(&cube_shader, "light.position", cam.position)
    shader.set_float(&cube_shader, "light.cutOff", f32(la.cos(la.to_radians(12.5))))
    shader.set_float(&cube_shader, "light.outerCutOff", f32(la.cos(la.to_radians(17.5))))
    shader.set_vec3(&cube_shader, "viewPos", cam.position)

    shader.set_vec3(&cube_shader, "light.ambient", 0.1, 0.1, 0.1)
    shader.set_vec3(&cube_shader, "light.diffuse", 0.8, 0.8, 0.8)
    shader.set_vec3(&cube_shader, "light.specular", 1.0, 1.0, 1.0)
    shader.set_float(&cube_shader, "light.constant", 1.0)
    shader.set_float(&cube_shader, "light.linear", 0.09)
    shader.set_float(&cube_shader, "light.quadratic", 0.032)

    projection := la.matrix4_perspective(la.to_radians(cam.zoom), f32(WIDTH) / f32(HEIGHT), 0.1, 100.0)
    view := camera.get_view_matrix(&cam)
    model := la.MATRIX4F32_IDENTITY

    shader.set_mat4(&cube_shader, "projection", projection)
    shader.set_mat4(&cube_shader, "view", view)
    shader.set_mat4(&cube_shader, "model", model)


    gl.ActiveTexture(gl.TEXTURE0)
    gl.BindTexture(gl.TEXTURE_2D, diffuse_map.id)
    gl.ActiveTexture(gl.TEXTURE1)
    gl.BindTexture(gl.TEXTURE_2D, specular_map.id)

    gl.BindVertexArray(cubeVAO)
    for i in 0..<len(cubePositions) {
      model = la.MATRIX4F32_IDENTITY
      model *= la.matrix4_translate(cubePositions[i])
      angle := f32(glfw.GetTime()) * f32(i)
      model *= la.matrix4_rotate(la.to_radians(la.sin(angle)), Vec3{1.0, 0.3, 0.5})
      shader.set_mat4(&cube_shader, "model", model)

      gl.DrawArrays(gl.TRIANGLES, 0, 36)

    }


    glfw.SwapBuffers(window)
    glfw.PollEvents()
  }
}

framebuffer_callback :: proc "c" (window: glfw.WindowHandle, width, height: i32) {
  gl.Viewport(0, 0, width, height)
}

mouse_callback :: proc "c" (window: glfw.WindowHandle, xpos_in, ypos_in: f64) {
  context = runtime.default_context()
  xpos := f32(xpos_in) * cam.mouse_sensitivity
  ypos := f32(ypos_in) * cam.mouse_sensitivity

  if first_mouse {
    lastX = xpos
    lastY = ypos
    first_mouse = false
  }

  xoffset := xpos - lastX
  yoffset := lastY - ypos

  lastX = xpos
  lastY = ypos

  camera.process_mouse_movement(&cam, xoffset, yoffset)
}

scroll_callback :: proc "c" (window: glfw.WindowHandle, xoffset, yoffset: f64) {
  context = runtime.default_context()
  camera.process_mouse_scroll(&cam, f32(yoffset))
}


process_input :: proc(window: glfw.WindowHandle) {
  if glfw.GetKey(window, glfw.KEY_ESCAPE) == glfw.PRESS {
    glfw.SetWindowShouldClose(window, true)
  }

  if glfw.GetKey(window, glfw.KEY_W) == glfw.PRESS {
    camera.process_keyboard(&cam, .FORWARD, delta_time)
  }
  if glfw.GetKey(window, glfw.KEY_S) == glfw.PRESS {
    camera.process_keyboard(&cam, .BACKWARD, delta_time)
  }
  if glfw.GetKey(window, glfw.KEY_D) == glfw.PRESS {
    camera.process_keyboard(&cam, .RIGHT, delta_time)
  }
  if glfw.GetKey(window, glfw.KEY_A) == glfw.PRESS {
    camera.process_keyboard(&cam, .LEFT, delta_time)
  }
}

