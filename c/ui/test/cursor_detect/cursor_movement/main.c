#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include "rect.h"
#include "renderer.h"
#include "circle.h"
#include "shader.h"
#include <cglm/cglm.h>

#define WIDTH 1280
#define HEIGHT 720

f64 x = 0.0;
f64 y = 0.0;
bool new_rect = false;
bool reset = false;
bool new_circle = false;
f32 size = 10.0;

void scrollCallback(GLFWwindow* window, f64 xoffset, f64 yoffset) {
  if (yoffset > 0.0) {
    if (size >= 100.0) {
      size = 100.0;
    } else {
      size += 1.0;
    }
  }
  if (yoffset < 0.0) {
    if (size <= 1.0) {
      size = 1.0;
    } else  {
      size -= 1.0;
    }
  }
}

void mouseKeyCallback(GLFWwindow* window, int button, int action, int mods) {
  printf("Action == %d\n", action);
  if (button == GLFW_MOUSE_BUTTON_LEFT && action == GLFW_PRESS) {
    new_rect = true;
  }
  if (button == GLFW_MOUSE_BUTTON_LEFT && action == GLFW_RELEASE) {
    new_rect = false;
  }
  if (button == GLFW_MOUSE_BUTTON_RIGHT && action == GLFW_PRESS) {
    new_circle = true;
  }
  if (button == GLFW_MOUSE_BUTTON_RIGHT && action == GLFW_RELEASE) {
    new_circle = false;
  }
}

void keyCallback(GLFWwindow* window, i32 key, i32 scancode, i32 action, i32 mods) {
  if (key == GLFW_KEY_ESCAPE && action == GLFW_PRESS) {
    glfwSetWindowShouldClose(window, true);
  }
  if (key == GLFW_KEY_R && action == GLFW_PRESS) {
    reset = true;
  }

  if (key == GLFW_KEY_UP && action == GLFW_PRESS) {
    if (size >= 100.0) {
      size = 100.0;
    }
    size += 1.0;
  }
  if (key == GLFW_KEY_DOWN && action == GLFW_PRESS) {
    if (size <= 1.0) {
      size = 1.0;
    }
    size -= 1.0;
  }
}

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
  glfwSetKeyCallback(window, keyCallback);
  glfwSetMouseButtonCallback(window, mouseKeyCallback);
  glfwSetScrollCallback(window, scrollCallback);

  glfwMakeContextCurrent(window);
  gladLoadGLLoader((GLADloadproc)glfwGetProcAddress);

  LOG(INFO, "Init OpenGL");

  Program prog = programLoad("vertex.glsl", "fragment.glsl");
  if (prog == 0) {
    LOG(ERROR, "programLoad error");
    glfwDestroyWindow(window);
    glfwTerminate();
    return 1;
  }

  Program circle_prog = programLoad("circle_vertex.glsl", "circle_fragment.glsl");
  if (circle_prog == 0) {
    LOG(ERROR, "cirlce programLoad error");
    glfwDestroyWindow(window);
    glfwTerminate();
    return 1;
  }

  Renderer r = rendererCreate();
  r.rect_program = prog;
  r.circle_program = circle_prog;

  mat4 ortho;
  glm_ortho(0, F32(WIDTH), F32(HEIGHT), 0, -1.0, 1.0, ortho);
  
  programUse(prog);
  programSetMat4(prog, "ortho", ortho);

  programUse(circle_prog);
  programSetMat4(circle_prog, "ortho", ortho);

  while(!glfwWindowShouldClose(window)) {
    glfwGetCursorPos(window, &x, &y);
    glClearColor(0.2, 0.3, 0.3, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);

    if (new_rect) {
      if (x > 0.0 && y > 0.0) {
        Rect *rect = make(Rect);
        *rect  = rectCreate(I32(x - size), I32(y - size), I32(size) * 2.0, I32(size) * 2.0);
        rendererAddObject(&r, rect);
      }
    }
    if (new_circle) {
      if (x > 0.0 && y > 0.0) {
        Circle *c = make(Circle);
        *c = circleCreate(F32(x), F32(y), F32(size), circle_prog);
        rendererAddObject(&r, c);
      }
    }
    if (reset) {
      rendererClear(&r);
      reset = false;
    }

    rendererDraw(&r);

    glfwSwapBuffers(window);
    glfwPollEvents();
  }
  rendererDestroy(&r);

  glfwDestroyWindow(window);
  glfwTerminate();


  LOG(INFO, "End of OpenGL");
  logCleanup();
  return 0;
}
