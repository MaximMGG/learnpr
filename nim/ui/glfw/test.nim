import glfw, std/os
import openGL
import std/strutils
import std/sequtils


proc compileShader(path: string, s_type: uint32): uint32 = 
    var file = readFile(path)
    var shader = glCreateShader(cast[GLenum](s_type))
    var cbuf: cstringArray = cast[cstringArray](addr file)
    shader.glShaderSource(1, cbuf, nil)
    glCompileShader(shader)
    return shader

proc loadShader(v_path: string, f_path: string): uint32 =
    var v_shader: uint32 = compileShader(v_path, cast[uint32](GL_VERTEX_SHADER))
    var f_shader: uint32 = compileShader(f_path, cast[uint32](GL_FRAGMENT_SHADER))
    var prog: uint32 = glCreateProgram()
    glAttachShader(prog, v_shader)
    glAttachShader(prog, f_shader)
    glLinkProgram(prog)
    return prog


proc main() =
  glfw.initialize()
  var config = DefaultOpenglWindowConfig
  config.title = "Minimal Nim_GLFW example"

  var window = newWindow(config)

  glfw.makeContextCurrent(window)
  openGL.loadExtensions()

  var prog: uint32 = loadShader("./vertex.glsl", "./fragment.glsl")
  var vertices = @[
    0.5, 0.5,
    0.5, -0.5,
    -0.5, -0.5,
    -0.5, 0.5
  ]
  var indeces = @[0, 1, 2, 2, 3, 0]

  var VAO, VBO, EBO: uint32

  glGenVertexArrays(1, addr VAO)
  glBindVertexArray(VAO)
  glGenBuffers(1, addr VBO)
  glBindBuffer(GL_ARRAY_BUFFER, VBO)
  glBufferData(GL_ARRAY_BUFFER, vertices.len * sizeof(float32), addr vertices[0], GL_STATIC_DRAW)

  glGenBuffers(1, addr EBO)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO)
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, indeces.len * sizeof(uint32), addr indeces[0], GL_STATIC_DRAW)

  glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, )
  glEnableVertexAttribArray(0)

  
  while not window.shouldClose():
    glClear(GL_COLOR_BUFFER_BIT)

    glBindVertexArray(VAO);
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, nil)

    window.swapBuffers()
    glfw.pollEvents()
    
  
  window.destroy()
  glfw.terminate()


main()
  
  

