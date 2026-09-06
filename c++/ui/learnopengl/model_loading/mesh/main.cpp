#include <glad/glad.h>
#include "model.hpp"
#include "camera.hpp"
#include "shader.hpp"
#include "types.hpp"
#include <GLFW/glfw3.h>

#include <stb_image.h>

#include <iostream>
#include <vector>


#define WIDTH (1280 * 2)
#define HEIGHT (720 * 2)
Camera camera(glm::vec3(0.0, 0.0, 3.0));
f32 lastX = F32(WIDTH) / 2.0;
f32 lastY = F32(HEIGHT) / 2.0;
bool first_mouse = true;


f32 delta_time{};
f32 last_frame{};

glm::vec3 lightPos(1.2, 1.0, 2.0);
std::vector<glm::vec3> backpacks;
i32 active_texture{0};

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
  if (glfwGetKey(window, GLFW_KEY_UP)) {
    lightPos.y += 0.1;
  }
  if (glfwGetKey(window, GLFW_KEY_DOWN)) {
    lightPos.y -= 0.1;
  }
  if (glfwGetKey(window, GLFW_KEY_LEFT)) {
    lightPos.x -= 0.1;
  }
  if (glfwGetKey(window, GLFW_KEY_RIGHT)) {
    lightPos.x += 0.1;
  }
  if (glfwGetKey(window, GLFW_KEY_Q)) {
    lightPos.z -= 0.1;
  }
  if (glfwGetKey(window, GLFW_KEY_E)) {
    lightPos.z += 0.1;
  }
  if (glfwGetKey(window, GLFW_KEY_R)) {
    lightPos.x = 1.2;
    lightPos.y = 1.0;
    lightPos.z = 2.0;
  }
  if (glfwGetKey(window, GLFW_KEY_TAB)) {
    if (active_texture == backpacks.size() - 1) {
      active_texture = 0;
    } else {
      active_texture++;
    }
  }
  if (glfwGetKey(window, GLFW_KEY_N)) {
    backpacks.push_back(glm::vec3(0.0, 0.0, 0.0));
    active_texture = backpacks.size() - 1;
  }
  if (glfwGetKey(window, GLFW_KEY_J)) {
    backpacks[active_texture].y -= 0.1;
  }
  if (glfwGetKey(window, GLFW_KEY_K)) {
    backpacks[active_texture].y += 0.1;
  }
  if (glfwGetKey(window, GLFW_KEY_H)) {
    backpacks[active_texture].x -= 0.1;
  }
  if (glfwGetKey(window, GLFW_KEY_L)) {
    backpacks[active_texture].x += 0.1;
  }
  if (glfwGetKey(window, GLFW_KEY_U)) {
    backpacks[active_texture].z -= 0.1;
  }
  if (glfwGetKey(window, GLFW_KEY_O)) {
    backpacks[active_texture].z += 0.1;
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
  Shader light_s("light_vertex.glsl", "light_fragment.glsl");
  if (light_s.id == 0) {
    return 1;
  }
  Model m("./backpack.obj");

  float vertices[] = {
    // positions          // normals           // texture coords
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

  backpacks.push_back(glm::vec3(0.0, 0.0, 0.0));

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

  u32 VAO, VBO;
  glGenVertexArrays(1, &VAO);
  glGenBuffers(1, &VBO);

  glBindVertexArray(VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 8 * sizeof(f32), (void *)0);


  while(!glfwWindowShouldClose(window)) {
    f32 current_frame = F32(glfwGetTime());
    delta_time = current_frame - last_frame;
    last_frame = current_frame;

    processInput(window);

    glClearColor(0.1, 0.1, 0.1, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    s.use();

    s.setVec3("light.position", lightPos);
    s.setVec3("viewPos", camera.Position);

    s.setVec3("light.ambient", glm::vec3(0.2, 0.2, 0.2));
    s.setVec3("light.diffuse", glm::vec3(0.5, 0.5, 0.5));
    s.setVec3("light.specular", glm::vec3(1.0, 1.0, 1.0));

    s.setFloat("shininess", 32.0f);

    glm::mat4 projection = glm::perspective(glm::radians(camera.Zoom), F32(WIDTH) / F32(HEIGHT), 0.1f, 100.0f);
    glm::mat4 view = camera.getViewMatrix();

    s.setMat4("projection", projection);
    s.setMat4("view", view);


    for(u32 i = 0; i < backpacks.size(); i++) {
      glm::mat4 model = glm::mat4(1.0);
      model = glm::translate(model, backpacks[i]);
      model = glm::scale(model, glm::vec3(1.0, 1.0, 1.0));
      s.setMat4("model", model);
      m.draw(s);
      if (i == active_texture) {
        s.setInt("active_texture", 1);
      } else {
        s.setInt("active_texture", 0);
      }
    }


    light_s.use();
    light_s.setMat4("projection", projection);
    light_s.setMat4("view", view);

    glm::mat4 model = glm::mat4(1.0);
    model = glm::translate(model, lightPos);
    model = glm::scale(model, glm::vec3(0.2));

    light_s.setMat4("model", model);
    glBindVertexArray(VAO);
    glDrawArrays(GL_TRIANGLES, 0, 36);


    glfwSwapBuffers(window);
    glfwPollEvents();
  }

  glfwDestroyWindow(window);
  glfwTerminate();
  return 0;
}
