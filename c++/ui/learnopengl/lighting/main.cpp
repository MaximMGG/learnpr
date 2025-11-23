#include <iostream>
#include "../lib/util.hpp"


#define WIDTH 1280
#define HEIGHT 720
#define APP_NAME "Lightening"

int main() {
  WindowManager w(WIDTH, HEIGHT, APP_NAME);

  int glew_res = glewInit();
  if (glew_res != 0 && glew_res != 4) {
    std::cerr << "glewInit failed, code is: " << glew_res << "\n";
    return 1;
  }

  while(!glfwWindowShouldClose(w.window)) {
    GLCall(glClear(GL_COLOR_BUFFER_BIT));

    w.process();
  }

  return 0;
}
