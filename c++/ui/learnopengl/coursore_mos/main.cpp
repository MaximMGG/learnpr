#include <iostream>
#include "shader.hpp"
#include "window_manager.hpp"
#include "vertexArray.hpp"
#include "bufferArray.hpp"
#include "texture.hpp"
#include "camera.hpp"

void mouse_callback(GLFWwindow *window, double xposIn, double yposIn);
void scroll_callback(GLFWwindow *window, double xoffset, double yoffset);



#define WIDTH 1280
#define HEIGHT 720

Camera camera(glm::vec3{0.0f, 0.0f, 3.0f});
float lastX = WIDTH / 2.0f;
float lastY = HEIGHT / 2.0f;
bool firstMouse = true;

float deltaTime = 0.0f;
float lastFrame = 0.0f;

int main() {
    WindowManager w(WIDTH, HEIGHT, "MOUSE");
    w.setCallbacks(mouse_callback, scroll_callback);

    int glew_res = glewInit();

    if (glew_res != 0 && glew_res != 4) {
        std::cerr << "glewInit failed\n";
        exit(1);
    }

    glEnable(GL_DEPTH_TEST);

    Shader prog("./vertex.glsl", "./fragment.glsl");

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
    VertexArray VAO;
    VAO.bind();
    BufferArray VBO(sizeof(vertices), vertices);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, sizeof(float) * 5, (void *)0);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, sizeof(float) * 5, (void *)(sizeof(float) * 3));
    glEnableVertexAttribArray(1);

    Texture texture("./crate.png");

    prog.use();
    prog.setInt("texture1", 0);

    while(!glfwWindowShouldClose(w.window)) {

      float currentFrame = static_cast<float>(glfwGetTime());
      deltaTime = currentFrame - lastFrame;
      lastFrame = currentFrame;
      
      glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
      glActiveTexture(GL_TEXTURE0);
      texture.bind();

      prog.use();

      glm::mat4 projection = glm::perspective(glm::radians(camera.Zoom), (float)WIDTH / (float)HEIGHT, 0.1f, 100.0f);
      prog.setMat4("projection", projection);

      glm::mat4 view = camera.getViewMatrix();
      prog.setMat4("view", view);

      VAO.bind();

      for(unsigned int i = 0; i < 10; i++) {
	glm::mat4 model = glm::mat4(1.0f);
	model = glm::translate(model, cubePositions[i]);
	model = glm::rotate(model, (float)glfwGetTime(), glm::vec3{1.0f, 0.3f, 0.5f});
	prog.setMat4("model", model);

	glDrawArrays(GL_TRIANGLES, 0, 36);
      }

      w.process();
    }

    return 0;
}


void mouse_callback(GLFWwindow *window, double xposIn, double yposIn) {
  float xpos = static_cast<float>(xposIn);
  float ypos = static_cast<float>(yposIn);

  if (firstMouse) {
    lastX = xpos;
    lastY = ypos;
    firstMouse = false;
  }

  float xoffset = xpos - lastX;
  float yoffset = lastY - ypos;

  lastX = xpos;
  lastY = ypos;

  camera.processMouseMovement(xoffset, yoffset);
}
void scroll_callback(GLFWwindow *window, double xoffset, double yoffset) {
  camera.processMouseScroll(static_cast<float>(yoffset));
}
