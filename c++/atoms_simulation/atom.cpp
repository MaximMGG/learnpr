#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>
#include <vector>
#include <iostream>
#include <cmath>
#include <cstdlib>
#include <ctime>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

struct Engine {

  GLFWwindow *window;
  int WIDTH = 800, HEIGHT = 600;

  Engine() {
    if (!glfwInit()) {
      std::cerr << "Failed to init glfw\n";
      exit(1);
    }

    window = glfwCreateWindow(WIDTH, HEIGHT, "2D atom sim", nullptr, nullptr);

    if (!window) {
      std::cerr << "failed to create window\n";
      glfwTerminate();
      exit(1);
    }

    glfwMakeContextCurrent(window);
    glewInit();
  }
};

Engine engine;

struct Particle {

  glm::vec2 pos;
  int charge;
  Particle(glm::vec2 pos, int charge) : pos(pos), charge(charge){}

  void draw(int segments = 50) {

    float r;
    if (charge == -1) r = 2;
    else r = 10;

    glBegin(GL_TRIANGLE_FAN);
    glVertex2f(pos.x, pos.y);
    for(int i = 0; i < segments; i++) {
      float angle = 2.0f * M_PI * i/segments;
      float x = cos(angle) * r;
      float y = sin(angle) * r;
      glVertex2f(x + pos.x, y + pos.y);
    }
    glEnd();
  }

};

std::vector<Particle> particles = {
  Particle(glm::vec2(0.0f), 1),
  Particle(glm::vec2(-50.0f, 0.0f), -1)
};

int main() {


  while(!glfwWindowShouldClose(engine.window)) {
    glClear(GL_COLOR_BUFFER_BIT);

    for(int i = 0; i < particles.size(); i++) {
      particles[i].draw();
    }

    glfwSwapBuffers(engine.window);
    glfwPollEvents();
  }

  glfwTerminate();

  return 0;
}
