#include <iostream>
#include <cstring>
#include <fstream>
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
bool firstMove = true;
f32 lastX = f32(WIDTH) / 2.0f;
f32 lastY = f32(HEIGHT) / 2.0f;



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
  set_int(cubeShader, "material.diffuse", 0);
  set_int(cubeShader, "material.specular", 1);


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


  glDeleteVertexArrays(1, &cubeVAO);
  glDeleteVertexArrays(1, &lightVAO);
  glDeleteBuffers(1, &VBO);
  glDeleteProgram(cubeShader);
  glDeleteProgram(lightShader);
  glDeleteTextures(1, &diffuseTex);
  glDeleteTextures(1, &specularTex);

  glfwDestroyWindow(window);
  glfwTerminate();

  return 0;
}

void mouse_callback(GLFWwindow *window, f64 _xpos, f64 _ypos) {
  f32 xpos = f32(_xpos);
  f32 ypos = f32(_ypos);

  if (firstMove) {
    lastX = xpos;
    lastY = ypos;
    firstMove = false;
  }

  f32 xoffset = lastX - xpos;
  f32 yoffset = ypos - lastY;

  lastX = xpos;
  lastY = ypos;
  camera.processMouseMovent(xoffset, yoffset);
}

void scroll_callback(GLFWwindow *window, f64 xoffset, f64 yoffset) {
  camera.processMouseScroll(f32(yoffset));
}

void processInput(GLFWwindow *window) {
  if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
    glfwSetWindowShouldClose(window, true);
  }
  if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS) 
    camera.processKeyboard(FORWARD, deltaTime);
  if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS) 
    camera.processKeyboard(BACKWARD, deltaTime);
  if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS) 
    camera.processKeyboard(RIGHT, deltaTime);
  if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS) 
    camera.processKeyboard(LEFT, deltaTime);
}

static bool checkStatus(u32 shader, u32 type) {
  switch(type) {
    case GL_VERTEX_SHADER: {
      i32 res;
      glGetShaderiv(shader, GL_COMPILE_STATUS, &res);
      if (res == GL_FALSE) {
        i32 len;
        glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &len);
        i8 *err_buf = new i8[len + 1];
        memset(err_buf, 0, len + 1);
        glGetShaderInfoLog(shader, len, &len, err_buf);
        std::cerr << "Comile vertex shader error [" << err_buf << "]\n";
        delete [] err_buf;
        return false;
      }
    } break;
    case GL_FRAGMENT_SHADER: {
      i32 res;
      glGetShaderiv(shader, GL_COMPILE_STATUS, &res);
      if (res == GL_FALSE) {
        i32 len;
        glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &len);
        i8 *err_buf = new i8[len + 1];
        memset(err_buf, 0, len + 1);
        glGetShaderInfoLog(shader, len, &len, err_buf);
        std::cerr << "Comile fragment shader error [" << err_buf << "]\n";
        delete [] err_buf;
        return false;
      }
    } break;
    case GL_PROGRAM: {
      i32 res;
      glGetProgramiv(shader, GL_LINK_STATUS, &res);
      if (res == GL_FALSE) {
        i32 len;
        glGetProgramiv(shader, GL_INFO_LOG_LENGTH, &len);
        i8 *err_buf = new i8[len + 1];
        memset(err_buf, 0, len + 1);
        glGetProgramInfoLog(shader, len, &len, err_buf);
        std::cerr << "Ling program error [" << err_buf << "]\n";
        delete [] err_buf;
        return false;
      }

    } break;
  }

  return true;
}

u32 compile_shader(const char *shader, u32 type) {
  std::ifstream r(shader);
  if (r.is_open()) {
    r.seekg(0, std::ios_base::end);
    long file_size = r.tellg();
    r.seekg(0, std::ios_base::beg);
    i8 *buf = new i8[file_size + 1];
    memset(buf, 0, file_size + 1);
    r.read(buf, file_size);

    u32 s = glCreateShader(type);
    glShaderSource(s, 1, &buf, nullptr);
    glCompileShader(s);
    if (!checkStatus(s, type)) {
      std::cerr << "Compile shader: " << shader << "FAILED\n";
      return 0;
    }
    return s;
  } else {
    std::cerr << "Can't open file: " << shader << '\n';
    return 0;
  }

  return 0;
}


u32 load_shader(const char *vertex, const char *fragment) {
  u32 vs = compile_shader(vertex, GL_VERTEX_SHADER);
  u32 fs = compile_shader(fragment, GL_FRAGMENT_SHADER);
  if (vs == 0 || fs == 0) {
    return 0;
  }
  u32 prog = glCreateProgram();
  glAttachShader(prog, vs);
  glAttachShader(prog, fs);
  glLinkProgram(prog);
  if (!checkStatus(prog, GL_PROGRAM)) {
    glDeleteShader(vs);
    glDeleteShader(fs);
    return 0;
  }

  glDeleteShader(vs);
  glDeleteShader(fs);
  glValidateProgram(prog);

  return prog;
}

i32 getLoc(u32 shader, const char *name) {
  i32 loc = glGetUniformLocation(shader, name);
  if (loc == -1) {
    std::cerr << "Can't find location for uniform: " << name << '\n';
    return -1;
  }
  return loc;
}

void set_mat4(u32 shader, const char *name, glm::mat4 &val) {
  i32 loc = getLoc(shader, name);
  if (loc != -1) {
    glUniformMatrix4fv(loc, 1, GL_FALSE, &val[0][0]);
  }
}

void set_vec3(u32 shader, const char *name, glm::vec3 val) {
  i32 loc = getLoc(shader, name);
  if (loc != -1) {
    glUniform3fv(loc, 1, &val[0]);
  }
}

void set_int(u32 shader, const char *name, i32 val) {
  i32 loc = getLoc(shader, name);
  if (loc != -1) {
    glUniform1i(loc, val);
  }

}
void set_float(u32 shader, const char *name, f32 val) {
  i32 loc = getLoc(shader, name);
  if (loc != -1) {
    glUniform1f(loc, val);
  }
}


u32 load_texture(const char *path) {
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
    i32 format = GL_RGB;
    if (nrChannels == 1) format = GL_RED;
    if (nrChannels == 3) format = GL_RGB;
    if (nrChannels == 4) format = GL_RGBA;

    glTexImage2D(GL_TEXTURE_2D, 0, format, width, height, 0, format, GL_UNSIGNED_BYTE, data);
    glGenerateMipmap(GL_TEXTURE_2D);

    stbi_image_free(data);
  } else {
    std::cerr << "stbi_load error: " << path << '\n';
    return 0;
  }

  return tex;
}
