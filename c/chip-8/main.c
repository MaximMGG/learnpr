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
    uint8_t ram[4096];
    bool display[64*32];    // Emulate original CHIP8 resolution pixels
    uint16_t stack[12];     // Subroutine stack
    uint8_t V[16];          // Data registers V0-VF
    uint16_t I;             // Index register
    uint16_t PC;            // Program Counter
    uint8_t delay_timer;    // Decrements at 60hz when > 0
    uint8_t sound_timer;    // Decrements at 60hz and palys tone when > 0
    bool keypad[16];        // Hexadecimal keypad 0x0-0xF
    char *rom_name;         // Currently running ROM
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


bool init_chip8(chip8_t *chip, char *rom_name) {
    const uint32_t entry_point = 0x200;

    const uint8_t font[] = {
        0xF0, 0x90, 0x90, 0x90, 0xF0, // 0
        0x20, 0x60, 0x20, 0x20, 0x70, // 1
        0xF0, 0x10, 0xF0, 0x80, 0xF0, // 2
        0xF0, 0x10, 0xF0, 0x10, 0xF0, // 3
        0x90, 0x90, 0xF0, 0x10, 0x10, // 4
        0xF0, 0x80, 0xF0, 0x10, 0xF0, // 5
        0xF0, 0x80, 0xF0, 0x90, 0xF0, // 6
        0xF0, 0x10, 0x20, 0x40, 0x40, // 7
        0xF0, 0x90, 0xF0, 0x90, 0xF0, // 8
        0xF0, 0x90, 0xF0, 0x10, 0xF0, // 9
        0xF0, 0x90, 0xF0, 0x90, 0x90, // A
        0xE0, 0x90, 0xE0, 0x90, 0xE0, // B
        0xF0, 0x80, 0x80, 0x80, 0xF0, // C
        0xE0, 0x90, 0x90, 0x90, 0xE0, // D
        0xF0, 0x80, 0xF0, 0x80, 0xF0, // E
        0xF0, 0x80, 0xF0, 0x80, 0x80, // F
    };
    // Load font
    memcpy(&chip->ram[0], font, sizeof(font));

    // Open ROM file
    FILE *rom = fopen(rom_name, "rb");
    if (!rom) {
        SDL_Log("Rom file %s is invalid or does not exists\n", rom_name);
        return false;
    }

    //Get/check rom size
    fseek(rom, 0, SEEK_END);
    const size_t rom_size = ftell(rom);
    const size_t max_size = sizeof(chip->ram) - entry_point;
    rewind(rom);

    if (rom_size > max_size) {
        SDL_Log("Rom file %s is too big! Rom size: %zu, Max size: %zu\n", rom_name, rom_size, max_size);
        return false;
    }

    if (fread(&chip->ram[entry_point], rom_size, 1, rom) != 1) {
        SDL_Log("Could not read Rom File %s into chip8 memory\n", rom_name);
        return false;
    }
 
    fclose(rom);

    // Load chip8 machine defaults
    chip->state = RUNNING;
    chip->PC = entry_point;
    chip->rom_name = rom_name;

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
                    case SDLK_SPACE: {
                        //Space bar
                        if (chip8->state == RUNNING) {
                            chip8->state = PAUSED;
                            puts("==== PAUSED ====");
                        } else {
                            chip8->state = RUNNING;
                            puts("==== RUNNING ====");
                        } return;
                    } break;
                    default: continue;
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

    //Default Usage message for args
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <rom_name>\n", argv[0]);
        return 1;
    }


    sdl_t sdl = {0};
    config_t config = {0};

    if (!set_config_from_args(&config, argc, (const char **)argv)) {
        return EXIT_FAILURE;
    }

    if (!init_sdl(&sdl, config)) {
        exit(EXIT_FAILURE);
    }

    chip8_t chip8 = {0};
    if (!init_chip8(&chip8, argv[1])) {
        exit(EXIT_FAILURE);
    }

    clear_screen(&sdl, config);

    while(chip8.state != QUIT) {

        handle_input(&chip8);
        if (chip8.state == PAUSED) {
            continue;
        }

        //Delay
        SDL_Delay(16);

        //Update window with changes
        update_screen(&sdl, config);
    }

    final_cleanup(sdl);

    return EXIT_SUCCESS;
}
