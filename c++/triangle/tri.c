#include <stdio.h>
#include <SDL2/SDL.h>

#define WIDTH 800
#define HEIGHT 600


typedef struct {
    float x, y;
} vec;

typedef struct {
    vec t[3];
} tri;

#define a 0
#define b 1
#define c 2

int point_in_triangle(vec p, tri tr) {

    if ((((p.x - tr.t[a].x) * (tr.t[a].y - tr.t[b].y) - (p.y - tr.t[a].y) * (tr.t[a].x - tr.t[b].x)) >= 0) && 
        (((p.x - tr.t[b].x) * (tr.t[b].y - tr.t[c].y) - (p.y - tr.t[b].y) * (tr.t[b].x - tr.t[c].x)) >= 0) &&
        (((p.x - tr.t[c].x) * (tr.t[c].y - tr.t[a].y) - (p.y - tr.t[c].y) * (tr.t[c].x - tr.t[a].x)) >= 0)) {
        return 1;
    }
    return 0;
}

void fill_triangle(SDL_Renderer *render, tri tr) {
    for(float x = 0.0; x < 600; x += 0.1) {
        for(float y = 0.0; y < 600; y += 0.1) {
            vec temp = {x, y};
            if (point_in_triangle(temp, tr)) {
                SDL_RenderDrawPoint(render, x, y);
            }
        }
    }
}

void draw_triangle(SDL_Renderer *render, tri tr) {
    SDL_RenderDrawPoint(render, tr.t[a].x, tr.t[a].y);
    SDL_RenderDrawPoint(render, tr.t[b].x, tr.t[b].y);
    SDL_RenderDrawPoint(render, tr.t[c].x, tr.t[c].y);
}


int main() {
    SDL_Window *win;
    SDL_Renderer *render;
    tri triangle = {   .t[a].x = 100.0, .t[a].y = 200.0,
        .t[b].x = 300.0, .t[b].y = 100.0,
        .t[c].x = 200.0, .t[c].y = 500.0};

    SDL_Init(SDL_INIT_VIDEO);
    win = SDL_CreateWindow("Triangle", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, WIDTH, HEIGHT, 0);
    render = SDL_CreateRenderer(win, -1, 0);
    SDL_SetRenderDrawColor(render, 0x00, 0x00, 0x00, 0xFF);
    SDL_RenderClear(render);
    SDL_SetRenderDrawColor(render, 0x00, 0xFF, 0x00, 0xFF);
    draw_triangle(render, triangle);
    fill_triangle(render, triangle);
    SDL_RenderPresent(render);


    // vec point1 = {1.0, 1.2};
    // vec point2 = {10.2, 12.1};
    // vec point3 = {2.2, 3.1};
    // vec point4 = {2.2, 2.5};

    // printf("%d\n", point_in_triangle(point1, triangle));
    // printf("%d\n", point_in_triangle(point2, triangle));
    // printf("%d\n", point_in_triangle(point3, triangle));
    // printf("%d\n", point_in_triangle(point4, triangle));

    SDL_Event e;
    int quit = 1;
    while(quit) {
        while(SDL_PollEvent(&e)) {
            if (e.key.keysym.sym == SDLK_q) {
                quit = 0;
            }
        }
    }

    SDL_Quit();

    return 0;
}
