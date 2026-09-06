#include <glad/glad.h>
#include "model.hpp"
#include "camera.hpp"
#include "shader.hpp"
#include "types.hpp"
#include <GLFW/glfw3.h>

#include <iostream>


#define WIDTH 1280
#define HEIGHT 720
Camera camera(glm::vec3(0.0, 0.0, 3.0));
f32 lastX = F32(WIDTH) / 2.0;
f32 lastY = F32(HEIGHT) / 2.0;
bool first_mouse = true;


f32 delta_time{};
f32 last_frame{};



void framebuffer_callback(GLFWwindow *window, i32 width, i32 height) {
  glViewport(0, 0, width, height);
}

void mousepos_callback(GLFWwindow *window, f64 xposIn, f64 yposIn) {
  f32 xpos = F32(xposIn);
  f32 ypos = F32(yposIn);

  if (first_mouse) {
    lastX = xpos;
    lastY = ypos;
    first_mouse = false;
  }

  f32 xoffset = xpos - lastX;
  f32 yoffset = lastY - ypos;

  lastX = xpos;
  lastY = ypos;

  camera.processMouseMovenet(xoffset, yoffset);
}

void scroll_callback(GLFWwindow *window, f64 xoffset, f64 yoffset) {
  camera.processMouseScroll(F32(yoffset));
}

void processInput(GLFWwindow *window) {
  if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
    glfwSetWindowShouldClose(window, true);
  }
  if (glfwGetKey(window, GLFW_KEY_W)) {
    camera.processKeyboard(FORWARD, delta_time);
  }
  if (glfwGetKey(window, GLFW_KEY_S)) {
    camera.processKeyboard(BACKWARD, delta_time);
  }
  if (glfwGetKey(window, GLFW_KEY_A)) {
    camera.processKeyboard(LEFT, delta_time);
  }
  if (glfwGetKey(window, GLFW_KEY_D)) {
    camera.processKeyboard(RIGHT, delta_time);
  }
}


i32 main() {

  glfwInit();

  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Model", NULL, NULL);

  if (window == NULL) {
    std::cerr << "glfwCreateWindow error\n";
    glfwTerminate();
    return 1;
  }

  glfwWindowHint(GLFW_VERSION_MAJOR, 3);
  glfwWindowHint(GLFW_VERSION_MINOR, 3);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

  glfwMakeContextCurrent(window);

  glfwSetFramebufferSizeCallback(window, framebuffer_callback);
  glfwSetCursorPosCallback(window, mousepos_callback);
  glfwSetScrollCallback(window, scroll_callback);

  glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_NORMAL);
  
  gladLoadGLLoader((GLADloadproc)glfwGetProcAddress);

  stbi_set_flip_vertically_on_load(true);
  glEnable(GL_DEPTH_TEST);

  Shader s("vertex.glsl", "fragment.glsl");
  if (s.id == 0) {
    return 1;
  }
  Model m("./backpack.obj");


  while(!glfwWindowShouldClose(window)) {
    f32 current_frame = F32(glfwGetTime());
    delta_time = current_frame - last_frame;
    last_frame = current_frame;

    processInput(window);

    glClearColor(0.1, 0.1, 0.1, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    s.use();

    glm::mat4 projection = glm::perspective(glm::radians(camera.Zoom), F32(WIDTH) / F32(HEIGHT), 0.1f, 100.0f);
    glm::mat4 view = camera.getViewMatrix();

    s.setMat4("projection", projection);
    s.setMat4("view", view);

    glm::mat4 model = glm::mat4(1.0);
    model = glm::translate(model, glm::vec3(0.0, 0.0, 0.0));
    model = glm::scale(model, glm::vec3(1.0, 1.0, 1.0));
    s.setMat4("model", model);
    m.draw(s);

    glfwSwapBuffers(window);
    glfwPollEvents();
  }

  glfwDestroyWindow(window);
  glfwTerminate();
  return 0;
}
