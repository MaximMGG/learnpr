package materials

import "core:log"
import "vendor:glfw"
import gl "vendor:OpenGL"
import "../../getting_start/util"


WIDTH :: 1920
HEIGHT :: 1024


main :: proc() {
  log.info("Init glfw")
  window := util.windowCreate(WIDTH, HEIGHT, "Materials")

  cubeShader := util.shaderCreate("./cubeVertex.glsl", "./cubeFragment.glsl")
  if cubeShader.

}
