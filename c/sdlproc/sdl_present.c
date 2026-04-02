#include <SDL2/SDL.h>
#include <stdio.h>
#include <stdbool.h>


int main() {
    SDL_Window *win;
    SDL_Renderer *ren;

    SDL_Init(SDL_INIT_VIDEO);
    int color = 0xFFFF00FF;

    win = SDL_CreateWindow("test", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 640, 480, 0);
    ren = SDL_CreateRenderer(win, -1, SDL_RENDERER_ACCELERATED);

    SDL_SetRenderDrawColor(ren, (char)(color >> 24), (char)(color >> 16), (char)(color >> 8), (char)color);
    SDL_RenderClear(ren);

    SDL_RenderPresent(ren);

    SDL_Event ev;

    while(true) {
        while(SDL_PollEvent(&ev)) {
            switch(ev.type) {
                case SDL_QUIT: {
                    goto end;

                } break;
            }
        }
        SDL_RenderPresent(ren);
    }


end:

    SDL_DestroyWindow(win);
    SDL_DestroyRenderer(ren);

    return 0;
}
