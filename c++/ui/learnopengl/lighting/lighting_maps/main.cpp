#include <iostream>
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include "../../lib/util.hpp"
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#define STB_IMAGE_IMPLEMENTATION
#include <stb/stb_image.h>



#define WIDTH 1920
#define HEIGHT 1024

Camera camera({0.0, 0.0, 3.0});

bool firstMove = true;
f32 lastX{(f32)WIDTH / 2.0};
f32 lastY{(f32)HEIGHT / 2.0};

f32 deltaTime{};
f32 lastFrame{};

void mouse_callback(GLFWwindow *window, f64 xpos, f64 ypos);
void scroll_callback(GLFWwindow *winodw, f64 xoffset, f64 yoffset);
void processInput(GLFWwindow *window);
u32 loadTexture(const char *path);


glm::vec3 lightPos(1.2f, 1.0f, 2.0f);


int main() {
  std::cout << "Init glfw\n";
  WindowManager win(WIDTH, HEIGHT, "light map");

  win.setCallbacks(mouse_callback, scroll_callback);

  Shader cubeShader("./cubeVertex.glsl", "./cubeFragment.glsl");
  if (cubeShader.id == 0) {
    std::cerr << "Compile cube shader error\n";
    return 1;
  }
  Shader lightShader("./lightVertex.glsl", "./lightFragment.glsl");
  if (lightShader.id == 0) {
    std::cerr << "Compile light shader error\n";
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

  VertexArray cubeVAO;
  BufferArray VBO(sizeof(vertices), vertices);
  cubeVAO.addf32(3);
  cubeVAO.addf32(3);
  cubeVAO.addf32(2);
  cubeVAO.process();

  VertexArray lightVAO;
  lightVAO.addf32(3);
  lightVAO.setStride(sizeof(f32) * 8);
  lightVAO.process();

  u32 diffuseMap = loadTexture("container2.png");
  u32 specularMap = loadTexture("container2_specular.png");

  cubeShader.use();
  cubeShader.setInt("material.diffuse", 0);
  cubeShader.setInt("material.specular", 1);


  while(!glfwWindowShouldClose(win.window)) {
    f32 time = f32(glfwGetTime());
    f32 currentFrame = time;
    deltaTime = lastFrame - currentFrame;
    lastFrame = currentFrame;

    processInput(win.window);
    
    glClearColor(0.1, 0.1, 0.1, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    cubeShader.use();
    cubeShader.setVec3("light.position", lightPos);
    cubeShader.setVec3("viewPos", camera.Position);

    cubeShader.setVec3("light.ambient", 0.2, 0.2, 0.2);
    cubeShader.setVec3("light.diffuse", 0.5, 0.5, 0.5);
    cubeShader.setVec3("light.specular", 1.0, 1.0, 1.0);

    cubeShader.setFloat("material.shininess", 64.0);

    glm::mat4 projection = glm::perspective(glm::radians(f32(camera.Zoom)), f32(WIDTH) / f32(HEIGHT), 0.1f, 100.0f);
    glm::mat4 view = camera.getViewMatrix();
    cubeShader.setMat4("projection", projection);
    cubeShader.setMat4("view", view);

    glm::mat4 model(1.0f);
    cubeShader.setMat4("model", model);

    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, diffuseMap);

    glActiveTexture(GL_TEXTURE1);
    glBindTexture(GL_TEXTURE_2D, specularMap);

    cubeVAO.bind();
    glDrawArrays(GL_TRIANGLES, 0, 36);

    lightShader.use();
    lightShader.setMat4("projection", projection);
    lightShader.setMat4("view", view);
    model = glm::mat4(1.0f);
    model = glm::translate(model, lightPos);
    model = glm::scale(model, glm::vec3(0.2f));
    lightShader.setMat4("model", model);

    lightVAO.bind();
    glDrawArrays(GL_TRIANGLES, 0, 36);

    win.process();
  }

  return 0;
}

void mouse_callback(GLFWwindow *window, f64 _xpos, f64 _ypos) {
  f32 xpos = (f32)_xpos;
  f32 ypos = (f32)_ypos;
  if (firstMove) {
    lastX = xpos;
    lastY = ypos;
    firstMove = false;
  }

  f32 xoffset = xpos - lastX;
  f32 yoffset = lastY - ypos;

  lastX = xpos;
  lastY = ypos;
  camera.processMouseMovement(xoffset, yoffset);
}

void scroll_callback(GLFWwindow *winodw, f64 xoffset, f64 yoffset) {
  camera.processMouseScroll((f32)yoffset);
}

void processInput(GLFWwindow *window) {
  if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
    glfwSetWindowShouldClose(window, true);
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

u32 loadTexture(const char *path) {

  u32 tex;
  glGenTextures(1, &tex);
  glBindTexture(GL_TEXTURE_2D, tex);


  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);


  i32 width, height, nrChannels;

  u8 *data = stbi_load(path, &width, &height, &nrChannels, 0);
  if (data) {
    i32 format;
    if (nrChannels == 1) {
      format = GL_RED;
    } else if(nrChannels == 3) {
      format = GL_RGB;
    } else if (nrChannels == 4) {
      format = GL_RGBA;
    }

    glTexImage2D(GL_TEXTURE_2D, 0, format, width, height, 0, format, GL_UNSIGNED_BYTE, data);
    glGenerateMipmap(GL_TEXTURE_2D);

    stbi_image_free(data);

  } else {
    std::cerr << "stbi_load error\n";
    exit(1);
  }

  return tex;
}
