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
  glfw.SetInputMode(window, glfw.CURSOR, glfw.CURSOR_CAPTURED)

  glfw.MakeContextCurrent(window)
  glfw.SetCursorPosCallback(window, mouse_callback)
  glfw.SetScrollCallback(window, scroll_callback)
  glfw.SetFramebufferSizeCallback(window, framebuffer_callback)



  gl.load_up_to(3, 3, glfw.gl_set_proc_address)
  gl.Enable(gl.DEPTH_TEST)

  








  for !glfw.WindowShouldClose(window) {
    current_frame := f32(glfw.GetTime())
    delta_time = current_frame - last_frame
    last_frame = current_frame

    process_input(window)

    gl.ClearColor(0.1, 0.1, 0.1, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)



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
    camera.process_keyboard(&cam, .LEFT, delta_time)
  }
    camera.process_keyboard(&cam, .RIGHT, delta_time)
  if glfw.GetKey(window, glfw.KEY_A) == glfw.PRESS {
  }
}

