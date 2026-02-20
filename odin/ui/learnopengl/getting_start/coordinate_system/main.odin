package coordinate_system


import gl "vendor:OpenGL"
import "vendor:glfw"
import "../util"

import math "core:math/linalg"


WIDTH :: 720
HEIGHT :: 480


main :: proc() {
  window := util.windowCreate(WIDTH, HEIGHT, "Coordinate")
  defer util.windowDestroy(window)

  program := util.shaderCreate("./vertex.glsl", "./fragment.glsl")
  vertices := [?]f32 {
    0.5,  0.5, 0.0,   1.0, 1.0, // top right
    0.5, -0.5, 0.0,   1.0, 0.0, // bottom right
    -0.5, -0.5, 0.0,   0.0, 0.0, // bottom left
    -0.5,  0.5, 0.0,   0.0, 1.0  // top l
  }

  indices := [?]u32 {
    0, 1, 3, 1, 2, 3
  }

  VAO := util.vertexArrayCreate()
  util.vertexArrayBind(VAO)

  VBO := util.vertexBufferCreate(&vertices[0], size_of(vertices))
  EBO := util.vertexElementCreate(&indices[0], size_of(indices))

  util.vertexArrayAddf32(&VAO, 3)
  util.vertexArrayAddf32(&VAO, 2)
  util.vertexArrayProcess(&VAO)

  texture := util.textureCreate("./crate.png")

  util.shaderUse(&program)
  util.setInt(&program, "texture1", 0)

  for bool(glfw.WindowShouldClose(window)) {
    gl.ClearColor(0.2, 0.3, 0.3, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT)

    gl.ActiveTexture(gl.TEXTURE0)
    util.textureBind(texture)

    util.shaderUse(&program)

    model := math.MATRIX4F32_IDENTITY
    view := math.MATRIX4F32_IDENTITY
    projection := math.MATRIX4F32_IDENTITY
    model *= math.matrix4_rotate(f32(-55), math.Vector3f32{1.0, 0.0, 0.0})
    view *= math.matrix4_translate(math.Vector3f32{0.0, 0.0, -3.0})
    projection *= math.matrix4_perspective(f32(45.0), f32(WIDTH) / f32(HEIGHT), f32(0.1), f32(100.0))

    util.setMat4(&program, "model", model)
    util.setMat4(&program, "model", view)

    util.vertexArrayBind(VAO)
    gl.DrawElements(gl.TRIANGLES, 6, gl.UNSIGNED_INT, nil)

    glfw.SwapBuffers(window)
    glfw.PollEvents()
  }
}

processInput :: proc(window: glfw.WindowHandle) {
  if glfw.GetKey(window, glfw.KEY_ESCAPE) == glfw.PRESS {
    glfw.SetWindowShouldClose(window, b32(1))
  }
}
