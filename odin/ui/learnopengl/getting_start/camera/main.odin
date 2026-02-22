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

firstMouse: bool = true
yaw: f32 = -90.0
pitch: f32 = 0.0
lastX: f32 = f32(WIDTH) / 2.0
lastY: f32 = f32(HEIGHT) / 2.0
fov: f32 = 45.0

deltaTime: f32 = 0.0
lastFrame: f32 = 0.0


main :: proc() {
  log.info("init glfw")
  window := util.windowCreate(WIDTH, HEIGHT, "Camera")
  defer util.windowDestroy(window)

  glfw.SetCursorPosCallback(window, mouse_callback)
  glfw.SetScrollCallback(window, scroll_callback)

  glfw.SetInputMode(window, glfw.CURSOR, glfw.CURSOR_DISABLED)

  program := util.shaderCreate("./vertex.glsl", "./fragment.glsl")
  if program.id == 0 {
    fmt.eprintln("Compile shader error")
    return
  }
  defer util.shaderDestroy(&program)

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
  defer util.vertexArrayDestroy(&VAO)
  VBO := util.vertexBufferCreate(&vertices[0], size_of(vertices))
  defer util.vertexBufferDestroy(&VBO)

  util.vertexArrayAddf32(&VAO, 3)
  util.vertexArrayAddf32(&VAO, 2)
  util.vertexArrayProcess(&VAO)

  texture := util.textureCreate("./cat_plus_wife.png")
  defer util.textureDestroy(texture)
  util.shaderUse(&program)
  util.setInt(&program, "texture1", 0)

  projection := math.matrix4_perspective(f32(math.to_radians(45.0)), f32(WIDTH) / f32(HEIGHT), f32(0.1), f32(100.0))
  util.setMat4(&program, "projection", projection)

  for !bool(glfw.WindowShouldClose(window)) {
    currentFrame := f32(glfw.GetTime())
    deltaTime = currentFrame - lastFrame
    lastFrame = currentFrame

    processInput(window)

    gl.ClearColor(0.2, 0.3, 0.3, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)

    gl.ActiveTexture(gl.TEXTURE0)
    util.textureBind(texture)

    util.shaderUse(&program)

    view := math.matrix4_look_at(cameraPos, cameraPos + cameraFront, cameraUp)
    //view *= math.matrix4_rotate(f32(glfw.GetTime()) * 0.2, math.Vector3f32{0.0, 0.0, 1.0})
    util.setMat4(&program, "view", view)

    util.vertexArrayBind(VAO)

    for i in 0..<len(cubePositions) {
      model := math.MATRIX4F32_IDENTITY * math.matrix4_translate(cubePositions[i])
      angle: f32 = 20.0 * f32(i)
      model *= math.matrix4_rotate(f32(glfw.GetTime()) * angle * 0.1, math.Vector3f32{1.0, 0.3, 0.5})
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

  cameraSpeed := f32(2.5 * deltaTime)
  if glfw.GetKey(window, glfw.KEY_W) == glfw.PRESS {
    cameraPos += cameraSpeed * cameraFront
  }
  if glfw.GetKey(window, glfw.KEY_S) == glfw.PRESS {
    cameraPos -= cameraSpeed * cameraFront
  }
  if glfw.GetKey(window, glfw.KEY_A) == glfw.PRESS {
    cameraPos -= math.normalize(math.cross(cameraFront, cameraUp)) * cameraSpeed
  }
  if glfw.GetKey(window, glfw.KEY_D) == glfw.PRESS {
    cameraPos += math.normalize(math.cross(cameraFront, cameraUp)) * cameraSpeed
  }
}

mouse_callback :: proc "c" (window: glfw.WindowHandle, xpos, ypos: f64) {
  xpos := f32(xpos)
  ypos := f32(ypos)

  if firstMouse {
    lastX = xpos
    lastY = ypos
    firstMouse = false
  }

  xoffset: f32 = xpos - lastX
  yoffset: f32 = lastY - ypos
  lastX = xpos
  lastY = ypos

  sensitivity := f32(0.1)
  xoffset *= sensitivity
  yoffset *= sensitivity

  yaw += xoffset
  pitch += yoffset

  if pitch > 89.0 {
    pitch = 89.0
  }
  if pitch < -89.0 {
    pitch = -89.0
  }

  front: math.Vector3f32
  front.x = math.cos(math.to_radians(yaw)) * math.cos(math.to_radians(pitch))
  front.y = math.sin(math.to_radians(pitch))
  front.z = math.sin(math.to_radians(yaw)) * math.cos(math.to_radians(pitch))
  cameraFront = math.normalize(front)
}

scroll_callback :: proc "c" (window: glfw.WindowHandle, xoffset, yoffset: f64)
{
  fov -= f32(yoffset)
  if fov < 1.0 {
    fov = 1.0
  }
  if fov > 45.0 {
    fov = 45.0
  }
}
