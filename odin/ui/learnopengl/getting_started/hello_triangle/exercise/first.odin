package exercise

import gl "vendor:OpenGL"
import "vendor:glfw"
import "core:log"
import "core:os"

WIDTH :: 640
HEIGHT :: 480



framebuffer_callback :: proc "c"(window: glfw.WindowHandle, width, height: i32) {
  gl.Viewport(0, 0, width, height)
}

main :: proc() {

  if !glfw.Init() {
    log.error("glfwInit error")
    return
  }


  window := glfw.CreateWindow(WIDTH, HEIGHT, "Hello Triangle", nil, nil)
  if window == nil {
    log.error("glfwCreateWindow error")
    return
  }
  glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, 3)
  glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, 3)
  glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)

  glfw.MakeContextCurrent(window)
  gl.load_up_to(3, 3, glfw.gl_set_proc_address)

  glfw.SetFramebufferSizeCallback(window, framebuffer_callback)

  vertexShader := load_shader("./vertex.glsl", gl.VERTEX_SHADER)
  fragmentShader1 := load_shader("./fragment1.glsl", gl.FRAGMENT_SHADER)
  shaderProgram1 := gl.CreateProgram()
  gl.AttachShader(shaderProgram1, vertexShader)
  gl.AttachShader(shaderProgram1, fragmentShader1)
  gl.LinkProgram(shaderProgram1)

  success: i32
  infoLog: [512]byte

  gl.GetProgramiv(shaderProgram1, gl.LINK_STATUS, &success)
  if success == 0 {
    info_log_len: i32
    gl.GetProgramiv(shaderProgram1, gl.INFO_LOG_LENGTH, &info_log_len)
    gl.GetProgramInfoLog(shaderProgram1, 512, nil, raw_data(infoLog[:]))
    log.error("Error link program1:", transmute(string)infoLog[:info_log_len])
  }

  gl.DeleteShader(fragmentShader1)

  fragmentShader2 := load_shader("./fragment2.glsl", gl.FRAGMENT_SHADER)
  shaderProgram2 := gl.CreateProgram()
  gl.AttachShader(shaderProgram2, vertexShader)
  gl.AttachShader(shaderProgram2, fragmentShader2)
  gl.LinkProgram(shaderProgram2)
  gl.GetProgramiv(shaderProgram1, gl.LINK_STATUS, &success)

  if success == 0 {
    info_log_len: i32
    gl.GetProgramiv(shaderProgram2, gl.INFO_LOG_LENGTH, &info_log_len)
    gl.GetProgramInfoLog(shaderProgram2, 512, nil, raw_data(infoLog[:]))
    log.error("Error link program2:", transmute(string)infoLog[:info_log_len])
  }

  gl.DeleteShader(vertexShader)
  gl.DeleteShader(fragmentShader2)

  vertices_1 := [?]f32 {
    -0.5, -0.5, 0.0,
    -0.5,  0.5, 0.0,
     0.5,  0.5, 0.0,
  }

  vertices_2 := [?]f32 {
    -0.5, -0.5, 0.0,
     0.5, -0.5, 0.0,
     0.5,  0.5, 0.0,
  }

  VBO1, VBO2, VAO1, VAO2: u32
  gl.GenVertexArrays(1, &VAO1)
  gl.GenVertexArrays(1, &VAO2)
  gl.GenBuffers(1, &VBO1)
  gl.GenBuffers(1, &VBO2)

  gl.BindVertexArray(VAO1)

  gl.BindBuffer(gl.ARRAY_BUFFER, VBO1)
  gl.BufferData(gl.ARRAY_BUFFER, size_of(vertices_1), &vertices_1[0], gl.STATIC_DRAW)
		
  gl.VertexAttribPointer(0, 3, gl.FLOAT, gl.FALSE, 3 * size_of(f32), uintptr(0))
  gl.EnableVertexAttribArray(0)

  gl.BindBuffer(gl.ARRAY_BUFFER, 0)
  gl.BindVertexArray(0)

  gl.BindVertexArray(VAO2)
  gl.BindBuffer(gl.ARRAY_BUFFER, VBO2)

  gl.BindBuffer(gl.ARRAY_BUFFER, VBO2)
  gl.BufferData(gl.ARRAY_BUFFER, size_of(vertices_2), &vertices_2[0], gl.STATIC_DRAW)
		
  gl.VertexAttribPointer(0, 3, gl.FLOAT, gl.FALSE, 3 * size_of(f32), uintptr(0))
  gl.EnableVertexAttribArray(0)

  for !glfw.WindowShouldClose(window) {
    gl.ClearColor(0.2, 0.3, 0.3, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT)


    gl.UseProgram(shaderProgram1)
    gl.BindVertexArray(VAO1)
    gl.DrawArrays(gl.TRIANGLES, 0, 3)

    gl.UseProgram(shaderProgram2)
    gl.BindVertexArray(VAO2)
    gl.DrawArrays(gl.TRIANGLES, 0, 3)

    process_input(window)

    glfw.SwapBuffers(window)
    glfw.PollEvents()
  }

  gl.DeleteBuffers(1, &VBO1)
  gl.DeleteBuffers(1, &VBO2)
  gl.DeleteVertexArrays(1, &VAO1)
  gl.DeleteVertexArrays(1, &VAO2)
  gl.DeleteProgram(shaderProgram1)
  gl.DeleteProgram(shaderProgram2)

  glfw.DestroyWindow(window)
  glfw.Terminate()

}

process_input :: proc(window: glfw.WindowHandle) {
  if glfw.GetKey(window, glfw.KEY_ESCAPE) == glfw.PRESS {
    glfw.SetWindowShouldClose(window, true)
  }
}


load_shader :: proc(path: string, type: u32) -> u32 {
  buf, f_er := os.read_entire_file(path, context.allocator)
  defer delete(buf)
  if f_er != nil {
    log.error("Read shader", path, "error")
    return 0
  }

  shader := gl.CreateShader(type)
  shader_source := cstring(raw_data(buf))

  gl.ShaderSource(shader, 1, &shader_source, nil)
  gl.CompileShader(shader)

  success: i32
  infoLog: [512]byte

  gl.GetShaderiv(shader, gl.COMPILE_STATUS, &success)
  if success == 0 {
    info_log_len: i32
    gl.GetShaderiv(shader, gl.INFO_LOG_LENGTH, &info_log_len)
    gl.GetShaderInfoLog(shader, 512, nil, raw_data(infoLog[:]))
    log.error("Compile shader error", transmute(string)infoLog[:info_log_len])
  }

  return shader
}
