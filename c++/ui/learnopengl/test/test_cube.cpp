#include <iostream>
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include "../lib/util.hpp"
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>

#define WIDTH 1920
#define HEIGHT 1024


Camera camera(glm::vec3(0.0f, 0.0f, 3.0f));
f32 lastX = f32(WIDTH) / 2.0f;
f32 lastY = f32(HEIGHT) / 2.0f;
bool firstMouse = true;


f32 deltaTime = 0.0f;
f32 lastFrame = 0.0f;

void frameBufferSizeCallback(GLFWwindow *window, int width, int height);
void mouse_callback(GLFWwindow *window, f64 _xpos, f64 _ypos);
void scroll_callback(GLFWwindow *window, f64 xoffset, f64 yoffset);
void processInput(GLFWwindow *window) {
  if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
    glfwSetWindowShouldClose(window, 1);
  }
  if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS) {
    camera.processKeyboard(FORWARD, deltaTime);
  }
  if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS) {
    camera.processKeyboard(BACKWARD, deltaTime);
  }
  if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS) {
    camera.processKeyboard(RIGHT, deltaTime);
  }
  if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS) {
    camera.processKeyboard(LEFT, deltaTime);
  }
}

u32 load_texture(const char *path);

int main() {
  glfwInit();
  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "test window", nullptr, nullptr);
  if (window == nullptr) {
    std::cerr << "glfwCreateWindow error\n";
    glfwTerminate();
    return 1;
  }

  glfwMakeContextCurrent(window);
  glfwSetFramebufferSizeCallback(window, frameBufferSizeCallback);
  glfwSetCursorPosCallback(window, mouse_callback);
  glfwSetScrollCallback(window, scroll_callback);
  glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_DISABLED);

  glewInit();

  glEnable(GL_DEPTH_TEST);
  Shader shader("./vertex.glsl", "./fragment.glsl");
  if (shader.id == 0) {
    std::cerr << "Compile shader error\n";
    glfwDestroyWindow(window);
    glfwTerminate();
  }

  float vertices[] = {
    -0.5f, -0.5f, -0.5f,  0.0f, 0.0f,
    0.5f, -0.5f, -0.5f,  1.0f, 0.0f,
    0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
    0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
    -0.5f,  0.5f, -0.5f,  0.0f, 1.0f,
    -0.5f, -0.5f, -0.5f,  0.0f, 0.0f,

    -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
    0.5f, -0.5f,  0.5f,  1.0f, 0.0f,
    0.5f,  0.5f,  0.5f,  1.0f, 1.0f,
    0.5f,  0.5f,  0.5f,  1.0f, 1.0f,
    -0.5f,  0.5f,  0.5f,  0.0f, 1.0f,
    -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,

    -0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
    -0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
    -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
    -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
    -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
    -0.5f,  0.5f,  0.5f,  1.0f, 0.0f,

    0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
    0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
    0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
    0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
    0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
    0.5f,  0.5f,  0.5f,  1.0f, 0.0f,

    -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
    0.5f, -0.5f, -0.5f,  1.0f, 1.0f,
    0.5f, -0.5f,  0.5f,  1.0f, 0.0f,
    0.5f, -0.5f,  0.5f,  1.0f, 0.0f,
    -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
    -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,

    -0.5f,  0.5f, -0.5f,  0.0f, 1.0f,
    0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
    0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
    0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
    -0.5f,  0.5f,  0.5f,  0.0f, 0.0f,
    -0.5f,  0.5f, -0.5f,  0.0f, 1.0f
  };


  glm::vec3 cubePositions[] = {
    glm::vec3( 0.0f,  0.0f,  0.0f),
    glm::vec3( 2.0f,  5.0f, -15.0f),
    glm::vec3(-1.5f, -2.2f, -2.5f),
    glm::vec3(-3.8f, -2.0f, -12.3f),
    glm::vec3( 2.4f, -0.4f, -3.5f),
    glm::vec3(-1.7f,  3.0f, -7.5f),
    glm::vec3( 1.3f, -2.0f, -2.5f),
    glm::vec3( 1.5f,  2.0f, -2.5f),
    glm::vec3( 1.5f,  0.2f, -1.5f),
    glm::vec3(-1.3f,  1.0f, -1.5f)
  };


  unsigned int VAO, VBO;

  GLCall(glGenVertexArrays(1, &VAO));
  GLCall(glBindVertexArray(VAO));

  GLCall(glGenBuffers(1, &VBO));
  GLCall(glBindBuffer(GL_ARRAY_BUFFER, VBO));
  GLCall(glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW));

  GLCall(glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 5 * sizeof(f32), (void *)0));
  GLCall(glEnableVertexAttribArray(0));
  GLCall(glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 5 * sizeof(f32), (void *)(sizeof(f32) * 3)));
  GLCall(glEnableVertexAttribArray(1));


  u32 tex = load_texture("container2.png");
  if (tex == 0) {
    std::cerr << "load_texture error";
    return 1;
  }

  shader.use();
  shader.setInt("texture1", 0);

  while(!glfwWindowShouldClose(window)) {

    f32 currentFrame = f32(glfwGetTime());
    deltaTime = currentFrame = lastFrame;
    lastFrame = currentFrame;

    GLCall(glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT));

    processInput(window);

    shader.use();
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, tex);

    glm::mat4 projection(1.0f);
    glm::mat4 view(1.0f);
    projection = glm::perspective(glm::radians(45.0f), f32(WIDTH) / f32(HEIGHT), 0.1f, 100.0f);
    view = glm::translate(view, glm::vec3(0.0f, 0.0f, -3.0f));
    shader.setMat4("projection", projection);
    shader.setMat4("view", view);

    GLCall(glBindVertexArray(VAO));
    for(i32 i = 0; i < 10; i++) {
      glm::mat4 model(1.0f);
      model = glm::translate(model, cubePositions[i]);
      model = glm::rotate(model, f32(glfwGetTime()), glm::vec3(0.5f, 1.0f, 0.0f));

      shader.setMat4("model", model);
      glDrawArrays(GL_TRIANGLES, 0, 36);
    }

    glfwSwapBuffers(window);
    glfwPollEvents();
  }

  glDeleteVertexArrays(1, &VAO);
  glDeleteBuffers(1, &VBO);
  glDeleteTextures(1, &tex);

  return 0;
}

void frameBufferSizeCallback(GLFWwindow *window, int width, int height) {
  glViewport(0, 0, width, height);
}

u32 load_texture(const char *path) {
  u32 tex;
  glGenTextures(1, &tex);
  glBindTexture(GL_TEXTURE_2D, tex);

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

  i32 width, height, nrChannels;
  u8 *data = stbi_load(path, &width, &height, &nrChannels, 0);
  if (data) {
    i32 format = nrChannels == 3 ? GL_RGB : nrChannels == 4 ? GL_RGBA : GL_RED;
    glTexImage2D(GL_TEXTURE_2D, 0, format, width, height, 0, format, GL_UNSIGNED_BYTE, data);
    glGenerateMipmap(GL_TEXTURE_2D);
    stbi_image_free(data);
  } else {
    glDeleteTextures(1, &tex);
    return 0;
  }

  return tex;
}

void mouse_callback(GLFWwindow *window, f64 _xpos, f64 _ypos) {
  f32 xpos = f32(_xpos);
  f32 ypos = f32(_ypos);

  if (firstMouse) {
    lastX = xpos;
    lastY = ypos;
    firstMouse = false;
  }

  f32 xoffset = xpos - lastX;
  f32 yoffset = lastY - ypos;

  lastX = xpos;
  lastY = ypos;

  camera.processMouseMovement(xoffset, yoffset);
}

void scroll_callback(GLFWwindow *window, f64 xoffset, f64 yoffset) {
  camera.processMouseScroll(f32(yoffset));
}
