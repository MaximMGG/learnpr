package camera


import "core:log"
import "core:os"
import "base:runtime"
import gl "vendor:OpenGL"
import "vendor:glfw"
import "shader"
import "texture"
import cam "camerapos"
import la "core:math/linalg"
import "core:c/libc"

WIDTH :: 1280
HEIGHT :: 720


framebuffer_callback :: proc "c" (window: glfw.WindowHandle, width, height: i32) {
  gl.Viewport(0, 0, width, height)
}


init_logger :: proc() -> runtime.Logger {

  f: ^os.File
  f_err: os.Error

  if os.exists("gl_log.log") {
    f, f_err = os.open("gl_log.log", {.Append, .Write})
  } else {
    f, f_err = os.open("gl_log.log", {.Create, .Write, .Append})
  }
    return log.create_file_logger(f)
}

deinit_logger :: proc() {
  log.destroy_file_logger(context.logger)    
}

first_mouse: bool = true
lastX: f64 = f64(WIDTH) / 2.0
lastY: f64 = f64(HEIGHT) / 2.0
delta_time: f32 = 0.0
last_frame: f32 = 0.0
camera: cam.Camera


scroll_callback :: proc "c" (window: glfw.WindowHandle, xoffset, yoffset: f64) {
  context = runtime.default_context()
  cam.process_mouse_scroll(&camera, f32(yoffset))
}

mouse_callback :: proc "c" (window: glfw.WindowHandle, xpos, ypos: f64) {
  libc.fprintf(libc.stderr, "X: %lf, Y: %lf\n", xpos, ypos)
  context = runtime.default_context()
  if first_mouse {
    lastX = xpos
    lastY = ypos
  }

  xoffset := f32(xpos - lastX)
  yoffset := f32(lastY - ypos)

  lastX = xpos
  lastY = ypos

  cam.process_mouse_movement(&camera, xoffset, yoffset)
}

main :: proc() {
  context.logger = init_logger()
  defer deinit_logger()

  if !glfw.Init() {
    log.error("glfwInit error")
    return
  }

  camera = cam.create_camera(la.Vector3f32{0.0, 0.0, 3.0})

  log.info("initGlfw")

  window := glfw.CreateWindow(WIDTH, HEIGHT, "Camera window", nil, nil)
  glfw.WindowHint(glfw.VERSION_MAJOR, 3)
  glfw.WindowHint(glfw.VERSION_MINOR, 3)
  glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)
  glfw.MakeContextCurrent(window)

  glfw.SetFramebufferSizeCallback(window, framebuffer_callback)
  glfw.SetCursorPosCallback(window, mouse_callback)
  glfw.SetScrollCallback(window, scroll_callback)
  glfw.SetInputMode(window, glfw.CURSOR, glfw.CURSOR_NORMAL)

  gl.load_up_to(3, 3, glfw.gl_set_proc_address)
  gl.Enable(gl.DEPTH_TEST)

  log.info("setup window and load OpenGL library")

  prog, prog_err := shader.load_program("vertex.glsl", "fragment.glsl")
  defer gl.DeleteProgram(prog)
  if prog_err != nil {
    log.error("Load shader program error")
  }

  tex1, tex1_err := texture.load_jpg("container.jpg")
  if tex1_err != nil {
    log.error("load jpg texture failed")
    glfw.Terminate()
  }
  defer gl.DeleteTextures(1, &tex1)
  tex2, tex2_err := texture.load_png("awesomeface.png")
  if tex2_err != nil {
    log.error("load png texture failed")
    glfw.Terminate()
  }
  defer gl.DeleteTextures(1, &tex2)

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


  cube_positions := [?]la.Vector3f32 {
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
  gl.impl_EnableVertexAttribArray(0)
  gl.VertexAttribPointer(1, 2, gl.FLOAT, gl.FALSE, 5 * size_of(f32), uintptr(3 * size_of(f32)))
  gl.impl_EnableVertexAttribArray(1)

  //gl.BindBuffer(gl.ARRAY_BUFFER, 0)

  gl.UseProgram(prog)
  shader.set_uniform1i(prog, "texture1", 0)
  shader.set_uniform1i(prog, "texture2", 1)

  log.info("Bind vertices and textures")

  for !glfw.WindowShouldClose(window) {
    current_frame := f32(glfw.GetTime())
    delta_time = current_frame - last_frame
    last_frame = current_frame

    process_input(window)
    gl.ClearColor(0.2, 0.3, 0.3, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)

    gl.ActiveTexture(gl.TEXTURE0)
    gl.BindTexture(gl.TEXTURE_2D, tex1)
    gl.ActiveTexture(gl.TEXTURE1)
    gl.BindTexture(gl.TEXTURE_2D, tex2)

    projection := la.MATRIX4F32_IDENTITY
    projection *= la.matrix4_perspective_f32(la.to_radians(camera.zoom), f32(WIDTH) / f32(HEIGHT), 0.1, 100.0)
    shader.set_unfiromMat4(prog, "projection", projection)

    view := la.MATRIX4F32_IDENTITY
    radius: f32 = 10.0
    camx := la.sin(f32(glfw.GetTime())) * radius
    camz := la.cos(f32(glfw.GetTime())) * radius
    view *= cam.get_view_matrix(&camera)
    shader.set_unfiromMat4(prog, "view", view)


    gl.BindVertexArray(VAO)
    for i in 0..< len(cube_positions) {
      model := la.MATRIX4F32_IDENTITY
      model *= la.matrix4_translate_f32(cube_positions[i])
      model *= la.matrix4_rotate_f32(f32(glfw.GetTime()) * 0.125 * f32(i), la.Vector3f32{1.0, 0.3, 0.5})
      shader.set_unfiromMat4(prog, "model", model)
      gl.DrawArrays(gl.TRIANGLES, 0, 36)
    }

    glfw.SwapBuffers(window)
    glfw.PollEvents()
  }
  log.info("Shutdown")
}


process_input :: proc(window: glfw.WindowHandle) {
  if (glfw.GetKey(window, glfw.KEY_ESCAPE) == glfw.PRESS) {
    glfw.SetWindowShouldClose(window, true)
  }

  if glfw.GetKey(window, glfw.KEY_W) == glfw.PRESS {
    cam.process_keyboard(&camera, .FORWARD, f64(delta_time))
  }
  if glfw.GetKey(window, glfw.KEY_S) == glfw.PRESS {
    cam.process_keyboard(&camera, .BACKWARD, f64(delta_time))
  }
  if glfw.GetKey(window, glfw.KEY_A) == glfw.PRESS {
    cam.process_keyboard(&camera, .LEFT, f64(delta_time))
  }
  if glfw.GetKey(window, glfw.KEY_D) == glfw.PRESS {
    cam.process_keyboard(&camera, .RIGHT, f64(delta_time))
  }
}

