#include <stdio.h>
#include <stdlib.h>
#include <GL/glew.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>
#include <cstdext/io/logger.h>
#include <cstdext/core.h>
#include <cstdext/io/reader.h>
#include <cstdext/core/string.h>
#include "renderer.h"
#include "VertexBuffer.h"
#include "IndexBuffer.h"
#include "VertexArray.h"
#include "VertexBufferLayout.h"

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
  reader *r = reader_create_from_file(file);
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
  GLCall(glShaderSource(id, 1, (const char *const *)&source, null));
  GLCall(glCompileShader(id));

  i32 result;
  GLCall(glGetShaderiv(id, GL_COMPILE_STATUS, &result));
  if (result == GL_FALSE) {
    i32 length;
    GLCall(glGetShaderiv(id, GL_INFO_LOG_LENGTH, &length));
    byte *message = (byte *)alloca(length + 1);
    GLCall(glGetShaderInfoLog(id, length, &length, message));
    log(ERROR, "Failed compile %s shader %s", type == GL_VERTEX_SHADER ? "vertex" : "fragment", message);
    GLCall(glDeleteShader(id));
    return 0;
  }
  
  return id;
}


static u32 CreateShader(const str vertexShader, const str fragmentShader) {
  u32 program = glCreateProgram();
  u32 vs = CompileShader(vertexShader, GL_VERTEX_SHADER);
  u32 fs = CompileShader(fragmentShader, GL_FRAGMENT_SHADER);

  GLCall(glAttachShader(program, vs));
  GLCall(glAttachShader(program, fs));
  GLCall(glLinkProgram(program));
  GLCall(glValidateProgram(program));

  GLCall(glDeleteShader(vs));
  GLCall(glDeleteShader(fs));
  
  return program;
}



int main() {
  
  if (!glfwInit()) {
    log(FATAL, "glfwInit fail");
    return EXIT_FAILURE;
  }
  log(INFO, "glfwInit");

  glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
  glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
  //glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_COMPAT_PROFILE);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "TEST WINDOW", NULL, NULL);

  if (window == NULL) {
    log(FATAL, "CreateWindow error");
    return EXIT_FAILURE;
  }
  log(INFO, "CreateWindow");

  glfwMakeContextCurrent(window);
  //glfwSwapInterval(1);
  
  if (glewInit() != GLEW_OK) {
    log(FATAL, "glewInit error");
    return EXIT_FAILURE;
  }
  log(INFO, "glewInit");

  log(INFO, "GL Version %s", glGetString(GL_VERSION));

  float positions[] = {
   -0.5f, -0.5f, // 0
    0.5f, -0.5f, // 1
    0.5f,  0.5f, // 2
   -0.5f,  0.5f, // 3
  };

  u32 indeces[] = {
    0, 1, 2, 2, 3, 0
  };

  VertexArray va = VertexArrayCreate();
  VertexBuffer vb = VertexBufferCreate(positions, sizeof(positions));

  VertexBufferLayout vbl = VertexBufferLayoutCreate();
  VertexBufferLayoutPushf32(&vbl, 2, false);
  VertexArrayAddBuffer(&va, &vb, &vbl);

  IndexBuffer ib = IndexBufferCreate(indeces, sizeof(indeces) / sizeof(u32));
  
  ShaderProgramSource source = ParseShader("./res/shaders/Basic.glsl");

  u32 shader = CreateShader(source.VertexSource, source.FragmentSource);
  GLCall(glUseProgram(shader));

  GLCall(i32 location = glGetUniformLocation(shader, "u_Color"));
  ASSERT(location != -1);
  GLCall(glUniform4f(location, 0.2f, 0.3f, 0.8f, 1.0f));


  VertexArrayUnbind(&va);
  GLCall(glUseProgram(0));
  VertexBufferUnbind(&vb);
  // GLCall(glBindBuffer(GL_ARRAY_BUFFER, 0));
  GLCall(glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0));
  
  f32 r = 0.0;
  f32 increment = 0.05;
  
  while(!glfwWindowShouldClose(window)) {
    GLCall(glClear(GL_COLOR_BUFFER_BIT));
    
    GLCall(glUseProgram(shader));
    GLCall(glUniform4f(location, r, 0.3f, 0.8f, 1.0f));

    VertexArrayBind(&va);
    IndexBufferBind(&ib);
    
    GLCall(glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, null));

    if (r > 1.0f) {
      increment = -0.05f;
    } else if (r < 0.0f) {
      increment = 0.05f;
    }
    r += increment;
    
    glfwSwapBuffers(window);
    glfwPollEvents();
    usleep(50000);
  }

  VertexBufferDestroy(&vb);
  IndexBufferDestroy(&ib);
  VertexArrayDestroy(&va);
  VertexBufferLayoutDestroy(&vbl);
  log(INFO, "We are DONE");
  GLCall(glDeleteProgram(shader));
  glfwDestroyWindow(window);
  glfwTerminate();  

  return 0;  
}
