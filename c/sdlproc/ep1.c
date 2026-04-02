#include <SDL2/SDL.h>
#include <stdio.h>


#define WIGHT  1280
#define HEIGHT 720 

int main() {

    if (SDL_Init(SDL_INIT_VIDEO) < 0) 
        printf("SDL not init %s\n", SDL_GetError()); 
    else
        printf("SDL videosystem init\n");

    SDL_Window *win = NULL;
    win = SDL_CreateWindow("Test window", 
            0, 0, WIGHT, HEIGHT, SDL_WINDOW_SHOWN);

    if (!win) {
        printf("Cant create window %s\n", SDL_GetError());
    } else {
        printf("Windw init\n");
    }

    int run = 1;

    while(run) {

    }



    SDL_DestroyWindow(win);
    SDL_Quit();

    return 0;
}
