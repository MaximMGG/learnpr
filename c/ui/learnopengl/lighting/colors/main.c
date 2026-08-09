#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <cglm/cglm.h>
#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include "shader.h"
#include "camera.h"

#define WIDTH 1280
#define HEIGHT 720

f32 lastX = F32(WIDTH) / 2.0;
f32 lastY = F32(HEIGHT) / 2.0;
bool first_mouse = true;
Camera *c;

f32 delta_time = 0.0;
f32 last_frame = 0.0;


void processInput(GLFWwindow *window);
void framebufferCallback(GLFWwindow *window, i32 width, i32 height);
void mousePosCallback(GLFWwindow *window, f64 xpos, f64 ypos);
void scrollCallback(GLFWwindow *window, f64 xoffset, f64 yoffset);


i32 main() {
  logSetOpt(LOG_OPTION_DEF, LOG_TYPE_FILE, "gl_log.log");
  glfwInit();
  Camera tmp = cameraCreateVec((vec3){0.0, 0.0, 3.0});
  c = &tmp;

  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Colors", null, null);
  if (window == null) {
    glfwTerminate();
  }

  glfwWindowHint(GLFW_VERSION_MAJOR, 3);
  glfwWindowHint(GLFW_VERSION_MINOR, 3);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

  glfwSetFramebufferSizeCallback(window, framebufferCallback);
  glfwSetCursorPosCallback(window, mousePosCallback);
  glfwSetScrollCallback(window, scrollCallback);
  glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_NORMAL);
  
  glfwMakeContextCurrent(window);
  
  gladLoadGLLoader((GLADloadproc)glfwGetProcAddress);
  glEnable(GL_DEPTH_TEST);

  
  
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

  Program cube_shader = programCreate("vertex.glsl", "fragment.glsl");
  if (cube_shader.id == 0) {
    LOG(ERROR, "programCreate failed");
    goto EXIT_ERROR;
  }
  Program light_shader = programCreate("light_vertex.glsl", "light_fragment.glsl");
  if (light_shader.id == 0) {
    LOG(ERROR, "programCreate light shader falied");
    goto EXIT_ERROR;
  }
  
  u32 cubeVAO, lightVAO, VBO;
  glGenVertexArrays(1, &cubeVAO);
  glGenVertexArrays(1, &lightVAO);
  glGenBuffers(1, &VBO);

  glBindVertexArray(cubeVAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(f32), (void *)0);
  glEnableVertexAttribArray(0);

  glBindVertexArray(lightVAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(f32), (void *)0);
  glEnableVertexAttribArray(0);

  programUse(cube_shader);
  programSetUniformVec3(cube_shader, "objectColor", (vec3){1.0f, 0.5f, 0.31f});
  programSetUniformVec3(cube_shader, "lightColor", (vec3){1.0f, 1.0f, 1.0f});
  

  while(!glfwWindowShouldClose(window)) {

    f32 current_frame = F32(glfwGetTime());
    delta_time = current_frame - last_frame;
    last_frame = current_frame;

    processInput(window);
    
    glClearColor(0.1, 0.1, 0.1, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    

    programUse(light_shader);
    

    glfwSwapBuffers(window);
    glfwPollEvents();
  }


 EXIT_ERROR:
  glfwDestroyWindow(window);
  glfwTerminate();
  logCleanup();
  return 0;
}
