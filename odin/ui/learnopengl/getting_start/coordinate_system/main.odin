package coordinate_system

import "core:fmt"
import "core:os"
import math "core:math/linalg"

import "vendor:glfw"
import gl "vendor:OpenGL"
import "vendor:stb/image"

import "shader"
import "texture"

WIDTH :: 800
HEIGHT :: 600

main :: proc() {
  glfw.Init()
  window := glfw.CreateWindow(WIDTH, HEIGHT, "Test scrin", nil, nil)
  if window == nil {
    fmt.eprintln("glfw.CreateWindow error")
    return
  }

  glfw.MakeContextCurrent(window)
  gl.load_up_to(3, 3, proc(p: rawptr, name: cstring) {
    (^rawptr)(p)^ = glfw.GetProcAddress(name)
  })

  gl.Enable(gl.DEPTH_TEST)

  program, program_ok := shader.createShader("./vertex.glsl", "./fragment.glsl")
  if !program_ok {
    fmt.eprintln("CreateShader error")
    glfw.DestroyWindow(window)
    glfw.Terminate()
    return
  }
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

  cubePositions := [?]math.Vector3f32{
    math.Vector3f32{ 0.0,  0.0,  0.0},
    math.Vector3f32{ 2.0,  5.0, -15.0},
    math.Vector3f32{-1.5, -2.2, -2.5},
    math.Vector3f32{-3.8, -2.0, -12.3},
    math.Vector3f32{ 2.4, -0.4, -3.5},
    math.Vector3f32{-1.7,  3.0, -7.5},
    math.Vector3f32{ 1.3, -2.0, -2.5},
    math.Vector3f32{ 1.5,  2.0, -2.5},
    math.Vector3f32{ 1.5,  0.2, -1.5},
    math.Vector3f32{-1.3,  1.0, -1.5}
  }

  VBO, VAO: u32
  gl.GenVertexArrays(1, &VAO)
  gl.GenBuffers(1, &VBO)

  gl.BindVertexArray(VAO)

  gl.BindBuffer(gl.ARRAY_BUFFER, VBO)
  gl.BufferData(gl.ARRAY_BUFFER, size_of(vertices), &vertices[0], gl.STATIC_DRAW);

  gl.VertexAttribPointer(0, 3, gl.FLOAT, gl.FALSE, 5 * size_of(f32), uintptr(0))
  gl.EnableVertexAttribArray(0)

  gl.VertexAttribPointer(1, 2, gl.FLOAT, gl.FALSE, 5 * size_of(f32), uintptr(3 * size_of(f32)))
  gl.EnableVertexAttribArray(1)


  tex1, tex_ok := texture.createTexture("./crate.png")

  if !tex_ok {
    fmt.eprintln("Error")
    glfw.DestroyWindow(window)
    glfw.Terminate()
    return
  }

  shader.use(program)
  shader.setInt(program, "texture1", 0)


  for bool(!glfw.WindowShouldClose(window)) {
    processInput(window)

    gl.ClearColor(0.2, 0.3, 0.3, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)

    gl.ActiveTexture(gl.TEXTURE0)
    gl.BindTexture(gl.TEXTURE_2D, tex1)

    shader.use(program)

    view := math.MATRIX4F32_IDENTITY
    projection := math.MATRIX4F32_IDENTITY
    projection *= math.matrix4_perspective(f32(math.to_radians(45.0)), f32(WIDTH) / f32(HEIGHT), f32(0.1), f32(100.0))
    view = math.matrix4_translate(math.Vector3f32{0.0, 0.0, -3.0})

    shader.setMat4(program, "projection", projection)
    shader.setMat4(program, "view", view)

    gl.BindVertexArray(VAO)

    for i in 0..<10 {
      model := math.MATRIX4F32_IDENTITY
      model *= math.matrix4_translate(cubePositions[i])
      angle: f32 = 20.0 * f32(i)
      model *= math.matrix4_rotate_f32(math.to_radians(angle), math.Vector3f32{1.0, 0.3, 0.5})
      shader.setMat4(program, "model", model)

      gl.DrawArrays(gl.TRIANGLES, 0, 36)
    }

    glfw.SwapBuffers(window)
    glfw.PollEvents()
  }

  gl.DeleteVertexArrays(1, &VAO)
  gl.DeleteBuffers(1, &VBO)
  gl.DeleteProgram(program.id)
  gl.DeleteTextures(1, &tex1)
  glfw.DestroyWindow(window)
  glfw.Terminate()

}

processInput :: proc(window: glfw.WindowHandle) {
  if glfw.GetKey(window, glfw.KEY_ESCAPE) == glfw.PRESS {
    glfw.SetWindowShouldClose(window, b32(true))
  }
}
