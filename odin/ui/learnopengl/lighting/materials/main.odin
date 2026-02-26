package materials

import "core:log"
import "vendor:glfw"
import gl "vendor:OpenGL"
import "../../getting_start/util"
import math "core:math/linalg"


WIDTH :: 1920
HEIGHT :: 1024

camera: util.Camera
lastX: f32 = f32(WIDTH) / 2.0
lastY: f32 = f32(HEIGHT) / 2.0
firstMouse: bool = true

deltaTime: f32 = 0
lastFrame: f32 = 0

lightPos: math.Vector3f32 = {1.2, 1.0, 2.0}

main :: proc() {
  log.info("Init glfw")
  window := util.windowCreate(WIDTH, HEIGHT, "Materials")
  defer util.windowDestroy(window)

  camera = util.cameraCreate(math.Vector3f32{0.0, 0.0, 3.0})

  glfw.SetCursorPosCallback(window, mouse_callback)
  glfw.SetScrollCallback(window, scroll_callback)
  glfw.SetInputMode(window, glfw.CURSOR, glfw.CURSOR_DISABLED)

  cubeShader := util.shaderCreate("./cubeVertex.glsl", "./cubeFragment.glsl")
  if cubeShader.id == 0 {
    log.error("Cube Shader load error")
    return
  }
  defer util.shaderDestroy(&cubeShader)
  lightShader := util.shaderCreate("./lightVertex.glsl", "./lightFragment.glsl")
  if lightShader.id == 0 {
    log.error("Light shader load error")
    return
  }
  defer util.shaderDestroy(&lightShader)

  vertices := [?]f32 {

    -0.5, -0.5, -0.5,  0.0,  0.0, -1.0,
     0.5, -0.5, -0.5,  0.0,  0.0, -1.0,
     0.5,  0.5, -0.5,  0.0,  0.0, -1.0,
     0.5,  0.5, -0.5,  0.0,  0.0, -1.0,
    -0.5,  0.5, -0.5,  0.0,  0.0, -1.0,
    -0.5, -0.5, -0.5,  0.0,  0.0, -1.0,

    -0.5, -0.5,  0.5,  0.0,  0.0,  1.0,
     0.5, -0.5,  0.5,  0.0,  0.0,  1.0,
     0.5,  0.5,  0.5,  0.0,  0.0,  1.0,
     0.5,  0.5,  0.5,  0.0,  0.0,  1.0,
    -0.5,  0.5,  0.5,  0.0,  0.0,  1.0,
    -0.5, -0.5,  0.5,  0.0,  0.0,  1.0,

    -0.5,  0.5,  0.5, -1.0,  0.0,  0.0,
    -0.5,  0.5, -0.5, -1.0,  0.0,  0.0,
    -0.5, -0.5, -0.5, -1.0,  0.0,  0.0,
    -0.5, -0.5, -0.5, -1.0,  0.0,  0.0,
    -0.5, -0.5,  0.5, -1.0,  0.0,  0.0,
    -0.5,  0.5,  0.5, -1.0,  0.0,  0.0,

     0.5,  0.5,  0.5,  1.0,  0.0,  0.0,
     0.5,  0.5, -0.5,  1.0,  0.0,  0.0,
     0.5, -0.5, -0.5,  1.0,  0.0,  0.0,
     0.5, -0.5, -0.5,  1.0,  0.0,  0.0,
     0.5, -0.5,  0.5,  1.0,  0.0,  0.0,
     0.5,  0.5,  0.5,  1.0,  0.0,  0.0,

    -0.5, -0.5, -0.5,  0.0, -1.0,  0.0,
     0.5, -0.5, -0.5,  0.0, -1.0,  0.0,
     0.5, -0.5,  0.5,  0.0, -1.0,  0.0,
     0.5, -0.5,  0.5,  0.0, -1.0,  0.0,
    -0.5, -0.5,  0.5,  0.0, -1.0,  0.0,
    -0.5, -0.5, -0.5,  0.0, -1.0,  0.0,

    -0.5,  0.5, -0.5,  0.0,  1.0,  0.0,
     0.5,  0.5, -0.5,  0.0,  1.0,  0.0,
     0.5,  0.5,  0.5,  0.0,  1.0,  0.0,
     0.5,  0.5,  0.5,  0.0,  1.0,  0.0,
    -0.5,  0.5,  0.5,  0.0,  1.0,  0.0,
    -0.5,  0.5, -0.5,  0.0,  1.0,  0.0
  }
  cubeVAO := util.vertexArrayCreate()
  defer util.vertexArrayDestroy(&cubeVAO)
  VBO := util.vertexBufferCreate(&vertices[0], size_of(vertices))
  defer util.vertexBufferDestroy(&VBO)
  util.vertexArrayAddf32(&cubeVAO, 3)
  util.vertexArrayAddf32(&cubeVAO, 3)
  util.vertexArrayProcess(&cubeVAO)

  lightCubeVAO := util.vertexArrayCreate()
  defer util.vertexArrayDestroy(&lightCubeVAO)
  util.vertexArrayAddf32(&lightCubeVAO, 3)
  lightCubeVAO.stride = size_of(f32) * 6
  util.vertexArrayProcess(&lightCubeVAO)

  for !bool(glfw.WindowShouldClose(window)) {

    currentFrame := f32(glfw.GetTime())
    deltaTime = currentFrame - lastFrame
    lastFrame = currentFrame

    processInput(window)

    gl.ClearColor(0.1, 0.1, 0.1, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)


    //be sure to activate shader when setting unfiroms/drawing object
    util.shaderUse(&cubeShader)
    util.setVec3(&cubeShader, "light.position", lightPos)
    util.setVec3(&cubeShader, "viewPos", camera.position)

    //light properties
    lightColor: math.Vector3f32
    time := f32(glfw.GetTime())
    lightColor.x = f32(math.sin(time * 2.0))
    lightColor.y = f32(math.sin(time * 0.7))
    lightColor.z = f32(math.sin(time * 1.3))
    diffuseColor := lightColor * math.Vector3f32(0.5)
    ambientColor := diffuseColor * math.Vector3f32(0.2)
    util.setVec3(&cubeShader, "light.ambient", ambientColor)
    util.setVec3(&cubeShader, "light.diffuse", diffuseColor)
    util.setVec3(&cubeShader, "light.specular", {1.0, 1.0, 1.0})

    //material properties
    util.setVec3(&cubeShader, "material.ambient", 1.0, 0.5, 0.31)
    util.setVec3(&cubeShader, "material.diffuse", 1.0, 0.5, 0.31)
    util.setVec3(&cubeShader, "material.specular", 0.5, 0.5, 0.5)
    util.setFloat(&cubeShader, "material.shininess", 32.0)

    //view/projection transformation
    projection := math.MATRIX4F32_IDENTITY *
    math.matrix4_perspective(f32(math.to_radians(camera.zoom)), f32(WIDTH) / f32(HEIGHT), 0.1, 100.0)
    view := util.cameraGetViewMatrix(&camera)

    util.setMat4(&cubeShader, "projection", projection)
    util.setMat4(&cubeShader, "view", view)


    //world transformation
    model := math.MATRIX4F32_IDENTITY
    util.setMat4(&cubeShader, "model", model)

    //render the cube
    util.vertexArrayBind(cubeVAO)
    gl.DrawArrays(gl.TRIANGLES, 0, 36)

    //also draw the lamp object
    util.shaderUse(&lightShader)
    util.setMat4(&lightShader, "projection", projection)
    util.setMat4(&lightShader, "view", view)
    model = math.MATRIX4F32_IDENTITY
    model *= math.matrix4_translate(lightPos)
    moel *= math.matrix4_scale(math.Vector3f32(0.2))
    util.setMat4(&lightShader, "model", model)

    util.vertexArrayBind(lightCubeVAO)
    gl.DrawArrays(gl.TRIANGLES, 0, 36)
    
    glfw.SwapBuffers(window)
    glfw.PollEvents()
  }
}


mouse_callback :: proc "c" (window: glfw.WindowHandle, xpos, ypos: f64) {

}

scroll_callback :: proc "c" (window: glfw.WindowHandle, xoffset, yoffset: f64) {

}

processInput :: proc(window: glfw.WindowHandle) {

}


