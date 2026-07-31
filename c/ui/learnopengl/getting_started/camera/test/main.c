#include "../shader.h"
#include <cstdext/core.h>
#include "../texture.h"
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <cstdext/io/logger.h>

#define WIDTH 1280
#define HEIGHT 720

void framebufferCallback(GLFWwindow *window, i32 width, i32 height);
void mouseposCallback(GLFWwindow *window, f64 xpos, f64 ypos);
void scrollCallback(GLFWwindow *window, f64 xoffset, f64 yoffset);
void processInput(GLFWwindow *window);


i32 main() {
  logSetOpt(DEF_OPTION, LOG_TYPE_FILE, "log_gl.log");
  glfwInit();
  log(INFO, "initGlfw");

  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Camera", null, null);
  if (window == null) {
    log(ERROR, "glfwCreateWindow error");
    glfwTerminate();
    return 1;
  }

  glfwWindowHint(GLFW_VERSION_MAJOR, 3);
  glfwWindowHint(GLFW_VERSION_MINOR, 3);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
  glfwMakeContextCurrent(window);

  glfwSetFramebufferSizeCallback(window, framebufferCallback);
  // glfwSetCursorPosCallback(window, mouseposCallback);
  // glfwSetScrollCallback(window, scrollCallback);
  //glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_DISABLED);

  if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
    log(ERROR, "gladLoadGLLoader error");
    return 1;
  }
  glEnable(GL_DEPTH_TEST);

  Shader program = shaderCreateProgram("vertex.glsl", "fragment.glsl");
  if (program == 0) {
    log(ERROR, "shaderCreateProgram error");
    glfwDestroyWindow(window);
    glfwTerminate();
    return 1;
  }

  log(INFO, "Create and compile shaders");

  Texture t1 = textureCreateJpg("container.jpg");
  if (t1 == 0) {
    log(ERROR, "textureCreateJpg error");
    glfwDestroyWindow(window);
    glfwTerminate();
    return 1;
  }
  Texture t2 = textureCreatePng("awesomeface.png");
  if (t2 == 0) {
    log(ERROR, "textureCreatePng error");
    glfwDestroyWindow(window);
    glfwTerminate();
    return 1;
  }

  log(INFO, "Create textures");

  f32 vertices[] = {
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

  // vec3 cubePositions[] = {
  //       { 0.0f,  0.0f,  0.0f},
  //       { 2.0f,  5.0f, -15.0f},
  //       {-1.5f, -2.2f, -2.5f},
  //       {-3.8f, -2.0f, -12.3f},
  //       { 2.4f, -0.4f, -3.5f},
  //       {-1.7f,  3.0f, -7.5f},
  //       { 1.3f, -2.0f, -2.5f},
  //       { 1.5f,  2.0f, -2.5f},
  //       { 1.5f,  0.2f, -1.5f},
  //       {-1.3f,  1.0f, -1.5}
  // };

  u32 VAO, VBO;
  glGenVertexArrays(1, &VAO);
  glGenBuffers(1, &VBO);
  glBindVertexArray(VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 5 * sizeof(f32), (void *)0);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 5 * sizeof(f32), (void *)(3 * sizeof(f32)));
  glEnableVertexAttribArray(1);

  shaderUse(program);
  shaderUniformInt(program, "texture1", 0);
  shaderUniformInt(program, "texture2", 1);

  log(INFO, "Start main loop");
  while(!glfwWindowShouldClose(window)) {

    processInput(window);
    glClearColor(0.2, 0.3, 0.3, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, t1);
    glActiveTexture(GL_TEXTURE1);
    glBindTexture(GL_TEXTURE_2D, t2);

    shaderUse(program);

    mat4 model = GLM_MAT4_IDENTITY_INIT;
    mat4 view = GLM_MAT4_IDENTITY_INIT;
    mat4 projection = GLM_MAT4_IDENTITY_INIT;

    glm_rotate(model, cast(f32, glfwGetTime()), (vec3){0.5f, 1.0f, 0.0f});
    glm_translate(view, (vec3){0.0f, 0.0f, -3.0f});
    glm_perspective(glm_rad(45.0f), cast(f32, WIDTH) / cast(f32, HEIGHT), 0.1f, 100.f, projection);
    shaderUniformMat4(program, "model", model);
    shaderUniformMat4(program, "view", view);
    shaderUniformMat4(program, "projection", projection);

    glBindVertexArray(VAO);
    glDrawArrays(GL_TRIANGLES, 0, 36);

    glfwSwapBuffers(window);
    glfwPollEvents();
  }

  shaderDestroy(program);
  textureDestroy(t1);
  textureDestroy(t2);
  glDeleteBuffers(1, &VBO);
  glDeleteVertexArrays(1, &VAO);

  glfwDestroyWindow(window);
  glfwTerminate();

  log(INFO, "End");
  return 0;
}

void framebufferCallback(GLFWwindow *window, i32 width, i32 height) {
  glViewport(0, 0, width, height);
}

void processInput(GLFWwindow *window) {
  if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
    glfwSetWindowShouldClose(window, true);
  }
}
