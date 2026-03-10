#define SDL_MAIN_HANDLED 1
#include "../../window/window.hpp"
#include <iostream>
#include <GL/glew.h>
#include <SDL2/SDL.h>

int main() {

  bool running{true};

  if (SDL_Init(SDL_INIT_EVERYTHING) != 0) {
    std::string error = SDL_GetError();
    std::cout << "SDL_Init error: " << error << '\n';
    return 1;
  }

  if (SDL_GL_LoadLibrary(NULL) != 0) {
    std::string error = SDL_GetError();
    std::cout << "SDL_GL_LoadLibrary error: " << error << '\n';
    return 1;
  }

  SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 4);
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 5);
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);


  //Set the number of bits per channel
  SDL_GL_SetAttribute(SDL_GL_RED_SIZE, 8);
  SDL_GL_SetAttribute(SDL_GL_GREEN_SIZE, 8);
  SDL_GL_SetAttribute(SDL_GL_BLUE_SIZE, 8);
  SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, 24);
  SDL_GL_SetAttribute(SDL_GL_STENCIL_SIZE, 8);
  SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);
  SDL_GL_SetAttribute(SDL_GL_ACCELERATED_VISUAL, 1);

  //Create the Window
  E_WINDOW::Window window("Test", 640, 480, SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, true, SDL_WINDOW_OPENGL);

  if (!window.GetWindow()) {
    std::cout << "Failed to create the window!\n";
    return 1;
  }

  //Create the openGL context
  window.SetGLContext(SDL_GL_CreateContext(window.GetWindow().get()));

  if (!window.GetGLContext()) {
    std::string error = SDL_GetError();
    std::cout << "Failed to create openGL Context:" << error << "\n";
    return 1;
  }

  SDL_GL_MakeCurrent(window.GetWindow().get(), window.GetGLContext());
  SDL_GL_SetSwapInterval(1);


  // Init glew
  i32 glew_init = glewInit();
  // if (glew_init != 0 || glew_init != 4) {
  //   std::cout << "glew Init failed\n";
  //   return 1;
  // }


  //Create temp vertex data
  // f32 vertices[] = {
  //   0.0f, 0.5f, 0.0f, //One vertex
  //  -0.5f, -0.5f, 0.0f,
  //   0.5f, -0.5f, 0.0f
  // };
  f32 vertices[] = {
    -0.5f,  0.5f, 0.0f,
     0.5f,  0.5f, 0.0f,
     0.5f, -0.5f, 0.0f,
    -0.5f, -0.5f, 0.0f,
  };

  u32 indices[] = {
    0, 1, 2, 2, 3, 0
  };


  // Create a temp vertex source
  const char *vertexSource = 
    "#version 450 core\n"
    "layout (location = 0) in vec3 aPos;\n"
    "void main(){\n"
    "\tgl_Position = vec4(aPos, 1.0);\n"
    "}\n";

  //Create shader

  u32 vertexShader = glCreateShader(GL_VERTEX_SHADER);
  // Add the vertex shader source
  glShaderSource(vertexShader, 1, &vertexSource, nullptr);

  // Compile the vertex shader

  glCompileShader(vertexShader);
  i32 status;
  glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &status);
  if (status == GL_FALSE) {
    char infoLog[512];
    glGetShaderInfoLog(vertexShader, 512, NULL, infoLog);
    std::cout << "Vertex shader compile error: " << infoLog << '\n';
    return 1;
  }

  //Create fragment shader
  const char *fragmentSource = 
    "#version 450 core\n"
    "out vec4 FragColor;\n"
    "void main(){\n"
    "\tFragColor = vec4(1.0, 0.0, 1.0, 1.0);\n"
    "}\n";
  
  u32 fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);

  glShaderSource(fragmentShader, 1, &fragmentSource, nullptr);

  // Compile the vertex shader

  glCompileShader(fragmentShader);
  status = 0;
  glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, &status);
  if (status == GL_FALSE) {
    char infoLog[512];
    glGetShaderInfoLog(fragmentShader, 512, NULL, infoLog);
    std::cout << "Frament shader compile error: " << infoLog << '\n';
    return 1;
  }

  //Crete shader program
  u32 shaderProgram = glCreateProgram();
  glAttachShader(shaderProgram, vertexShader);
  glAttachShader(shaderProgram, fragmentShader);
  glLinkProgram(shaderProgram);

  status = 0;
  glGetProgramiv(shaderProgram, GL_LINK_STATUS, &status);

  if (!status) {
    char infoLog[512];
    glGetProgramInfoLog(shaderProgram, 512, NULL, infoLog);
    std::cout << "Link program error: " << infoLog << '\n';
    return 1;
  }

  glDeleteShader(vertexShader);
  glDeleteShader(fragmentShader);

  u32 VAO;
  glGenVertexArrays(1, &VAO);
  glBindVertexArray(VAO);

  u32 VBO;
  glGenBuffers(1, &VBO);
  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

  u32 EBO;
  glGenBuffers(1, &EBO);
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);

  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, sizeof(f32) * 3, (void *)0);
  glEnableVertexAttribArray(0);

  // glBindBuffer(GL_ARRAY_BUFFER, 0);
  // glBindVertexArray(0);
  SDL_Event event{};


  while(running) {

    while(SDL_PollEvent(&event)) {
      switch(event.type) {
        case SDL_QUIT: {
          running = false;
          break;
        }
        case SDL_KEYDOWN: {

          if (event.key.keysym.sym == SDLK_ESCAPE) {
            running = false;
          }
        } break;
        default: break;
      }
    }
    glViewport(0, 0, window.GetWidth(), window.GetHeight());


    glClearColor(0.0f, 0.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT); 

    glUseProgram(shaderProgram);

    glBindVertexArray(VAO);
    // glDrawArrays(GL_TRIANGLES, 0, 6);
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, NULL);

    SDL_GL_SwapWindow(window.GetWindow().get());

  }

  std::cout << "Closing!\n";
  return 0;
}
