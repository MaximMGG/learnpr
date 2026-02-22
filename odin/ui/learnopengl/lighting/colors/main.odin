package colors

import gl "vendor:OpenGL"
import "base:runtime"
import math "core:math/linalg"
import "vendor:glfw"
import "core:fmt"
import "core:log"
import "../../getting_start/util"

WIDTH :: 1920
HEIGHT :: 1024


lastX: f32 = f32(WIDTH) / 2.0
lastY: f32 = f32(HEIGHT) / 2.0
firstMouse: bool = true

camera: util.Camera

deltaTime: f32 = 0.0
lastFrame: f32 = 0.0

lightPos := math.Vector3f32{1.2, 1.0, 2.0}
cubePos := math.Vector3f32{0.5, 0.5, 0.5}

main :: proc() {


  log.info("init glfw")
  window := util.windowCreate(WIDTH, HEIGHT, "Colors")
  defer util.windowDestroy(window)

  camera = util.cameraCreate(math.Vector3f32{0.0, 0.0, 3.0})

  glfw.SetCursorPosCallback(window, mouse_callback)
  glfw.SetScrollCallback(window, scroll_callback)

  glfw.SetInputMode(window, glfw.CURSOR, glfw.CURSOR_DISABLED)

  log.info("Create shader")
  lightingShader := util.shaderCreate("./colorVertex.glsl", "./colorFragment.glsl")
  lightCubeShader := util.shaderCreate("./light_cube_vertex.glsl", "./light_cube_fragment.glsl")
  if lightingShader.id == 0 {
    log.error("Create lighting shader error")
    return
  }
  defer util.shaderDestroy(&lightingShader)
  if lightCubeShader.id == 0 {
    log.error("Create light cube shader error")
    return
  }
  defer util.shaderDestroy(&lightCubeShader)

  vertices := [?]f32 {
      -0.5, -0.5, -0.5, 
         0.5, -0.5, -0.5,  
         0.5,  0.5, -0.5,  
         0.5,  0.5, -0.5,  
        -0.5,  0.5, -0.5, 
        -0.5, -0.5, -0.5, 

        -0.5, -0.5,  0.5, 
         0.5, -0.5,  0.5,  
         0.5,  0.5,  0.5,  
         0.5,  0.5,  0.5,  
        -0.5,  0.5,  0.5, 
        -0.5, -0.5,  0.5, 

        -0.5,  0.5,  0.5, 
        -0.5,  0.5, -0.5, 
        -0.5, -0.5, -0.5, 
        -0.5, -0.5, -0.5, 
        -0.5, -0.5,  0.5, 
        -0.5,  0.5,  0.5, 

         0.5,  0.5,  0.5,  
         0.5,  0.5, -0.5,  
         0.5, -0.5, -0.5,  
         0.5, -0.5, -0.5,  
         0.5, -0.5,  0.5,  
         0.5,  0.5,  0.5,  

        -0.5, -0.5, -0.5, 
         0.5, -0.5, -0.5,  
         0.5, -0.5,  0.5,  
         0.5, -0.5,  0.5,  
        -0.5, -0.5,  0.5, 
        -0.5, -0.5, -0.5, 

        -0.5,  0.5, -0.5, 
         0.5,  0.5, -0.5,  
         0.5,  0.5,  0.5,  
         0.5,  0.5,  0.5,  
        -0.5,  0.5,  0.5, 
        -0.5,  0.5, -0.5
  }

  log.info("Create VAOs and VBO")
  cubeVAO := util.vertexArrayCreate()
  defer util.vertexArrayDestroy(&cubeVAO)
  VBO := util.vertexBufferCreate(&vertices[0], size_of(vertices))
  defer util.vertexBufferDestroy(&VBO)
  util.vertexArrayAddf32(&cubeVAO, 3)
  util.vertexArrayProcess(&cubeVAO)

  lightCubeVAO := util.vertexArrayCreate()
  defer util.vertexArrayDestroy(&lightCubeVAO)
  util.vertexBufferBind(VBO)

  util.vertexArrayAddf32(&lightCubeVAO, 3)
  util.vertexArrayProcess(&lightCubeVAO)

  log.info("mAin loop start")
  for !bool(glfw.WindowShouldClose(window)) {

    currentFrame := f32(glfw.GetTime())
    deltaTime = currentFrame - lastFrame
    lastFrame = currentFrame

    processInput(window)

    gl.ClearColor(0.1, 0.1, 0.1, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)

    util.shaderUse(&lightingShader)
    util.setVec3(&lightingShader, "objectColor", 1.0, 0.5, 0.31)
    util.setVec3(&lightingShader, "lightColor", 1.0, 1.0, 1.0)

    projection := math.MATRIX4F32_IDENTITY * math.matrix4_perspective(math.to_radians(camera.zoom), f32(WIDTH) / f32(HEIGHT), 0.1, 100.0)
    view := util.cameraGetViewMatrix(&camera)
    util.setMat4(&lightingShader, "projection", projection)
    util.setMat4(&lightingShader, "view", view)

    model := math.MATRIX4F32_IDENTITY * math.matrix4_translate(cubePos)
    util.setMat4(&lightingShader, "model", model)
    
    //render Cube
    util.vertexArrayBind(cubeVAO)
    gl.DrawArrays(gl.TRIANGLES, 0, 36)

    // draw lamp object
    util.shaderUse(&lightCubeShader)
    util.setMat4(&lightCubeShader, "projection", projection)
    util.setMat4(&lightCubeShader, "view", view)
    model = math.MATRIX4F32_IDENTITY
    model *= math.matrix4_translate(lightPos)
    model *= math.matrix4_scale(math.Vector3f32{0.2, 0.2, 0.2})
    util.setMat4(&lightCubeShader, "model", model)

    util.vertexArrayBind(lightCubeVAO)
    gl.DrawArrays(gl.TRIANGLES, 0, 36)


    glfw.SwapBuffers(window)
    glfw.PollEvents()
  }
  log.info("END")
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
}


mouse_callback :: proc "c" (window: glfw.WindowHandle, xpos, ypos: f64) {
  context = runtime.default_context()
  xpos := f32(xpos)
  ypos := f32(ypos)

  if firstMouse {
    lastX = xpos
    lastY = xpos
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



