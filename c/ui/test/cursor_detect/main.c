#include <cglm/cglm.h>
#include <glad/glad.h> 
#include <GLFW/glfw3.h>
#include <cstdext/core.h>
#include <cstdext/io/logger.h>


#define WIDTH 1280
#define HEIGHT 960


void init_logger() {
  logSetOpt(DEF_OPTION, LOG_TYPE_FILE, "gl_log.log");
}

void deinit_logger() {
  logCleanup();
}


i32 main() {
  if (!glfwInit()) {
    log(ERROR, "glfwInit error");
    return 1;
  }

  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Test window", null, null);

  glfwWindowHint(GLFW_VERSION_MAJOR, 3);
  glfwWindowHint(GLFW_VERSION_MINOR, 3);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

  mat4 ortho = GLM_MAT4_IDENTITY;
  glm_ortho(0, cast(f32, WIDTH), 0, cast(f32, HEIGHT), -1, 100, ortho);


  glfwMakeContextCurrent(window);



  return 0;
}


