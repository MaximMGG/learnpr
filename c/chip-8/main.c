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
    uint32_t scale_factor;
} config_t;

typedef enum {
    QUIT,
    RUNNING,
    PAUSED
} emu_state;

typedef  struct {
    emu_state state;

}chip8_t;

bool init_sdl(sdl_t *sdl, const config_t config) {
    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO | SDL_INIT_TIMER) != 0) {
        SDL_Log("Could not initialize SDL subsystem! %s\n", SDL_GetError());
        return false;
    }

    sdl->window = SDL_CreateWindow("CHIP8 Emulator", 
                    SDL_WINDOWPOS_CENTERED, 
                    SDL_WINDOWPOS_CENTERED, config.window_width * config.scale_factor, config.window_height * config.scale_factor, 0);

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


bool init_chip8(chip8_t *chip) {
    chip->state = RUNNING;

    return true;
}

bool set_config_from_args(config_t *config, const int argc, const char **argv) {
    (void)argc;
    (void)argv;
    *config = (config_t){
            .window_width = 64, 
            .window_height = 32, 
            .fg_color = 0xFFFFFFFF, 
            .bg_color = 0xFFFF00FF,
            .scale_factor = 20,
        };

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
    (void)config;
    const uint8_t r = (uint8_t)(config.bg_color >> 24);
    const uint8_t g = (uint8_t)(config.bg_color >> 16);
    const uint8_t b = (uint8_t)(config.bg_color >> 8);
    const uint8_t a = (uint8_t)config.bg_color;
    SDL_SetRenderDrawColor(sdl->renderer, r, g, b, a);
    SDL_RenderClear(sdl->renderer);
}

void update_screen(sdl_t *sdl, config_t config) {
    (void)config;
    SDL_RenderPresent(sdl->renderer);
}

void handle_input(chip8_t *chip8) {
    SDL_Event ev;

    while(SDL_PollEvent(&ev)) {
        switch(ev.type) {
            case SDL_QUIT: {
                chip8->state = QUIT;
                return;
            } break;
            case SDL_KEYDOWN: {
                switch(ev.key.keysym.sym) {
                    case SDLK_ESCAPE: {
                        chip8->state = QUIT;
                        return;
                    } break;
                }

            } break;
            case SDL_KEYUP: {

            } break;
            default: {

            }
        }

    }
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

    chip8_t chip8 = {0};
    if (!init_chip8(&chip8)) {
        exit(EXIT_FAILURE);
    }

    clear_screen(&sdl, config);

    while(chip8.state != QUIT) {

        handle_input(&chip8);
        if (chip8.state == PAUSED) {

        }


        //Delay
        SDL_Delay(16);

        //Update window with changes
        update_screen(&sdl, config);
    }

    final_cleanup(sdl);

    return EXIT_SUCCESS;
}
