#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <glad/glad.h>
#include <GLFW/glfw3.h>

#define WIDTH 1280
#define HEIGHT 720

void frameBufferCallback(GLFWwindow *window, i32 width, i32 height) {
  glViewport(0, 0, width, height);
}

i32 main() {
  logSetOpt(LOG_OPTION_DEF, LOG_TYPE_FILE, "gl_log.log");

  if (!glfwInit()) {
    LOG(ERROR, "glfwInit error");
    return 1;
  }

  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Cursor experiments", null, null);
  if (!window) {
    LOG(ERROR, "glfwCreateWindow error");
    glfwTerminate();
    return 1;
  }

  LOG(INFO, "init glfw and Craete Window");

  glfwWindowHint(GLFW_VERSION_MAJOR, 3);
  glfwWindowHint(GLFW_VERSION_MINOR, 3);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

  glfwMakeContextCurrent(window);
  gladLoadGLLoader((GLADloadproc)glfwGetProcAddress);

  

  LOG(INFO, "Init OpenGL");


  
  
  while(!glfwWindowShouldClose(window)) {
    glClearColor(0.2, 0.3, 0.3, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);

    
    glfwSwapBuffers(window);
    glfwPollEvents();
  }

  glfwDestroyWindow(window);
  glfwTerminate();


  LOG(INFO, "End of OpenGL");
  logCleanup();
  return 0;
}
