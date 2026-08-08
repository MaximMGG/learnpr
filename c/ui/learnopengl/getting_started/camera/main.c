#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <cstdext/core.h>
#include "shader.h"
#include "texture.h"

#define WIDTH 1280
#define HEIGHT 720


i32 main() {
  glfwInit();
  logSetOpt(LOG_OPTION_DEF, LOG_TYPE_FILE, "gl_log.log");
  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Camera example", null, null);
  if (window == null) {
    LOG(ERROR, "glfwCreateWindow error");
    glfwTerminate();
    return 1;
  }


  logCleanup();
  return 0;
}



