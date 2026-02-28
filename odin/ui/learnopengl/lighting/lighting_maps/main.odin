package lighting_maps


import "core:c"
import "base:runtime"
import "core:log"
import gl "vendor:OpenGL"
import "vendor:glfw"
import "../../getting_start/util"
import math "core:math/linalg"
import "vendor:stb/image"

WIDTH :: 1920
HEIGHT :: 1024


camera: util.Camera
lastX: f32 = f32(WIDTH) / 2.0
lastY: f32 = f32(HEIGHT) / 2.0
firstMouse: bool = true

deltaTime: f32
lastFrame: f32

lightPos: math.Vector3f32 = {1.2, 1.0, 2.0}
cubePos := math.Vector3f32(0)
rotationSpeed: f32 = 1.0

main :: proc() {
  context.logger = log.create_console_logger()
  window := util.windowCreate(WIDTH, HEIGHT, "lighting map")
  defer util.windowDestroy(window)
  camera = util.cameraCreate(position = {0.0, 0.0, 3.0})


  glfw.SetCursorPosCallback(window, mouse_callback)
  glfw.SetScrollCallback(window, scroll_callback)
  //glfw.SetKeyCallback(window, key_callback)
  glfw.SetInputMode(window, glfw.CURSOR, glfw.CURSOR_DISABLED)

  mapShader := util.shaderCreate("./lightMapVertex.glsl", "./lightMapFragment.glsl")
  if mapShader.id == 0 {
    log.error("shader create error")
    return
  }
  defer util.shaderDestroy(&mapShader)
  lightShader := util.shaderCreate("./lightVertex.glsl", "./lightFragment.glsl")
  if lightShader.id == 0 {
    log.error("compile light shader error")
    return
  }
  defer util.shaderDestroy(&lightShader)

  vertices := [?]f32 {
    -0.5, -0.5, -0.5,  0.0,  0.0, -1.0,  0.0,  0.0,
     0.5, -0.5, -0.5,  0.0,  0.0, -1.0,  1.0,  0.0,
     0.5,  0.5, -0.5,  0.0,  0.0, -1.0,  1.0,  1.0,
     0.5,  0.5, -0.5,  0.0,  0.0, -1.0,  1.0,  1.0,
    -0.5,  0.5, -0.5,  0.0,  0.0, -1.0,  0.0,  1.0,
    -0.5, -0.5, -0.5,  0.0,  0.0, -1.0,  0.0,  0.0,

    -0.5, -0.5,  0.5,  0.0,  0.0,  1.0,  0.0,  0.0,
     0.5, -0.5,  0.5,  0.0,  0.0,  1.0,  1.0,  0.0,
     0.5,  0.5,  0.5,  0.0,  0.0,  1.0,  1.0,  1.0,
     0.5,  0.5,  0.5,  0.0,  0.0,  1.0,  1.0,  1.0,
    -0.5,  0.5,  0.5,  0.0,  0.0,  1.0,  0.0,  1.0,
    -0.5, -0.5,  0.5,  0.0,  0.0,  1.0,  0.0,  0.0,

    -0.5,  0.5,  0.5, -1.0,  0.0,  0.0,  1.0,  0.0,
    -0.5,  0.5, -0.5, -1.0,  0.0,  0.0,  1.0,  1.0,
    -0.5, -0.5, -0.5, -1.0,  0.0,  0.0,  0.0,  1.0,
    -0.5, -0.5, -0.5, -1.0,  0.0,  0.0,  0.0,  1.0,
    -0.5, -0.5,  0.5, -1.0,  0.0,  0.0,  0.0,  0.0,
    -0.5,  0.5,  0.5, -1.0,  0.0,  0.0,  1.0,  0.0,

     0.5,  0.5,  0.5,  1.0,  0.0,  0.0,  1.0,  0.0,
     0.5,  0.5, -0.5,  1.0,  0.0,  0.0,  1.0,  1.0,
     0.5, -0.5, -0.5,  1.0,  0.0,  0.0,  0.0,  1.0,
     0.5, -0.5, -0.5,  1.0,  0.0,  0.0,  0.0,  1.0,
     0.5, -0.5,  0.5,  1.0,  0.0,  0.0,  0.0,  0.0,
     0.5,  0.5,  0.5,  1.0,  0.0,  0.0,  1.0,  0.0,

    -0.5, -0.5, -0.5,  0.0, -1.0,  0.0,  0.0,  1.0,
     0.5, -0.5, -0.5,  0.0, -1.0,  0.0,  1.0,  1.0,
     0.5, -0.5,  0.5,  0.0, -1.0,  0.0,  1.0,  0.0,
     0.5, -0.5,  0.5,  0.0, -1.0,  0.0,  1.0,  0.0,
    -0.5, -0.5,  0.5,  0.0, -1.0,  0.0,  0.0,  0.0,
    -0.5, -0.5, -0.5,  0.0, -1.0,  0.0,  0.0,  1.0,

    -0.5,  0.5, -0.5,  0.0,  1.0,  0.0,  0.0,  1.0,
     0.5,  0.5, -0.5,  0.0,  1.0,  0.0,  1.0,  1.0,
     0.5,  0.5,  0.5,  0.0,  1.0,  0.0,  1.0,  0.0,
     0.5,  0.5,  0.5,  0.0,  1.0,  0.0,  1.0,  0.0,
    -0.5,  0.5,  0.5,  0.0,  1.0,  0.0,  0.0,  0.0,
    -0.5,  0.5, -0.5,  0.0,  1.0,  0.0,  0.0,  1.0
  }

  cubeVAO := util.vertexArrayCreate()
  defer util.vertexArrayDestroy(&cubeVAO)
  VBO := util.vertexBufferCreate(&vertices[0], size_of(vertices))
  defer util.vertexBufferDestroy(&VBO)

  util.vertexArrayAddf32(&cubeVAO, 3)
  util.vertexArrayAddf32(&cubeVAO, 3)
  util.vertexArrayAddf32(&cubeVAO, 2)
  util.vertexArrayProcess(&cubeVAO)

  lightVAO := util.vertexArrayCreate()
  defer util.vertexArrayDestroy(&lightVAO)
  util.vertexBufferBind(VBO)

  util.vertexArrayAddf32(&lightVAO, 3)
  lightVAO.stride = size_of(f32) * 8
  util.vertexArrayProcess(&lightVAO)

  diffuseMap := loadTexture("container2.png")
  defer gl.DeleteTextures(1, &diffuseMap)
  specularMap := loadTexture("container2_specular.png")
  defer gl.DeleteTextures(1, &specularMap)

  util.shaderUse(&mapShader)
  util.setInt(&mapShader, "material.diffuse", 0)
  util.setInt(&mapShader, "material.specular", 1)

  for !bool(glfw.WindowShouldClose(window)) {
    currentFrame := f32(glfw.GetTime())
    deltaTime = currentFrame - lastFrame
    lastFrame = currentFrame

    time := f32(glfw.GetTime())
    processInput(window)

    lightPos.x = cubePos.x + math.sin(time * rotationSpeed) * 2.0
    lightPos.z = cubePos.z + math.cos(time * rotationSpeed) * 2.0
    lightPos.y = cubePos.y

    gl.ClearColor(0.1, 0.1, 0.1, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)

    util.shaderUse(&mapShader)
    util.setVec3(&mapShader, "light.position", lightPos)
    util.setVec3(&mapShader, "viewPos", camera.position)

    util.setVec3(&mapShader, "light.ambient", 0.2, 0.2, 0.2)
    util.setVec3(&mapShader, "light.diffuse", 0.5, 0.5, 0.5)
    util.setVec3(&mapShader, "light.specular", 1.0, 1.0, 1.0)

    util.setFloat(&mapShader, "material.shininess", 64.0)

    projection := math.MATRIX4F32_IDENTITY * math.matrix4_perspective(camera.zoom, f32(WIDTH) / f32(HEIGHT), 0.1, 100.0)
    view := util.cameraGetViewMatrix(&camera)
    util.setMat4(&mapShader, "projection", projection)
    util.setMat4(&mapShader, "view", view)

    model := math.MATRIX4F32_IDENTITY
    model *= math.matrix4_translate(cubePos)
    util.setMat4(&mapShader, "model", model)

    gl.ActiveTexture(gl.TEXTURE0)
    gl.BindTexture(gl.TEXTURE_2D, diffuseMap)

    gl.ActiveTexture(gl.TEXTURE1)
    gl.BindTexture(gl.TEXTURE_2D, specularMap)

    util.vertexArrayBind(cubeVAO)
    gl.DrawArrays(gl.TRIANGLES, 0, 36)

    util.shaderUse(&lightShader)
    util.setMat4(&lightShader, "projection", projection)
    util.setMat4(&lightShader, "view", view)
    model = math.MATRIX4F32_IDENTITY
    model *= math.matrix4_translate(lightPos)
    model *= math.matrix4_scale(math.Vector3f32(0.2))
    util.setMat4(&lightShader, "model", model)

    util.vertexArrayBind(lightVAO)
    gl.DrawArrays(gl.TRIANGLES, 0, 36)

    glfw.SwapBuffers(window)
    glfw.PollEvents()
  }
}


mouse_callback :: proc "c" (window: glfw.WindowHandle, xpos, ypos: f64) {
  context = runtime.default_context()

  xpos := f32(xpos)
  ypos := f32(ypos)

  if firstMouse {
    lastX = xpos
    lastY = ypos
    firstMouse = false
  }

  xoffset := xpos - lastX
  yoffset := lastY - ypos

  lastX = xpos
  lastY = ypos
  util.cameraProcessMouseMovement(&camera, xoffset, yoffset)
}

scroll_callback :: proc "c" (window: glfw.WindowHandle, xoffset, yoffset: f64) {
  context = runtime.default_context()
  util.cameraProcessMouseScroll(&camera, f32(yoffset))
}

processInput :: proc(window: glfw.WindowHandle) {
  if glfw.GetKey(window, glfw.KEY_ESCAPE) == glfw.PRESS {
    glfw.SetWindowShouldClose(window, b32(1))
  }
  if glfw.GetKey(window, glfw.KEY_W) == glfw.PRESS {
    util.cameraProcessKeyboard(&camera, .FORWARD, deltaTime)
  }
  if glfw.GetKey(window, glfw.KEY_S) == glfw.PRESS {
    util.cameraProcessKeyboard(&camera, .BACKWARD, deltaTime)
  }
  if glfw.GetKey(window, glfw.KEY_D) == glfw.PRESS {
    util.cameraProcessKeyboard(&camera, .RIGHT, deltaTime)
  }
  if glfw.GetKey(window, glfw.KEY_A) == glfw.PRESS {
    util.cameraProcessKeyboard(&camera, .LEFT, deltaTime)
  }
  if glfw.GetKey(window, glfw.KEY_UP) == glfw.PRESS {
    rotationSpeed += 0.2
  }
  if glfw.GetKey(window, glfw.KEY_DOWN) == glfw.PRESS {
    rotationSpeed -= 0.2
  }
}

loadTexture :: proc(path: string) -> u32 {

  textureID: u32
  gl.GenTextures(1, &textureID)

  width, height, nrComponents: i32
  data := image.load(cstring(raw_data(path)), &width, &height, &nrComponents, 0)

  if data != nil {
    format: i32
    if nrComponents == 1 {
      format = gl.RED
    } else if nrComponents == 3 {
      format = gl.RGB
    } else if nrComponents == 4 {
      format = gl.RGBA
    }

    gl.BindTexture(gl.TEXTURE_2D, textureID)
    gl.TexImage2D(gl.TEXTURE_2D, 0, format, width, height, 0, u32(format), gl.UNSIGNED_BYTE, data)

    gl.GenerateMipmap(gl.TEXTURE_2D)

    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.REPEAT)
    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.REPEAT)

    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_LINEAR)
    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR)

    image.image_free(data)
  }

  return textureID
}

key_callback :: proc "c" (window: glfw.WindowHandle, key, scancode, action, mods: i32) {
  context = runtime.default_context()
  if key == glfw.KEY_ESCAPE && action == glfw.PRESS {
    glfw.SetWindowShouldClose(window, b32(1))
  }
  switch key {
  case glfw.KEY_W:
    util.cameraProcessKeyboard(&camera, .FORWARD, deltaTime)
  case glfw.KEY_S:
    util.cameraProcessKeyboard(&camera, .BACKWARD, deltaTime)
  case glfw.KEY_D:
    util.cameraProcessKeyboard(&camera, .RIGHT, deltaTime)
  case glfw.KEY_A:
    util.cameraProcessKeyboard(&camera, .LEFT, deltaTime)
  }
}
