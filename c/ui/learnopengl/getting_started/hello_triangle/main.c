#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <glad/glad.h>
#include <GLFW/glfw3.h>


#define WIDTH 640
#define HEIGHT 480


const i8 *vertexShaderSouce = "#version 330 core\n"
"layout (location = 0) in vec3 aPos;\n"
"\n"
"void main() {\n"
"  gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0f);\n"
"}\n";

const i8 *fragmentShaderSource = "#version 330 core\n"
"out vec4 FragColor;\n"
"\n"
"void main() {\n"
"  FragColor = vec4(1.0f, 0.5f, 0.2f, 1.0f);\n"
"}\n";


void framebuffer_callback(GLFWwindow *window, i32 width, i32 height) {
  glViewport(0, 0, width, height);
  glViewport(0, 0, width, height);
}
void processInput(GLFWwindow *window) {
  if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
    glfwSetWindowShouldClose(window, true);
  }
}


i32 main() {

  if (!glfwInit()) {
    log(ERROR, "glfwInit error");
    return 1;
  }



  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Triangle", null, null);
  if (window == null) {
    log(ERROR, "glfwCreateWindow error");
    return 1;
  }
  glfwWindowHint(GLFW_VERSION_MAJOR, 3);
  glfwWindowHint(GLFW_VERSION_MINOR, 3);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

  glfwMakeContextCurrent(window);
  glfwSetFramebufferSizeCallback(window, framebuffer_callback);

  gladLoadGLLoader((GLADloadproc)glfwGetProcAddress);

  u32 vertexShader = glCreateShader(GL_VERTEX_SHADER);
  glShaderSource(vertexShader, 1, &vertexShaderSouce, null);
  glCompileShader(vertexShader);

  i32 success;
  byte info_log[512] = {0};
  glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &success);
  if (success == GL_FALSE) {
    glGetShaderInfoLog(vertexShader, 512, null, info_log);
    log(ERROR, "Compile vertex shader error %s", info_log);
    return 1;
  }

  u32 fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
  glShaderSource(fragmentShader, 1, &fragmentShaderSource, null);
  glCompileShader(fragmentShader);

  memset(info_log, 0, 512);
  glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, &success);
  if (success == GL_FALSE) {
    glGetShaderInfoLog(fragmentShader, 512, null, info_log);
    log(ERROR, "Compile fragment shader error %s", info_log);
    return 1;
  }

  u32 shaderProgram = glCreateProgram();
  glAttachShader(shaderProgram, vertexShader);
  glAttachShader(shaderProgram, fragmentShader);

  glLinkProgram(shaderProgram);

  glDeleteShader(vertexShader);
  glDeleteShader(fragmentShader);

  memset(info_log, 0, 512);

  glGetProgramiv(shaderProgram, GL_LINK_STATUS, &success);
  if (success == GL_FALSE) {
    glGetProgramInfoLog(shaderProgram, 512, null, info_log);
    log(ERROR, "Link program failed %s", info_log);
    return 1;
  }

  f32 vertices[] = {
    -0.5f, -0.5f, 0.0f,
     0.5f, -0.5f, 0.0f,
     0.0f,  0.5f, 0.0f
  };

  u32 VBO, VAO;
  glGenVertexArrays(1, &VAO);
  glGenBuffers(1, &VBO);

  glBindVertexArray(VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(f32), (void *)0);
  glEnableVertexAttribArray(0);

  glBindBuffer(GL_ARRAY_BUFFER, 0);
  glBindVertexArray(0);

  while(!glfwWindowShouldClose(window)) {
    glClearColor(0.2, 0.3, 0.3, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);

    processInput(window);

    glUseProgram(shaderProgram);
    glBindVertexArray(VAO);
    glDrawArrays(GL_TRIANGLES, 0, 3);


    glfwSwapBuffers(window);
    glfwPollEvents();
  }


  glDeleteBuffers(1, &VBO);
  glDeleteVertexArrays(1, &VAO);
  glDeleteProgram(shaderProgram);

  glfwDestroyWindow(window);
  glfwTerminate();

  return 0;
}


