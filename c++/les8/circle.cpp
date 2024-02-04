#include <iostream>
#include <math.h>
#include <SDL2/SDL.h>

typedef struct {
    float x, y;
} vec2_t;

constexpr float PI = 3.14;
#define RAD(x) x * PI/180
#define WIDTH 800
#define HEIGHT 600

void draw_circle(SDL_Renderer *render, float rad, vec2_t start_point) {
    float x = start_point.x, y = start_point.y;
    for(float i = 0.00; i <= 360.0; i += 0.1) {
        float s = sin(RAD(i));
        float c = cos(RAD(i));
        SDL_RenderDrawPoint(render, x + rad * c, y + rad * s);
    }
}





int main() {
    std::cout.setf(std::ios_base::fixed);
    vec2_t c {0.0, 0.0};
    float diameter = 20.0;
    std::cout << "       sin                cos     " << std::endl;

    // for(double i = 0.0; i <= 180.0; i++) {
    //     std::cout << "      " << sin(RAD(i)) << "                " << cos(RAD(i)) << std::endl;
    // }


    SDL_Init(SDL_INIT_VIDEO);
    SDL_Window *win;
    SDL_Renderer *rend;
    win = SDL_CreateWindow("Circle", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, WIDTH, HEIGHT, 0);
    rend = SDL_CreateRenderer(win, -1, 0);

    SDL_SetRenderDrawColor(rend, 0x00, 0x00, 0x00, 0xFF);
    SDL_RenderClear(rend);
    SDL_SetRenderDrawColor(rend, 0x00, 0xFF, 0x00, 0xFF);
    vec2_t v = {300.0, 300.0};
    draw_circle(rend, 200.0, v);
    SDL_RenderPresent(rend);
    
    int quit = 1;
    SDL_Event e;

    while(quit) {
        while(SDL_PollEvent(&e)) {
            if (e.key.keysym.sym == SDLK_q) {
                quit = 0;
            }
        }
    }

    SDL_DestroyRenderer(rend);
    SDL_DestroyWindow(win);
    SDL_Quit();
    return 0;
}
