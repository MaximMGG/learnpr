#include <stdio.h>
#include <stdlib.h>
#include <GL/glew.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>
#include <cstdext/io/logger.h>
#include <cstdext/core.h>
#include <cstdext/io/reader.h>
#include <cstdext/core/string.h>

#define WIDTH 640
#define HEIGHT 480

typedef struct {
  str VertexSource;
  str FragmentSource;
} ShaderProgramSource;

typedef enum ShaderType {
    NONE = -1, VERTEX = 0, FRAGMENT = 1
} ShaderType;

static ShaderProgramSource ParseShader(str file) {
  reader *r = reader_create_from_file(file, 0);
  str_buf *sb[2] = {str_buf_create(), str_buf_create()};

  u32 type;

  ShaderType st = NONE;
  
  str line;
  while((line = reader_read_until_del(r, '\n')) != null) {
    if (strstr(line, "#shader") != null) {
      if (strstr(line, "vertex") != null) {
	st = VERTEX;
      } else if (strstr(line, "fragment") != null) {
	st = FRAGMENT;
      }
    } else {
      str_buf_append_format(sb[st], "%s\n", line);
    }
  }
  ShaderProgramSource prog = {.VertexSource = str_buf_to_string(sb[0]), .FragmentSource = str_buf_to_string(sb[1])};
  str_buf_destroy(sb[0]);
  str_buf_destroy(sb[1]);

  return prog;
}


static u32 CompileShader(const str source, u32 type) {
  u32 id = glCreateShader(type);
  glShaderSource(id, 1, &source, null);
  glCompileShader(id);

  i32 result;
  glGetShaderiv(id, GL_COMPILE_STATUS, &result);
  if (result == GL_FALSE) {
    i32 length;
    glGetShaderiv(id, GL_INFO_LOG_LENGTH, &length);
    byte *message = (byte *)alloca(length + 1);
    glGetShaderInfoLog(id, length, &length, message);
    log(ERROR, "Failed compile %s shader %s", type == GL_VERTEX_SHADER ? "vertex" : "fragment", message);
    glDeleteShader(id);
    return 0;
  }
  
  return id;
}


static u32 CreateShader(const str vertexShader, const str fragmentShader) {
  u32 program = glCreateProgram();
  u32 vs = CompileShader(vertexShader, GL_VERTEX_SHADER);
  u32 fs = CompileShader(fragmentShader, GL_FRAGMENT_SHADER);

  glAttachShader(program, vs);
  glAttachShader(program, fs);
  glLinkProgram(program);
  glValidateProgram(program);

  glDeleteShader(vs);
  glDeleteShader(fs);
  
  return program;
}



int main() {
  
  if (!glfwInit()) {
    log(FATAL, "glfwInit fail");
    return EXIT_FAILURE;
  }
  log(INFO, "glfwInit");



  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "TEST WINDOW", NULL, NULL);

  if (window == NULL) {
    log(FATAL, "CreateWindow error");
    return EXIT_FAILURE;
  }
  log(INFO, "CreateWindow");

  glfwMakeContextCurrent(window);
  if (glewInit() != GLEW_OK) {
    log(FATAL, "glewInit error");
    return EXIT_FAILURE;
  }
  log(INFO, "glewInit");

  log(INFO, "GL Version %s", glGetString(GL_VERSION));

  float positions[6] = {
    -0.5f, -0.5f,
    0.0f,  0.5f,
    0.5f, -0.5f
  };
    
  u32 buffer;
  glGenBuffers(1, &buffer);
  glBindBuffer(GL_ARRAY_BUFFER, buffer);
  glBufferData(GL_ARRAY_BUFFER, sizeof(positions), positions, GL_STATIC_DRAW);

  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, sizeof(f32) * 2, (ptr)0);

  ShaderProgramSource source = ParseShader("./res/shaders/Basic.glsl");

  
  u32 shader = CreateShader(source.VertexSource, source.FragmentSource);
  glUseProgram(shader);
    
  while(!glfwWindowShouldClose(window)) {
    glClear(GL_COLOR_BUFFER_BIT);

    glDrawArrays(GL_TRIANGLES, 0, 3);

    glfwSwapBuffers(window);
    glfwPollEvents();
  }

  log(INFO, "We are DONE");  
  glfwDestroyWindow(window);
  glfwTerminate();  

  return 0;  
}
