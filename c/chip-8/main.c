#include <stdio.h>
#include <stdbool.h>
#include <SDL2/SDL.h>
#include <stdint.h>

typedef struct {
    SDL_Window *window;
    SDL_Renderer *renderer;
} sdl_t;

typedef struct {
    uint32_t window_height;
    uint32_t  window_width;
    uint32_t fg_color;
    uint32_t bg_color;
} config_t;


bool init_sdl(sdl_t *sdl, const config_t config) {
    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO | SDL_INIT_TIMER) != 0) {
        SDL_Log("Could not initialize SDL subsystem! %s\n", SDL_GetError());
        return false;
    }

    sdl->window = SDL_CreateWindow("CHIP8 Emulator", 
                    SDL_WINDOWPOS_CENTERED, 
                    SDL_WINDOWPOS_CENTERED, config.window_width, config.window_height, 0);

    if (!sdl->window) {
        SDL_Log("Could not create SDL window %s\n", SDL_GetError());
        return false;
    }

    sdl->renderer = SDL_CreateRenderer(sdl->window, -1, SDL_RENDERER_ACCELERATED);
    if (!sdl->renderer) {
        SDL_Log("Could not create SDL renderer %s\n", SDL_GetError());
        return false;
    }


    return true;
}

bool set_config_from_args(config_t *config, const int argc, const char **argv) {
    *config = (config_t){.window_width = 64, .window_height = 32, .fg_color = 0xFFFF00FF, .bg_color = 0x00000000};

    for(int i = 1; i < argc; i++) {

    }

    return true;
}

void final_cleanup(const sdl_t sdl) {
    SDL_DestroyWindow(sdl.window);
    SDL_DestroyRenderer(sdl.renderer);
    SDL_Quit();
}

void clear_screen(const sdl_t *sdl, const config_t config) {
    const uint8_t r = (uint8_t)config.bg_color >> 24 & 0xFF;
    const uint8_t g = (uint8_t)config.bg_color >> 16 & 0xFF;
    const uint8_t b = (uint8_t)config.bg_color >> 8 & 0xFF;
    const uint8_t a = (uint8_t)config.bg_color & 0xFF;
    SDL_SetRenderDrawColor(sdl->renderer, r, g, b, a);
    SDL_RenderClear(sdl->renderer);
}

void update_screen(sdl_t *sdl, config_t config) {
    SDL_RenderPresent(sdl->renderer);
}

int main(int argc, char **argv) {
    sdl_t sdl = {0};
    config_t config = {0};

    if (!set_config_from_args(&config, argc, (const char **)argv)) {
        return EXIT_FAILURE;
    }

    if (!init_sdl(&sdl, config)) {
        exit(EXIT_FAILURE);
    }

    clear_screen(&sdl, config);

    while(true) {
        //Delay
        SDL_Delay(16);

        //Update window with changes
        update_screen(&sdl, config);
    }

    final_cleanup(sdl);

    return EXIT_SUCCESS;
}
