package textures

import "vendor:glfw"
import gl "vendor:OpenGL"
import "shader"
import "core:log"
import "core:os"
import "core:fmt"

init_logger :: proc() {
  f: ^os.File
  err: os.Error
  if !os.exists("gl_log.log") {
    f, err = os.open("gl_log.log", {.Create, .Write, .Read})
    if err != nil {
      fmt.eprintln("Failed to create gl_log.log file")
      return
    }
  } else {
    f, err = os.open("gl_log.log", {.Write})
  }
  context.logger = log.create_file_logger(f, .Debug)
}

deinit_logger :: proc() {
  log.destroy_file_logger(context.logger)
}

main :: proc() {
  init_logger()
  defer deinit_logger()

  log.info("Logger created")
}
