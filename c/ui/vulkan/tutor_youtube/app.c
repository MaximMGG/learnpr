#include "app.h"



App defaultApp() {
  return (App){.v_window = createWindow(WIDTH, HEIGHT, "Test")};
}

void run(App *a) {
  while(!windowShouldClose(a->v_window)) {

    glfwSwapBuffers(a->v_window->window);
    glfwPollEvents();
  }

}
