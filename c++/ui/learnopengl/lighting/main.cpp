#include <iostream>
#include "../lib/util.hpp"

void processInput(GLFWwindow *window);

#define WIDTH 1280
#define HEIGHT 720
#define APP_NAME "Lightening"

Camera camera(glm::vec3(0.0f, 0.0f, 3.0f));
f32 lastX = WIDTH / 2.0f;
f32 lastY = HEIGHT / 2.0f;
bool firstMouse = true;

f32 deltaTime = 0.0f;
f32 lastFrame = 0.0f;

glm::vec3 lightPos(1.2f, 1.0f, 2.0f);

int main() {
  WindowManager w(WIDTH, HEIGHT, APP_NAME);

  int glew_res = glewInit();
  if (glew_res != 0 && glew_res != 4) {
    std::cerr << "glewInit failed, code is: " << glew_res << "\n";
    return 1;
  }
  GLCall(glEnable(GL_DEPTH_TEST));
  Shader lightingShader("./color_vertex.glsl", "./color_fragment.glsl");
  Shader lightCubeShader("./light_cube_vertex.glsl", "./light_cube_fragment.glsl");
    
  f32 vertices[] = {
      -0.5f, -0.5f, -0.5f, 
      0.5f, -0.5f, -0.5f,  
      0.5f,  0.5f, -0.5f,  
      0.5f,  0.5f, -0.5f,  
      -0.5f,  0.5f, -0.5f, 
      -0.5f, -0.5f, -0.5f, 

      -0.5f, -0.5f,  0.5f, 
      0.5f, -0.5f,  0.5f,  
      0.5f,  0.5f,  0.5f,  
      0.5f,  0.5f,  0.5f,  
      -0.5f,  0.5f,  0.5f, 
      -0.5f, -0.5f,  0.5f, 

      -0.5f,  0.5f,  0.5f, 
      -0.5f,  0.5f, -0.5f, 
      -0.5f, -0.5f, -0.5f, 
      -0.5f, -0.5f, -0.5f, 
      -0.5f, -0.5f,  0.5f, 
      -0.5f,  0.5f,  0.5f, 

      0.5f,  0.5f,  0.5f,  
      0.5f,  0.5f, -0.5f,  
      0.5f, -0.5f, -0.5f,  
      0.5f, -0.5f, -0.5f,  
      0.5f, -0.5f,  0.5f,  
      0.5f,  0.5f,  0.5f,  

      -0.5f, -0.5f, -0.5f, 
      0.5f, -0.5f, -0.5f,  
      0.5f, -0.5f,  0.5f,  
      0.5f, -0.5f,  0.5f,  
      -0.5f, -0.5f,  0.5f, 
      -0.5f, -0.5f, -0.5f, 

      -0.5f,  0.5f, -0.5f, 
      0.5f,  0.5f, -0.5f,  
      0.5f,  0.5f,  0.5f,  
      0.5f,  0.5f,  0.5f,  
      -0.5f,  0.5f,  0.5f, 
      -0.5f,  0.5f, -0.5f,
  };

  VertexArray cubeVAO;
  cubeVAO.bind();
  BufferArray VBO(sizeof(vertices), vertices);

  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, sizeof(f32) * 3, (void *)0);
  glEnableVertexAttribArray(0);

  VertexArray lightcubeVAO;
  lightcubeVAO.bind();
  VBO.bind();
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, sizeof(f32) * 3, (void *)0);
  glEnableVertexAttribArray(0);

  while(!glfwWindowShouldClose(w.window)) {
    f32 currentFrame = static_cast<f32>(glfwGetTime());
    deltaTime = currentFrame - lastFrame;
    lastFrame = currentFrame;

    processInput(w.window);

    GLCall(glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT));

    lightingShader.use();
    lightingShader.setVec3("objectColor", glm::vec3(1.0f, 0.5f, 0.31f));
    lightingShader.setVec3("lightColor", glm::vec3(1.0f, 1.0f, 1.0f));

    glm::mat4 projection = glm::perspective(glm::radians(camera.Zoom),(f32)WIDTH / HEIGHT, 0.1f, 100.0f);
    glm::mat4 view = camera.getViewMatrix();
    lightingShader.setMat4("projection", projection);
    lightingShader.setMat4("view", view);

    glm::mat4 model = glm::mat4(1.0f);
    lightingShader.setMat4("model", model);

    cubeVAO.bind();

    GLCall(glDrawArrays(GL_TRIANGLES, 0, 36));

    lightCubeShader.use();
    lightCubeShader.setMat4("projection", projection);
    lightCubeShader.setMat4("view", view);

    model = glm::mat4(1.0f);
    model = glm::translate(model, lightPos);
    model = glm::scale(model, glm::vec3(0.2f));
    lightCubeShader.setMat4("model", model);

    lightcubeVAO.bind();
    GLCall(glDrawArrays(GL_TRIANGLES, 0, 36));

    w.process();
  }

  return 0;
}

void processInput(GLFWwindow *window) {
    if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
        glfwSetWindowShouldClose(window, true);
    }
}
