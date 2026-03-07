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
  if (glew_init != 0 || glew_init != 4) {
    std::cout << "glew Init failed\n";
    return 1;
  }

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
    glViewport(window.GetXPos(), window.GetYPos(), window.GetWidth(), window.GetHeight());

    glClearColor(0.0f, 0.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT); 

    SDL_GL_SwapWindow(window.GetWindow().get());

  }

  std::cout << "Closing!\n";
  return 0;
}
