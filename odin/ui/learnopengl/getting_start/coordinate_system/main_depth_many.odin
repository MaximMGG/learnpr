package coordinate_system_depth_many

import gl "vendor:OpenGL"
import "vendor:glfw"
import "../util"

import math "core:math/linalg"


WIDTH :: 720
HEIGHT :: 480

speedIncreaseStep: f32  = 0.005
speedIncrease: f32 = 0.2

main :: proc() {
  window := util.windowCreate(WIDTH, HEIGHT, "Coordinate")
  defer util.windowDestroy(window)

  program := util.shaderCreate("./vertex.glsl", "./fragment.glsl")

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
    math.Vector3f32{ 0.0,  0.0,  -3.0},
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

  rotatePosition := [?]math.Vector3f32{
    math.Vector3f32{1.0, 0.8, 1.7},
    math.Vector3f32{1.1, 0.1, 0.2},
    math.Vector3f32{0.0, 1.2, 0.7},
    math.Vector3f32{0.3, 1.5, 0.6},
    math.Vector3f32{0.8, 1.0, 0.1},
    math.Vector3f32{0.5, 0.7, 0.6},
    math.Vector3f32{1.7, 0.6, 0.9},
    math.Vector3f32{0.2, 0.5, 0.0},
    math.Vector3f32{0.9, 1.1, 1.0},
    math.Vector3f32{0.66, 0.0, 0.2},
  }

  speedRation := [?]f32 {
    0.2, 0.4, 0.6, 0.8, 1.0, 1.2, 1.4, 1.6, 1.8, 2.0
  }

  VAO := util.vertexArrayCreate()
  util.vertexArrayBind(VAO)

  VBO := util.vertexBufferCreate(&vertices[0], size_of(vertices))

  util.vertexArrayAddf32(&VAO, 3)
  util.vertexArrayAddf32(&VAO, 2)
  util.vertexArrayProcess(&VAO)

  texture := util.textureCreate("./crate.png")

  util.shaderUse(&program)
  util.setInt(&program, "texture1", 0)


  projection := math.MATRIX4F32_IDENTITY * math.matrix4_perspective(math.to_radians(f32(45.0)), f32(WIDTH) / f32(HEIGHT), f32(0.1), f32(100))
  view := math.MATRIX4F32_IDENTITY * math.matrix4_translate(math.Vector3f32{0.0, 0.0, -3.0})
  util.setMat4(&program, "projection", projection)
  util.setMat4(&program, "view", view)


  for bool(!glfw.WindowShouldClose(window)) {
    processInput(window)

    gl.ClearColor(0.2, 0.3, 0.3, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)

    gl.ActiveTexture(gl.TEXTURE0)
    util.textureBind(texture)

    util.shaderUse(&program)
    util.vertexArrayBind(VAO)
    for i in 0..<len(cubePositions) {
      // angle: f32 = 20.0 * f32(i)
      model := math.MATRIX4F32_IDENTITY * math.matrix4_translate(cubePositions[i])

      model *= math.matrix4_rotate(f32(glfw.GetTime()) * speedRation[i] * speedIncrease, rotatePosition[i])
      util.setMat4(&program, "model", model)

      gl.DrawArrays(gl.TRIANGLES, 0, 36)
    }

    glfw.SwapBuffers(window)
    glfw.PollEvents()
  }
}

processInput :: proc(window: glfw.WindowHandle) {
  if glfw.GetKey(window, glfw.KEY_ESCAPE) == glfw.PRESS {
    glfw.SetWindowShouldClose(window, b32(1))
  }
  if glfw.GetKey(window, glfw.KEY_F) == glfw.PRESS {
    speedIncrease += speedIncreaseStep
  }
  if glfw.GetKey(window, glfw.KEY_S) == glfw.PRESS {
    speedIncrease -= speedIncreaseStep  
  }
}
