package color
 
import "core:log"
import gl "vendor:OpenGL"
import "vendor:glfw"
import "core:math/linalg"
import "base:runtime"
import "core:os"
import "core:fmt"
import "shader"


WIDTH :: 1280
HEIGHT :: 720


init_logger :: proc() -> runtime.Logger {
  f: ^os.File
  f_err: os.Error

  if os.exists("gl_log.log") {
    f, f_err = os.open("gl_log.log", {.Append})
    if f_err != nil {
      fmt.eprintln("Can't open file gl_log.log") 
      os.exit(1)
    }
    return log.create_file_logger(f)
  }

  f, f_err = os.open("gl_log.log", {.Create, .Write, .Append})
  if f_err != nil {
      fmt.eprintln("Can't create file gl_log.log") 
      os.exit(1)
  }
  return log.create_file_logger(f)
}

deinit_logger :: proc() {
  log.destroy_file_logger(context.logger)
}



main :: proc() {
  context.logger = init_logger()
  defer deinit_logger()

  glfw.Init()
  defer glfw.Terminate()

  window := glfw.CreateWindow(WIDTH, HEIGHT, "Color", nil, nil)
  defer glfw.DestroyWindow(window)

  glfw.WindowHint(glfw.VERSION_MAJOR, 3)
  glfw.WindowHint(glfw.VERSION_MINOR, 3)
  glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)

  glfw.MakeContextCurrent(window)

  gl.load_up_to(3, 3, glfw.gl_set_proc_address)
  gl.Enable(gl.DEPTH_TEST)


  vertices := [?]f32{
    -0.5, -0.5, -0.5, 
     0.5, -0.5, -0.5,   
     0.5,  0.5, -0.5,  
     0.5,  0.5, -0.5,  
    -0.5,  0.5, -0.5, 
    -0.5, -0.5, -0.5, 

    -0.5, -0.5,  0.5, 
     0.5, -0.5,  0.5,  
     0.5,  0.5,  0.5,  
     0.5,  0.5,  0.5,  
    -0.5,  0.5,  0.5, 
    -0.5, -0.5,  0.5, 

    -0.5,  0.5,  0.5, 
    -0.5,  0.5, -0.5, 
    -0.5, -0.5, -0.5, 
    -0.5, -0.5, -0.5, 
    -0.5, -0.5,  0.5, 
    -0.5,  0.5,  0.5, 

     0.5,  0.5,  0.5,  
     0.5,  0.5, -0.5,  
     0.5, -0.5, -0.5,  
     0.5, -0.5, -0.5,  
     0.5, -0.5,  0.5,  
     0.5,  0.5,  0.5,  

    -0.5, -0.5, -0.5, 
     0.5, -0.5, -0.5,  
     0.5, -0.5,  0.5,  
     0.5, -0.5,  0.5,  
    -0.5, -0.5,  0.5, 
    -0.5, -0.5, -0.5, 

    -0.5,  0.5, -0.5, 
     0.5,  0.5, -0.5,  
     0.5,  0.5,  0.5,  
     0.5,  0.5,  0.5,  
    -0.5,  0.5,  0.5, 
    -0.5,  0.5, -0.5,
  }


  for !glfw.WindowShouldClose(window) {
    gl.ClearColor(0.1, 0.1, 0.1, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)



    glfw.SwapBuffers(window)
    glfw.PollEvents()
  }

}
