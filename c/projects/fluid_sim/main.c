#include <stdio.h>
#include <stdlib.h>
#include <SDL2/SDL.h>
#include <cstdext/core.h>

#define WIDTH 900
#define HEIGHT 600
#define COLOR_WIGHT 0xFFFFFFFF
#define COLOR_BLACK 0x00000000
#define COLOR_BLUE 0xFF5EE1F2
#define COLOR_GREY 0x0F0F0F0F
#define CELL_SIZE 14 
#define LINE_WIDTH 2
#define COLUMNS WIDTH / CELL_SIZE
#define ROWS HEIGHT / CELL_SIZE


typedef struct {
    int type;
    int fill_level;
} Cell;

void color_cell(SDL_Surface *sur, int x, int y) {
    int pix_x = x * CELL_SIZE;
    int pix_y = y * CELL_SIZE;
    SDL_Rect cell = {pix_x, pix_y, CELL_SIZE, CELL_SIZE};
    SDL_FillRect(sur, &cell, COLOR_WIGHT);
}


void draw_grid(SDL_Surface *sur) {
    for(int i = 0; i < COLUMNS; i++) {
        SDL_Rect column = {i * CELL_SIZE, 0, LINE_WIDTH, HEIGHT};
        SDL_FillRect(sur, &column, COLOR_GREY);
    }
    for(int j = 0; j < ROWS; j++) {
        SDL_Rect row = {0, j * CELL_SIZE, WIDTH, LINE_WIDTH};
        SDL_FillRect(sur, &row, COLOR_GREY);
    }
}

int main() {

    SDL_Init(SDL_INIT_VIDEO);
    SDL_Window *win = SDL_CreateWindow("Liquid Simulation", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, WIDTH, HEIGHT, 0);
    SDL_Surface *sur = SDL_GetWindowSurface(win);


    SDL_Rect screen_ract = {0, 0, WIDTH, HEIGHT};
    SDL_FillRect(sur, &screen_ract, COLOR_BLACK);
    
    draw_grid(sur);


    SDL_Event e;
    bool run = true;
    while(run) {

        while(SDL_PollEvent(&e)) {
            if (e.type == SDL_QUIT) {
                run = false;
            } 
            if (e.type == SDL_KEYDOWN) {
                switch(e.key.keysym.sym) {
                    case 'q': {
                        run = false;
                    } break;
                    default: {}
                }
            }
            if (e.type == SDL_MOUSEBUTTONDOWN) {

                int x_pos = e.motion.x / CELL_SIZE;
                int y_pos = e.motion.y / CELL_SIZE;
                color_cell(sur, x_pos, y_pos);
            }

            if (e.type == SDL_MOUSEMOTION) {
                if (e.motion.state != 0) {
                    int x_pos = e.motion.x / CELL_SIZE;
                    int y_pos = e.motion.y / CELL_SIZE;
                    color_cell(sur, x_pos, y_pos);
                }
            }
        }
        SDL_UpdateWindowSurface(win);
    }


    SDL_DestroyWindow(win);
    SDL_Quit();

    return 0;
}
