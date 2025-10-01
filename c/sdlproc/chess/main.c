#include <cstdext/core.h>
#include <stdio.h>
#include <SDL2/SDL.h>
#include <stdlib.h>
#include <glad/glad.h>

#define WIDTH 640
#define HEIGHT 480
#define i32 int
#define u32 unsigned int


void sdl_assert_msg(char cond, const char *message) {
    if (!cond) {
        printf("%s | SDL Error: %s\n", message, SDL_GetError());
        exit(EXIT_FAILURE);
    }
}

int main() {


    sdl_assert_msg(SDL_Init(SDL_INIT_EVERYTHING) == 0, "Failed to initialize SDL");
    sdl_assert_msg(SDL_GL_LoadLibrary(NULL) == 0, "Failed to load default OpenGL Libraray");

    sdl_assert_msg(SDL_GL_SetAttribute(SDL_GL_ACCELERATED_VISUAL, 1) == 0, "Failed to set attribute in GL");
    sdl_assert_msg(SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 4) == 0, "Failed to set opengl version major");
    sdl_assert_msg(SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 5) == 0, "Failed to set opengl version minor");

    sdl_assert_msg(SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1) == 0, "Can not use double buffering");
    sdl_assert_msg(SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, 24) == 0, "Failed to depth buffer size");

    SDL_Window *window = SDL_CreateWindow("Chess", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, WIDTH, HEIGHT, SDL_WINDOW_OPENGL);
    sdl_assert_msg(window != NULL, "Failed to create SDL window");

    SDL_GLContext context = SDL_GL_CreateContext(window);
    sdl_assert_msg(context != NULL, "Failed to create GL context");

    gladLoadGLLoader((GLADloadproc)SDL_GL_GetProcAddress);
    printf("OpenGL vendor: %s\n", glGetString(GL_VENDOR));
    printf("OpenGL renderer:%s\n", glGetString(GL_RENDERER));
    printf("OpenGL Version:%s\n", glGetString(GL_VERSION));

    // sdl_assert_msg(SDL_GL_SetSwapInterval(1) == 0, "Vsync not supported.");
    i32 width, height;
    SDL_GetWindowSize(window, &width, &height);
    glViewport(0, 0, width, height);

    SDL_Event e;
    char quit = 0;
    while(!quit) {
        glClear(GL_COLOR_BUFFER_BIT);
        glClearColor(0.2f, 0.3f, 0.8f, 1.0f);
        SDL_GL_SwapWindow(window);
        while(SDL_PollEvent(&e)) {
            if (e.type == SDL_QUIT) {
                quit = 1;
            }

        }
    }

    SDL_DestroyWindow(window);
    SDL_Quit();

    return 0;
}
