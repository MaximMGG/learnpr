package transformation

import "core:fmt"
import "core:c"
import math "core:math/linalg"

import "vendor:glfw"
import gl "vendor:OpenGL"
import stb "vendor:stb/image"


import "shader"

WIDTH :: 600
HEIGHT :: 400

main :: proc() {
  fmt.println("Init glfw")

  glfw.Init()

  window := glfw.CreateWindow(WIDTH, HEIGHT, "Hey", nil, nil)
  if window == nil {
    fmt.eprintln("glfw.CreateWindow error")
    return
  }

  glfw.MakeContextCurrent(window)
  gl.load_up_to(3, 3, proc(p: rawptr, name: cstring) {
    (^rawptr)(p)^ = glfw.GetProcAddress(name)
  })

  program, program_ok := shader.createShader("./vertex.glsl", "./fragment.glsl")
  if program_ok != nil {
    fmt.eprintln("Error while createShader")
    glfw.Terminate()
    return
  }

  vertices := [?]f32 {
     0.5,  0.5, 0.0,   1.0, 1.0,
     0.5, -0.5, 0.0,   1.0, 0.0,
    -0.5, -0.5, 0.0,   0.0, 0.0,
    -0.5,  0.5, 0.0,   0.0, 1.0 
  }

  indices := [?]u32 {
    0, 1, 3, 1, 2, 3
  }

  VBO, VAO, EBO: u32

  gl.GenVertexArrays(1, &VAO)
  gl.GenBuffers(1, &VBO)
  gl.GenBuffers(1, &EBO)

  gl.BindVertexArray(VAO)
  gl.BindBuffer(gl.ARRAY_BUFFER, VBO)
  gl.BufferData(gl.ARRAY_BUFFER, size_of(vertices), &vertices[0], gl.STATIC_DRAW)

  gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, EBO)
  gl.BufferData(gl.ELEMENT_ARRAY_BUFFER, size_of(indices), &indices[0], gl.STATIC_DRAW)

  gl.VertexAttribPointer(0, 3, gl.FLOAT, gl.FALSE, 5 * size_of(f32), uintptr(0))
  gl.EnableVertexAttribArray(0)

  gl.VertexAttribPointer(1, 2, gl.FLOAT, gl.FALSE, 5 * size_of(f32), uintptr(size_of(f32) * 3))
  gl.EnableVertexAttribArray(1)

  texture: u32
  gl.GenTextures(1, &texture)
  gl.BindTexture(gl.TEXTURE_2D, texture)

  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.REPEAT)
  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.REPEAT)

  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR)
  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR)

  width, height, nrChannels: c.int
  stb.set_flip_vertically_on_load(c.int(1))
  data := stb.load("./crate.png", &width, &height, &nrChannels, 0)
  defer stb.image_free(data)
  if data != nil {
    format: i32 = nrChannels == 4 ? gl.RGBA : gl.RGB
    gl.TexImage2D(gl.TEXTURE_2D, 0, format, width, height, 0, u32(format), gl.UNSIGNED_BYTE, data)
    gl.GenerateMipmap(gl.TEXTURE_2D)
  }

  shader.use(program)
  shader.setInt(program, "texture1", 0)

  for !bool(glfw.WindowShouldClose(window)) {
    processInput(window)

    gl.ClearColor(0.2, 0.3, 0.3, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT)

    gl.ActiveTexture(gl.TEXTURE0)
    gl.BindTexture(gl.TEXTURE_2D, texture)

    transform := math.MATRIX4F32_IDENTITY

    transform *= math.matrix4_translate(math.Vector3f32{0.5, -0.5, 0.0})
    transform *= math.matrix4_rotate(math.to_radians(f32(glfw.GetTime())), math.Vector3f32{0.0, 0.0, 1.0})

    shader.use(program)
    transformLoc := gl.GetUniformLocation(program, "transform")
    if transformLoc < 0 {
      fmt.println("Cant find transform matrix in shader")
      glfw.Terminate()
      return
    }
    gl.UniformMatrix4fv(transformLoc, 1, gl.FALSE, ([^]f32)(&transform[0][0]))

    gl.BindVertexArray(VAO)
    gl.DrawElements(gl.TRIANGLES, 6, gl.UNSIGNED_INT, nil)

    glfw.SwapBuffers(window)
    glfw.PollEvents()
  }



  gl.DeleteBuffers(1, &VBO)
  gl.DeleteBuffers(1, &EBO)
  gl.DeleteVertexArrays(1, &VAO)
  gl.DeleteTextures(1, &texture)
  glfw.DestroyWindow(window)
  glfw.Terminate()
}

processInput :: proc(window: glfw.WindowHandle) {
  if glfw.GetKey(window, glfw.KEY_ESCAPE) == glfw.PRESS { 
    glfw.SetWindowShouldClose(window, b32(1))
  }
}

