#include <stdio.h>
#include <SDL2/SDL.h>
#include <math.h>

#define WIDTH 900
#define HEIGHT 600
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_BLACK 0x00000000

struct Circle {
    double x;
    double y;
    double radius;
};


void FillCircle(SDL_Surface *surface, struct Circle circle, Uint32 color) {
    double radius_squared = pow(circle.radius, 2);
    for(double x = circle.x - circle.radius; x <= circle.x + circle.radius; x++) {
        for(double y = circle.y - circle.radius; y <= circle.y + circle.radius; y++) {
            double distance_squared = pow(x - circle.x, 2) + pow(y - circle.y, 2);
            if (distance_squared < radius_squared) {
                SDL_Rect pixel = (SDL_Rect) {x, y, 1, 1};
                SDL_FillRect(surface, &pixel, color);
            }
        }
    }

}

int MouseInCircle(struct Circle circle, int mx, int my) {
    double radius_squared = pow(circle.radius, 2);
    for(double x = circle.x - circle.radius; x <= circle.x + circle.radius; x++) {
        for(double y = circle.y - circle.radius; y <= circle.y + circle.radius; y++) {
            double distance_squared = pow(x - circle.x, 2) + pow(y - circle.y, 2);
            if (distance_squared < radius_squared) {
                if (x == mx && y == my) return 1;
            }
        }
    }
    return 0;
}



int main() {

    int run = 1;

    SDL_Init(SDL_INIT_VIDEO);
    SDL_Window *win = SDL_CreateWindow("Raytracing", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, WIDTH, HEIGHT, 0);

    SDL_Surface *surface = SDL_GetWindowSurface(win);

    struct Circle circle = {.x = 200, .y = 200, .radius = 80};
    SDL_Rect erase_rect = (SDL_Rect){0, 0, WIDTH, HEIGHT};

    int simulation_running = 1;
    SDL_Event ev;
    int mouse_x = 0;
    int mouse_y = 0;


    while(simulation_running) {
        while(SDL_PollEvent(&ev)) {
            if (ev.type == SDL_QUIT) {
                simulation_running = 0;
            }
            if (ev.type == SDL_KEYDOWN) {
                if (ev.key.keysym.sym == SDLK_q) {
                    simulation_running = 0;
                }
            }
            if (ev.type == SDL_MOUSEMOTION) {
                if (ev.motion.state != 0) {
                    if (MouseInCircle(circle, ev.motion.x, ev.motion.y)) {
                        circle.x = ev.motion.x;
                        circle.y = ev.motion.y;
                    }
                }
            }
        }
        SDL_FillRect(surface, &erase_rect, COLOR_BLACK);
        FillCircle(surface, circle, COLOR_WHITE);




        SDL_UpdateWindowSurface(win);
        SDL_Delay(10);
    }




    return 0;
}
