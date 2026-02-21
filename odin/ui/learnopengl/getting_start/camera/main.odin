package camera


import gl "vendor:OpenGL"
import "vendor:glfw"
import "core:fmt"
import math "core:math/linalg"
import "core:log"
import "../util"


WIDTH :: 1920
HEIGHT :: 1024

cameraPos := math.Vector3f32{0.0, 0.0, 3.0}
cameraFront := math.Vector3f32{0.0, 0.0, -1.0}
cameraUp := math.Vector3f32{0.0, 1.0, 0.0}

deltaTime: f32 = 0.0
lastFrame: f32 = 0.0


main :: proc() {
  log.info("init glfw")
  window := util.windowCreate(WIDTH, HEIGHT, "Camera")
  defer util.windowDestroy(window)

  program := util.shaderCreate("./vertex.glsl", "./fragment.glsl")

  vertices := [?]f32 {
    -0.5, -0.5, -0.5,  0.0, 0.0,
     0.5, -0.5, -0.5,  1.0, 0.0,
     0.5,  0.5, -0.5,  1.0, 1.0,
     0.5,  0.5, -0.5,  1.0, 1.0,
    -0.5, -0.5, -0.5,  0.0, 0.0,
    -0.5,  0.5, -0.5,  0.0, 1.0,

    -0.5, -0.5,  0.5,  0.0, 0.0,
     0.5, -0.5,  0.5,  1.0, 0.0,
     0.5,  0.5,  0.5,  1.0, 1.0,
    -0.5,  0.5,  0.5,  0.0, 1.0,
     0.5,  0.5,  0.5,  1.0, 1.0,
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

  VAO := util.vertexArrayCreate()
  VBO := util.vertexBufferCreate(&vertices[0], size_of(vertices))

  util.vertexArrayAddf32(&VAO, 3)
  util.vertexArrayAddf32(&VAO, 2)
  util.vertexArrayProcess(&VAO)

  texture := util.textureCreate("./cat_plus_wife.png")
  util.shaderUse(&program)
  util.setInt(&program, "texture1", 0)

  projection := math.matrix4_perspective(f32(math.to_radians(45.0)), f32(WIDTH) / f32(HEIGHT), f32(0.1), f32(100.0))
  util.setMat4(&program, "projection", projection)

  for !bool(glfw.WindowShouldClose(window)) {
    currentFrame := f32(glfw.GetTime())
    deltaTime = currentFrame - lastFrame
    lastFrame = currentFrame


    processInput(window)
  }

}


processInput :: proc(window: glfw.WindowHandle) {
  if glfw.GetKey(window, glfw.KEY_ESCAPE) == glfw.PRESS {
    glfw.SetWindowShouldClose(window, b32(1))
  }

  cameraSpeed := f32(2.5 * deltaTime)
  if glfw.GetKey(window, glfw.KEY_W) == glfw.PRESS {
    cameraPos += cameraSpeed * cameraFront
  }
  if glfw.GetKey(window, glfw.KEY_S) == glfw.PRESS {
    cameraPos -= cameraSpeed * cameraFront
  }
  if glfw.GetKey(window, glfw.KEY_A) == glfw.PRESS {
    cameraPos -= math.normalize(math.cross())
  }
  if glfw.GetKey(window, glfw.KEY_D) == glfw.PRESS {
    cameraPos += cameraSpeed * cameraFront
  }



}
