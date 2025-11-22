#include <stdio.h>
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#define STB_IMAGE_IMPLEMENTATION
#include "../lib/util.h"
#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include "camera.h"

#define WIDTH 1280
#define HEIGHT 720
#define APP_NAME "Mouse movement"


void mouse_callback(GLFWwindow *window, f64 xpos, f64 ypos);
void scroll_callback(GLFWwindow *window, f64 xoffset, f64 yoffset);
void keyprocess(GLFWwindow *window);


Camera *camera;

f32 lastX = WIDTH / 2.0f;
f32 lastY = HEIGHT / 2.0f;
bool firstMouse = true;

f32 deltaTime = 0.0f;
f32 lastFrame = 0.0f;


int main() {
  glfwInit();
  camera = cameraCreate((vec3){0.0f, 0.0f, 3.0f}, (vec3){0.0f, 1.0f, 0.0f}, YAW, PITCH);

  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, APP_NAME, null, null);

  //  glfwSetKeyCallback(window, key_callback);
  glfwSetCursorPosCallback(window, mouse_callback);
  glfwSetScrollCallback(window, scroll_callback);

  glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_DISABLED);
  
  if (window == null) {
    log(FATAL, "window is null");
    return 1;
  }

  glfwMakeContextCurrent(window);
  
  i32 glew_res = glewInit();
  printf("glew_res: %d\n", glew_res);

  if (glew_res != 0 && glew_res != 4) {
    log(FATAL, "glewInit failed");
    return 1;
  }

  GLCall(glEnable(GL_DEPTH_TEST));

  uint prog = programCreate("./vertex.glsl", "./fragment.glsl");
  uint texture = textureLoad("./crate.png");

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

  vec3 cubePositions[] = {
    { 0.0f,  0.0f,  0.0f},
    { 2.0f,  5.0f, -15.0f},
    {-1.5f, -2.2f, -2.5f},
    {-3.8f, -2.0f, -12.3f},
    { 2.4f, -0.4f, -3.5f},
    {-1.7f,  3.0f, -7.5f},
    { 1.3f, -2.0f, -2.5f},
    { 1.5f,  2.0f, -2.5f},
    { 1.5f,  0.2f, -1.5f},
    {-1.3f,  1.0f, -1.5f}
  };

  uint VAO = vertexArrayCreate();
  vertexArrayBind(VAO);
  uint VBO = arrayBufferCreate(sizeof(vertices), vertices);
  GLCall(glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, sizeof(f32) * 5, (void *)0));
  GLCall(glEnableVertexAttribArray(0));
  GLCall(glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, sizeof(f32) * 5, (void *)(sizeof(f32) * 3)));
  GLCall(glEnableVertexAttribArray(1));

  programUse(prog);
  programSetI(prog, "texture1", 0);

  while(!glfwWindowShouldClose(window)) {
    f32 currentFrame = (f32)glfwGetTime();
    deltaTime = currentFrame - lastFrame;
    lastFrame = currentFrame;

    keyprocess(window);
    
    GLCall(glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT));
    GLCall(glActiveTexture(GL_TEXTURE0));
    textureBind(texture);
    programUse(prog);

    mat4 projection = GLM_MAT4_IDENTITY_INIT;
    glm_perspective(glm_rad(camera->zoom), (f32)WIDTH / (f32)HEIGHT, 0.1f, 100.0f, projection);
    programSetMat4(prog, "projection", projection);

    mat4 view;
    void *tmp_view = cameraGetViewMatrix(camera);
    memcpy(view, tmp_view, sizeof(mat4));
    dealloc(tmp_view);
    programSetMat4(prog, "view", view);

    vertexArrayBind(VAO);
    for(u32 i = 0; i < 10; i++) {
      mat4 model = GLM_MAT4_IDENTITY_INIT;
      glm_translate(model, cubePositions[i]);
      glm_rotate(model, (f32)glfwGetTime(), (vec3){1.0f, 0.3f, 0.5f});
      programSetMat4(prog, "model", model);

      GLCall(glDrawArrays(GL_TRIANGLES, 0, 36));
    }

    glfwSwapBuffers(window);
    glfwPollEvents();
  }

  vertexArrayDestroy(&VAO);
  arrayBufferDestroy(&VBO);
  programDestroy(prog);
  textureDestroy(&texture);
  glfwDestroyWindow(window);
  glfwTerminate();
  cameraDestroy(camera);

  return 0;
}


void mouse_callback(GLFWwindow *window, f64 xposIn, f64 yposIn) {
  f32 xpos = (f32)xposIn;
  f32 ypos = (f32)yposIn;

  if (firstMouse) {
    lastX = xpos;
    lastY = ypos;
    firstMouse = false;
  }

  f32 xoffset = xpos - lastX;
  f32 yoffset = ypos - lastY;

  lastX = xpos;
  lastY = ypos;

  cameraProcessMouseMovement(camera, xoffset, yoffset, true);
  
}

void scroll_callback(GLFWwindow *window, f64 xoffset, f64 yoffset) {
  cameraProcessMouseScroll(camera, (f32)yoffset);
}

void keyprocess(GLFWwindow *window) {
  if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
    glfwSetWindowShouldClose(window, true);
  }
  if ((glfwGetKey(window, GLFW_KEY_W)) == GLFW_PRESS)
    cameraProcessKeyboard(camera, FORWARD, deltaTime);
  if ((glfwGetKey(window, GLFW_KEY_S)) == GLFW_PRESS)
    cameraProcessKeyboard(camera, BACKWARD, deltaTime);
  if ((glfwGetKey(window, GLFW_KEY_A)) == GLFW_PRESS)
    cameraProcessKeyboard(camera, LEFT, deltaTime);
  if ((glfwGetKey(window, GLFW_KEY_D)) == GLFW_PRESS)
    cameraProcessKeyboard(camera, RIGHT, deltaTime);
}
