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
#include "Shader.h"
#include "Texture.h"

#define WIDTH 640
#define HEIGHT 480

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
   -0.5f, -0.5f, 0.0f, 0.0f,// 0
    0.5f, -0.5f, 1.0f, 0.0f,// 1
    0.5f,  0.5f, 1.0f, 1.0f,// 2
   -0.5f,  0.5f, 0.0f, 1.0f// 3
  };

  u32 indeces[] = {
    0, 1, 2, 2, 3, 0
  };

  VertexArray va = VertexArrayCreate();
  VertexBuffer vb = VertexBufferCreate(positions, sizeof(positions));

  VertexBufferLayout vbl = VertexBufferLayoutCreate();
  VertexBufferLayoutPushf32(&vbl, 2, false);
  VertexBufferLayoutPushf32(&vbl, 2, false);
  VertexArrayAddBuffer(&va, &vb, &vbl);

  IndexBuffer ib = IndexBufferCreate(indeces, sizeof(indeces) / sizeof(u32));
  
  Shader s = ShaderCreate("./res/shaders/Basic.glsl");

  ShaderBind(&s);
  //ShaderSetUniform4f(&s, "u_Color", 0.2f, 0.3f, 0.8f, 1.0f);

  Texture t = TextureCreate("./res/textures/file.png");
  TextureBind(&t, 0);
  ShaderSetUniform1i(&s, "u_Texture", 0);


  VertexArrayUnbind(&va);
  //ShaderUnbind(&s);
  VertexBufferUnbind(&vb);
  IndexBufferUnbind(&ib);
  
  f32 r = 0.0;
  f32 increment = 0.05;
  
  while(!glfwWindowShouldClose(window)) {
    GLCall(glClear(GL_COLOR_BUFFER_BIT));
    
    ShaderBind(&s);
    //ShaderSetUniform4f(&s, "u_Color", r, 0.3f, 0.8f, 1.0f);

    ShaderSetUniform1i(&s, "u_Texture", 0);
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
  ShaderDestroy(&s);
  glfwDestroyWindow(window);
  glfwTerminate();  

  log(INFO, "We are DONE");
  return 0;  
}
