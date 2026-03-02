#include <iostream>
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#define STB_IMAGE_IMPLEMENTATION
#include <stb_image.h>
#include "camera.hpp"
#include "../../../lib/types.hpp"


#define WIDTH 1920
#define HEIGHT 1024



f32 deltaTime;
f32 lastFrame;
Camera camera(glm::vec3(0.0f, 0.0f, 3.0f));



void mouse_callback(GLFWwindow *window, f64 xpos, f64 ypos);
void scroll_callback(GLFWwindow *window, f64 xoffset, f64 yoffset);
void processInput(GLFWwindow *window);
u32 load_shader(const char *vertex, const char *fragment);
void set_mat4(u32 shader, const char *name, glm::mat4 &val);
void set_vec3(u32 shader, const char *name, glm::vec3 val);
void set_int(u32 shader, const char *name, i32 val);
void set_float(u32 shader, const char *name, f32 val);
u32 load_texture(const char *path);


glm::vec3 lightPos(0.0f, 0.0f, 0.3f);

int main() {

  std::cout << "Init glfw\n";

  glfwInit();
  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "test window", nullptr, nullptr);
  if (window == NULL) {
    std::cerr << "glfwCreateWindow error\n";
    return 1;
  }

  glfwMakeContextCurrent(window);
  glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_DISABLED);
  glfwSetCursorPosCallback(window, mouse_callback);
  glfwSetScrollCallback(window, scroll_callback);


  i32 res = glewInit();
  if (res != 0 && res != 4) {
    std::cerr << "glewInit error\n";
    glfwDestroyWindow(window);
    glfwTerminate();
    return 1;
  }

  glEnable(GL_DEPTH_TEST);


  u32 cubeShader = load_shader("./cubeVertex.glsl", "cubeFragment.glsl");
  if (cubeShader == 0) {
    std::cerr << "Error while load cube shader\n";
    glfwDestroyWindow(window);
    glfwTerminate();
    return 1;
  }
  u32 lightShader = load_shader("./lightVertex.glsl", "lightFragment.glsl");
  if (lightShader == 0) {
    std::cerr << "Error while load light shader\n";
    glfwDestroyWindow(window);
    glfwTerminate();
    return 1;
  }

  f32 vertices[] = {
    -0.5f, -0.5f, -0.5f,  0.0f,  0.0f, -1.0f,  0.0f,  0.0f,
     0.5f, -0.5f, -0.5f,  0.0f,  0.0f, -1.0f,  1.0f,  0.0f,
     0.5f,  0.5f, -0.5f,  0.0f,  0.0f, -1.0f,  1.0f,  1.0f,
     0.5f,  0.5f, -0.5f,  0.0f,  0.0f, -1.0f,  1.0f,  1.0f,
    -0.5f,  0.5f, -0.5f,  0.0f,  0.0f, -1.0f,  0.0f,  1.0f,
    -0.5f, -0.5f, -0.5f,  0.0f,  0.0f, -1.0f,  0.0f,  0.0f,

    -0.5f, -0.5f,  0.5f,  0.0f,  0.0f,  1.0f,  0.0f,  0.0f,
     0.5f, -0.5f,  0.5f,  0.0f,  0.0f,  1.0f,  1.0f,  0.0f,
     0.5f,  0.5f,  0.5f,  0.0f,  0.0f,  1.0f,  1.0f,  1.0f,
     0.5f,  0.5f,  0.5f,  0.0f,  0.0f,  1.0f,  1.0f,  1.0f,
    -0.5f,  0.5f,  0.5f,  0.0f,  0.0f,  1.0f,  0.0f,  1.0f,
    -0.5f, -0.5f,  0.5f,  0.0f,  0.0f,  1.0f,  0.0f,  0.0f,

    -0.5f,  0.5f,  0.5f, -1.0f,  0.0f,  0.0f,  1.0f,  0.0f,
    -0.5f,  0.5f, -0.5f, -1.0f,  0.0f,  0.0f,  1.0f,  1.0f,
    -0.5f, -0.5f, -0.5f, -1.0f,  0.0f,  0.0f,  0.0f,  1.0f,
    -0.5f, -0.5f, -0.5f, -1.0f,  0.0f,  0.0f,  0.0f,  1.0f,
    -0.5f, -0.5f,  0.5f, -1.0f,  0.0f,  0.0f,  0.0f,  0.0f,
    -0.5f,  0.5f,  0.5f, -1.0f,  0.0f,  0.0f,  1.0f,  0.0f,

     0.5f,  0.5f,  0.5f,  1.0f,  0.0f,  0.0f,  1.0f,  0.0f,
     0.5f,  0.5f, -0.5f,  1.0f,  0.0f,  0.0f,  1.0f,  1.0f,
     0.5f, -0.5f, -0.5f,  1.0f,  0.0f,  0.0f,  0.0f,  1.0f,
     0.5f, -0.5f, -0.5f,  1.0f,  0.0f,  0.0f,  0.0f,  1.0f,
     0.5f, -0.5f,  0.5f,  1.0f,  0.0f,  0.0f,  0.0f,  0.0f,
     0.5f,  0.5f,  0.5f,  1.0f,  0.0f,  0.0f,  1.0f,  0.0f,

    -0.5f, -0.5f, -0.5f,  0.0f, -1.0f,  0.0f,  0.0f,  1.0f,
     0.5f, -0.5f, -0.5f,  0.0f, -1.0f,  0.0f,  1.0f,  1.0f,
     0.5f, -0.5f,  0.5f,  0.0f, -1.0f,  0.0f,  1.0f,  0.0f,
     0.5f, -0.5f,  0.5f,  0.0f, -1.0f,  0.0f,  1.0f,  0.0f,
    -0.5f, -0.5f,  0.5f,  0.0f, -1.0f,  0.0f,  0.0f,  0.0f,
    -0.5f, -0.5f, -0.5f,  0.0f, -1.0f,  0.0f,  0.0f,  1.0f,

    -0.5f,  0.5f, -0.5f,  0.0f,  1.0f,  0.0f,  0.0f,  1.0f,
     0.5f,  0.5f, -0.5f,  0.0f,  1.0f,  0.0f,  1.0f,  1.0f,
     0.5f,  0.5f,  0.5f,  0.0f,  1.0f,  0.0f,  1.0f,  0.0f,
     0.5f,  0.5f,  0.5f,  0.0f,  1.0f,  0.0f,  1.0f,  0.0f,
    -0.5f,  0.5f,  0.5f,  0.0f,  1.0f,  0.0f,  0.0f,  0.0f,
    -0.5f,  0.5f, -0.5f,  0.0f,  1.0f,  0.0f,  0.0f,  1.0f
  };

  u32 VBO, cubeVAO;
  glGenVertexArrays(1, &cubeVAO);
  glGenBuffers(1, &VBO);
  glBindVertexArray(cubeVAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);


  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 8 * sizeof(f32), (void *)0);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 8 * sizeof(f32), (void *)(3 * sizeof(f32)));
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 8 * sizeof(f32), (void *)(6 * sizeof(f32)));
  glEnableVertexAttribArray(2);

  u32 lightVAO;
  glGenVertexArrays(1, &lightVAO);
  glBindVertexArray(lightVAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBO);

  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 8 * sizeof(f32), (void *)0);
  glEnableVertexAttribArray(0);


  u32 diffuseTex = load_texture("container2.png");
  u32 specularTex = load_texture("container2_specular.png");

  glUseProgram(cubeVAO);
  set_int(lightShader, "material.diffuse", 0);
  set_int(lightShader, "material.specular", 1);


  while(!glfwWindowShouldClose(window)) {
    f32 time = f32(glfwGetTime());
    f32 currentFrame = time;
    deltaTime = lastFrame - currentFrame;
    lastFrame = currentFrame;

    processInput(window);

    glClearColor(0.1, 0.1, 0.1, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glUseProgram(cubeShader);
    set_vec3(cubeShader, "light.position", lightPos);
    set_vec3(cubeShader, "viewPos", camera.Position);

    set_vec3(cubeShader, "light.ambient", glm::vec3(0.2f, 0.2f, 0.2f));
    set_vec3(cubeShader, "light.diffuse", glm::vec3(0.5f, 0.5f, 0.5f));
    set_vec3(cubeShader, "light.specular", glm::vec3(1.0f, 1.0f, 1.0f));

    set_float(cubeShader, "material.shininess", 64.0f);

    glm::mat4 projection = glm::perspective(f32(glm::radians(camera.Zoom)), (f32(WIDTH) / f32(HEIGHT)), 0.1f, 100.0f);
    glm::mat4 view = camera.getViewMatrix();
    set_mat4(cubeShader, "projection", projection);
    set_mat4(cubeShader, "view", view);

    glm::mat4 model(1.0f);
    set_mat4(cubeShader, "model", model);

    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, diffuseTex);

    glActiveTexture(GL_TEXTURE1);
    glBindTexture(GL_TEXTURE_2D, specularTex);

    glBindVertexArray(cubeVAO);
    glDrawArrays(GL_TRIANGLES, 0, 36);

    glUseProgram(lightShader);
    set_mat4(lightShader, "projection", projection);
    set_mat4(lightShader, "view", view);
    model = glm::mat4(1.0f);
    model = glm::translate(model, lightPos);
    model = glm::scale(model, glm::vec3(0.2f));

    set_mat4(lightShader, "model", model);

    glBindVertexArray(lightVAO);
    glDrawArrays(GL_TRIANGLES, 0, 36);

    glfwSwapBuffers(window);
    glfwPollEvents();
  }



  return 0;
}
