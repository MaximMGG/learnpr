import nimgl/[glfw, opengl]
import std/syncio

proc compileShader(path: string, shader_type: GLenum): uint32 =
  var f: File
  try:
    f = open(path, fmRead, 4096)
  finally:
    close(f)
  let shader_source = f.readAll()

  var shader = glCreateShader(shader_type)
  var c = cstring(shader_source)
  glShaderSource(shader, 1, addr c, nil)
  glCompileShader(shader)

  var status: int32
  glGetShaderiv(shader, GL_COMPILE_STATUS, addr status)
  if status == cast[int32](GL_FALSE):
    var buf: array[512, char]
    glGetShaderInfoLog(shader, 512, nil, cast[cstring](addr buf[0]))
    echo $buf
    return 0
  result = cast[uint32](shader)
    


proc keyProc(w: GLFWWindow, key: int32, scancode: int32, action: int32,
             mods: int32): void {.cdecl.} =
    if key == GLFWKey.ESCAPE and action == GLFWPress:
      w.setWindowShouldClose(true)


proc main =
  assert glfwInit()

  glfwWindowHint(GLFWContextVersionMajor, 3)
  glfwWindowHint(GLFWContextVersionMinor, 3)
  #glfwWindowHint(GLFWOpenglForwardCompat, GLFW_TRUE)
  glfwWindowHint(GLFWOpenglProfile, GLFW_OPENGL_CORE_PROFILE)
  #glfwWindowHint(GLFWResizable, GLFW_FALSE)

  
  let w: GLFWWindow = glfwCreateWindow(800, 600, "HEllo")
  if w == nil:
    quit(1)

  discard w.setKeyCallback(keyProc)
  w.makeContextCurrent()

  assert glInit()

  let v_s = compileShader("vertex.glsl", GL_VERTEX_SHADER)
  if v_s == 0:
    return

  let f_s = compileShader("fragment.glsl", GL_FRAGMENT_SHADER)
  if f_s == 0:
    return

  let prog = glCreateProgram()
  glAttachShader(prog, v_s)
  glAttachShader(prog, f_s)
  glLinkProgram(prog)

  let vertices = [
    -0.5f, 0.5f, 0.0f,
     0.5f, 0.5f, 0.0f,
     0.5, -0.5f, 0.0f,
     -0.5f, 0.5f, 0.0f,
    -0.5f, -0.5f, 0.0f,
    0.5f, -0.5f, 0.0f]

  var
    VAO: uint32
    VBO: uint32

  glGenVertexArrays(1, addr VAO)
  glGenBuffers(1, addr VBO)

  glBindVertexArray(VAO)
  glBindBuffer(GL_ARRAY_BUFFER, VBO)
  #glBufferData(GL_ARRAY_BUFFER, GL_FLOAT, GL_FALSE, sizeof(vertices), addr vertices[0], GL_STATIC_DRAW)

  glVertexAttribPointer()
  
  while not w.windowShouldClose:
    glClearColor(0.2, 0.3, 0.3, 1.0)
    glClear(GL_COLOR_BUFFER_BIT)

    w.swapBuffers()
    glfwPollEvents()


  w.destroyWindow()
  glfwTerminate()
main()
