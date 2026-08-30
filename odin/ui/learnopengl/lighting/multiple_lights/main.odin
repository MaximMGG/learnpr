package mutiple_lights

import "camera"
import "shader"
import "texture"
import "base:runtime"
import "core:log"
import "core:os"
import "core:fmt"
import la "core:math/linalg"

import "vendor:glfw"
import gl "vendor:OpenGL"

Vec3 :: la.Vector3f32
Mat4 :: la.Matrix4x4f32


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
    f, f_err = os.open("gl_log.log", {.Create, .Write, .Append})
    if f_err != nil {
      fmt.eprintln("Can't create gl_log.log")
      os.exit(1)
    } else {
      return log.create_file_logger(f)
    }
  }
}

logger_deinit :: proc() {
  log.destroy_file_logger(context.logger)
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
  if glfw.GetKey(window, glfw.KEY_A) == glfw.PRESS {
    camera.process_keyboard(&cam, .LEFT, delta_time)
  }
  if glfw.GetKey(window, glfw.KEY_D) == glfw.PRESS {
    camera.process_keyboard(&cam, .RIGHT, delta_time)
  }
}


mouse_callback :: proc "c" (window: glfw.WindowHandle, xpos_in, ypos_in: f64) {
  context = runtime.default_context()
  xpos := f32(xpos_in)
  ypos := f32(ypos_in)

  if first_mouse {
    lastX = xpos
    lastY = ypos
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

framebuffer_callback :: proc "c" (window: glfw.WindowHandle, width, height: i32) {
  gl.Viewport(0, 0, width, height)
}



WIDTH :: 1280
HEIGHT :: 720

cam: camera.Camera
first_mouse := true
lastX: f32
lastY: f32
delta_time: f32
last_frame: f32

main :: proc() {
  context.logger = logger_init()
  defer logger_deinit()

  glfw.Init()
  defer glfw.Terminate()

  window := glfw.CreateWindow(WIDTH, HEIGHT, "Multiple lights", nil, nil)
  if window == nil {
    log.error("glfwCreateWindow error")
    return
  }
  defer glfw.DestroyWindow(window)


  glfw.WindowHint(glfw.VERSION_MAJOR, 3)
  glfw.WindowHint(glfw.VERSION_MINOR, 3)
  glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)
  glfw.SetInputMode(window, glfw.CURSOR, glfw.CURSOR_NORMAL)

  glfw.MakeContextCurrent(window)
  glfw.SetFramebufferSizeCallback(window, framebuffer_callback)
  glfw.SetCursorPosCallback(window, mouse_callback)
  glfw.SetScrollCallback(window, scroll_callback)

  gl.load_up_to(3, 3,  glfw.gl_set_proc_address)

  log.info("Load GLFW and OpenGL")

  gl.Enable(gl.DEPTH_TEST)


  cube_shader, cube_shader_err := shader.load("cube_vertex.glsl", "cube_fragment.glsl")
  if cube_shader_err != nil {
    log.error("Load cube shader error")
    return
  }
  defer shader.destroy(&cube_shader)

  light_shader, light_shader_err := shader.load("light_vertex.glsl", "light_fragment.glsl")
  if light_shader_err != nil {
    log.error("Load light shader error")
    return
  }
  defer shader.destroy(&light_shader)


  log.info("Load shaders")

  diffuse_map, diffuse_map_err := texture.load("container2.png")
  if diffuse_map_err != nil {
    log.error("Load diffuse map texture error")
    return
  }
  defer texture.destroy(&diffuse_map)
  specular_map, specular_map_err := texture.load("container2_specular.png")
  if specular_map_err != nil {
    log.error("Load specular map error")
    return
  }
  defer texture.destroy(&specular_map)

  log.info("Load textures")

  vertices := [?]f32 {
    // positions          // normals           // texture coords
    -0.5, -0.5, -0.5,  0.0,  0.0, -1.0, 0.0, 0.0,
    0.5, -0.5, -0.5,  0.0,  0.0, -1.0, 1.0, 0.0,
    0.5,  0.5, -0.5,  0.0,  0.0, -1.0, 1.0, 1.0,
    0.5,  0.5, -0.5,  0.0,  0.0, -1.0, 1.0, 1.0,
    -0.5,  0.5, -0.5,  0.0,  0.0, -1.0, 0.0, 1.0,
    -0.5, -0.5, -0.5,  0.0,  0.0, -1.0, 0.0, 0.0,
    -0.5, -0.5,  0.5,  0.0,  0.0,  1.0, 0.0, 0.0,
    0.5, -0.5,  0.5,  0.0,  0.0,  1.0, 1.0, 0.0,
    0.5,  0.5,  0.5,  0.0,  0.0,  1.0, 1.0, 1.0,
    0.5,  0.5,  0.5,  0.0,  0.0,  1.0, 1.0, 1.0,
    -0.5,  0.5,  0.5,  0.0,  0.0,  1.0, 0.0, 1.0,
    -0.5, -0.5,  0.5,  0.0,  0.0,  1.0, 0.0, 0.0,
    -0.5,  0.5,  0.5, -1.0,  0.0,  0.0, 1.0, 0.0,
    -0.5,  0.5, -0.5, -1.0,  0.0,  0.0, 1.0, 1.0,
    -0.5, -0.5, -0.5, -1.0,  0.0,  0.0, 0.0, 1.0,
    -0.5, -0.5, -0.5, -1.0,  0.0,  0.0, 0.0, 1.0,
    -0.5, -0.5,  0.5, -1.0,  0.0,  0.0, 0.0, 0.0,
    -0.5,  0.5,  0.5, -1.0,  0.0,  0.0, 1.0, 0.0,
    0.5,  0.5,  0.5,  1.0,  0.0,  0.0, 1.0, 0.0,
    0.5,  0.5, -0.5,  1.0,  0.0,  0.0, 1.0, 1.0,
    0.5, -0.5, -0.5,  1.0,  0.0,  0.0, 0.0, 1.0,
    0.5, -0.5, -0.5,  1.0,  0.0,  0.0, 0.0, 1.0,
    0.5, -0.5,  0.5,  1.0,  0.0,  0.0, 0.0, 0.0,
    0.5,  0.5,  0.5,  1.0,  0.0,  0.0, 1.0, 0.0,
    -0.5, -0.5, -0.5,  0.0, -1.0,  0.0, 0.0, 1.0,
    0.5, -0.5, -0.5,  0.0, -1.0,  0.0, 1.0, 1.0,
    0.5, -0.5,  0.5,  0.0, -1.0,  0.0, 1.0, 0.0,
    0.5, -0.5,  0.5,  0.0, -1.0,  0.0, 1.0, 0.0,
    -0.5, -0.5,  0.5,  0.0, -1.0,  0.0, 0.0, 0.0,
    -0.5, -0.5, -0.5,  0.0, -1.0,  0.0, 0.0, 1.0,
    -0.5,  0.5, -0.5,  0.0,  1.0,  0.0, 0.0, 1.0,
    0.5,  0.5, -0.5,  0.0,  1.0,  0.0, 1.0, 1.0,
    0.5,  0.5,  0.5,  0.0,  1.0,  0.0, 1.0, 0.0,
    0.5,  0.5,  0.5,  0.0,  1.0,  0.0, 1.0, 0.0,
    -0.5,  0.5,  0.5,  0.0,  1.0,  0.0, 0.0, 0.0,
    -0.5,  0.5, -0.5,  0.0,  1.0,  0.0, 0.0, 1.0,
  }

  cubePositions := [?]Vec3 {
    Vec3{0.0, 0.0, 0.0},
    Vec3{2.0, 5.0, -15.0},
    Vec3{-1.5, -2.2, -2.5},
    Vec3{-3.8, -2.0, -12.3},
    Vec3{2.4, -0.4, -3.5},
    Vec3{-1.7, 3.0, -7.5},
    Vec3{1.3, -2.0, -2.5},
    Vec3{1.5, 2.0, -2.5},
    Vec3{1.5, 0.2, -1.5},
    Vec3{-1.3, 1.0, -1.5},
  }

  pointLightPositions := [?]Vec3{
    Vec3{ 0.7,  0.2,  2.0},
    Vec3{ 2.3, -3.3, -4.0},
    Vec3{-4.0,  2.0, -12.0},
    Vec3{ 0.0,  0.0, -3.0} 
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


  log.info("Bind VA and VB")


  for !glfw.WindowShouldClose(window) {
    current_frame := f32(glfw.GetTime())
    delta_time = current_frame - last_frame
    last_frame = current_frame

    gl.ClearColor(0.1, 0.1, 0.1, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)

    process_input(window)

    shader.use(&cube_shader)
    shader.set_vec3(&cube_shader, "viewPos", cam.position)
    shader.set_float(&cube_shader, "material.shininess", 32.0)


    //direction light
    shader.set_vec3(&cube_shader, "dirLight.direction", -0.2, -1.0, -0.3)
    shader.set_vec3(&cube_shader, "dirLight.ambient", 0.05, 0.05, 0.05)
    shader.set_vec3(&cube_shader, "dirLight.diffuse", 0.4, 0.4, 0.4)
    shader.set_vec3(&cube_shader, "dirLight.specular", 0.5, 0.5, 0.5)
    //point light 1
    shader.set_vec3(&cube_shader, "pointLights[0].position", pointLightPositions[0])
    shader.set_vec3(&cube_shader, "pointLights[0].ambient", 0.05, 0.05, 0.05)
    shader.set_vec3(&cube_shader, "pointLights[0].diffuse", 0.8, 0.8, 0.8)
    shader.set_vec3(&cube_shader, "pointLights[0].specular", 1.0, 1.0, 1.0)
    shader.set_float(&cube_shader, "pointLights[0].constant", 1.0)
    shader.set_float(&cube_shader, "pointLights[0].linear", 0.09)
    shader.set_float(&cube_shader, "pointLights[0].quadratic", 0.032)
    //point light 2
    shader.set_vec3(&cube_shader, "pointLights[1].position", pointLightPositions[1])
    shader.set_vec3(&cube_shader, "pointLights[1].ambient", 0.05, 0.05, 0.05)
    shader.set_vec3(&cube_shader, "pointLights[1].diffuse", 0.8, 0.8, 0.8)
    shader.set_vec3(&cube_shader, "pointLights[1].specular", 1.0, 1.0, 1.0)
    shader.set_float(&cube_shader, "pointLights[1].constant", 1.0)
    shader.set_float(&cube_shader, "pointLights[1].linear", 0.09)
    shader.set_float(&cube_shader, "pointLights[1].quadratic", 0.032)
    //point light 3
    shader.set_vec3(&cube_shader, "pointLights[2].position", pointLightPositions[2])
    shader.set_vec3(&cube_shader, "pointLights[2].ambient", 0.05, 0.05, 0.05)
    shader.set_vec3(&cube_shader, "pointLights[2].diffuse", 0.8, 0.8, 0.8)
    shader.set_vec3(&cube_shader, "pointLights[2].specular", 1.0, 1.0, 1.0)
    shader.set_float(&cube_shader, "pointLights[2].constant", 1.0)
    shader.set_float(&cube_shader, "pointLights[2].linear", 0.09)
    shader.set_float(&cube_shader, "pointLights[2].quadratic", 0.032)
    //point light 4
    shader.set_vec3(&cube_shader, "pointLights[3].position", pointLightPositions[3])
    shader.set_vec3(&cube_shader, "pointLights[3].ambient", 0.05, 0.05, 0.05)
    shader.set_vec3(&cube_shader, "pointLights[3].diffuse", 0.8, 0.8, 0.8)
    shader.set_vec3(&cube_shader, "pointLights[3].specular", 1.0, 1.0, 1.0)
    shader.set_float(&cube_shader, "pointLights[3].constant", 1.0)
    shader.set_float(&cube_shader, "pointLights[3].linear", 0.09)
    shader.set_float(&cube_shader, "pointLights[3].quadratic", 0.032)


    shader.set_vec3(&cube_shader, "spotLight.position", cam.position)
    shader.set_vec3(&cube_shader, "spotLight.direction", cam.front)
    shader.set_vec3(&cube_shader, "spotLight.ambient", 0.0, 0.0, 0.0)
    shader.set_vec3(&cube_shader, "spotLight.diffuse", 1.0, 1.0, 1.0)
    shader.set_vec3(&cube_shader, "spotLight.specular", 1.0, 1.0, 1.0)
    shader.set_float(&cube_shader, "spotLight.constant", 1.0)
    shader.set_float(&cube_shader, "spotLight.linear", 0.09)
    shader.set_float(&cube_shader, "spotLight.quadratic", 0.032)
    shader.set_float(&cube_shader, "spotLight.cutOff", f32(la.cos(la.to_radians(12.5))))
    shader.set_float(&cube_shader, "spotLight.outerCutOff", f32(la.cos(la.to_radians(15.0))))


    projection := la.matrix4_perspective(f32(la.to_radians(cam.zoom)), f32(WIDTH) / f32(HEIGHT), 0.1, 100.0)
    view := camera.get_view_matrix(&cam)
    shader.set_mat4(&cube_shader, "projection", projection)
    shader.set_mat4(&cube_shader, "view", view)


    gl.ActiveTexture(gl.TEXTURE0)
    gl.BindTexture(gl.TEXTURE_2D, diffuse_map.id)
    gl.ActiveTexture(gl.TEXTURE1)
    gl.BindTexture(gl.TEXTURE_2D, specular_map.id)


    gl.BindVertexArray(cubeVAO)

    for i in 0..<len(cubePositions) {
      model := la.MATRIX4F32_IDENTITY
      model *= la.matrix4_translate(cubePositions[i])
      angle := f32(20.0) * f32(i)
      model *= la.matrix4_rotate(la.to_radians(angle), Vec3{1.0, 0.3, 0.5})

      shader.set_mat4(&cube_shader, "model", model)

      gl.DrawArrays(gl.TRIANGLES, 0, 36)
    }

    shader.use(&light_shader)
    shader.set_mat4(&light_shader, "projection", projection)
    shader.set_mat4(&light_shader, "view", view)


    gl.BindVertexArray(lightVAO)
    for i in 0..<len(pointLightPositions) {
      model := la.MATRIX4F32_IDENTITY
      model *= la.matrix4_translate(pointLightPositions[i])
      model *= la.matrix4_scale(Vec3(0.2))
      shader.set_mat4(&light_shader, "model", model)

      gl.DrawArrays(gl.TRIANGLES, 0, 36)
    }

    glfw.SwapBuffers(window)
    glfw.PollEvents()
  }


  gl.DeleteVertexArrays(1, &cubeVAO)
  gl.DeleteVertexArrays(1, &lightVAO)
  gl.DeleteBuffers(1, &VBO)

  log.info("terminate")


}
