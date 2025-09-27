#include <stdio.h>
#include <GLFW/glfw3.h>
#include <GL/gl.h>
#include <stdlib.h>
#include <cstdext/io/logger.h>

#define WIDTH 640
#define HEIGHT 480


int main() {
  
  if (!glfwInit()) {
    log(FATAL, "glfwInit fail");
    return EXIT_FAILURE;
  }
  log(INFO, "glfwInit");  

  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "TEST WINDOW", NULL, NULL);

  if (window == NULL) {
    log(FATAL, "CreateWindow error");
    return EXIT_FAILURE;
  }
  log(INFO, "CreateWindow");

  glfwMakeContextCurrent(window);

  while(!glfwWindowShouldClose(window)) {
    glClear(GL_COLOR_BUFFER_BIT);

    glBegin(GL_TRIANGLES);
    glVertex2f(-0.5f, -0.5f);
    glVertex2f( 0.0f,  0.5f);
    glVertex2f( 0.5f, -0.5f);    
    
    glEnd();
    
    glfwSwapBuffers(window);
    glfwPollEvents();
  }

  glfwDestroyWindow(window);
  glfwTerminate();  

  return 0;  
}
