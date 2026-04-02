#include <stdio.h>
#include <GLFW/glfw3.h>
#include <GL/gl.h>

#define WIDTH 640
#define HEIGHT 480

int main() {
  if (!glfwInit()) {
    fprintf(stderr, "glfwInit faile\n");
    return 1;
  }

  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Test WINDOW", NULL, NULL);

  if (window == NULL) {
    fprintf(stderr, "CreateWindow error\n");
    return 1;
  }

  glfwMakeContextCurrent(window);

  while(!glfwWindowShouldClose(window)) {
    glClear(GL_COLOR_BUFFER_BIT);

    glfwSwapBuffers(window);

    glfwPollEvents();
  }
  glfwDestroyWindow(window);
  glfwTerminate();

  return 0;
}
