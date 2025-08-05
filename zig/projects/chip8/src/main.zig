const std = @import("std");
const CHIP8 = @import("chip8.zig");

const sdl = @cImport(@cInclude("SDL2/SDL.h"));


var window: ?*sdl.SDL_Window = null;
var renderer: ?*sdl.SDL_Renderer = null;
var texture: ?*sdl.SDL_Texture = null;

var cpu: *CHIP8 = undefined;

fn init() !void {
    if (sdl.SDL_Init(sdl.SDL_INIT_VIDEO) < 0) 
        @panic("SDL Initiallization fail");

    window = sdl.SDL_CreateWindow("CHIP8", sdl.SDL_WINDOWPOS_CENTERED, sdl.SDL_WINDOWPOS_CENTERED,
        1024, 512, 0);

    renderer = sdl.SDL_CreateRenderer(window, -1, 0) orelse {
        @panic("SDL Renderer Initialization Faild");
    };

    texture = sdl.SDL_CreateTexture(renderer, sdl.SDL_PIXELFORMAT_RGBA8888, 
        sdl.SDL_TEXTUREACCESS_STREAMING, 1024, 512) orelse {
        @panic("SDL Texture initialization Failed");
    };

}

fn deinit() void {
    sdl.SDL_DestroyRenderer(renderer);
    sdl.SDL_DestroyWindow(window);
    sdl.SDL_Quit();
}



pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.c_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    try init();
    defer deinit();

    cpu = try allocator.create(CHIP8);
    //TODO: Load a ROM

    var keep_open = true;

    while(keep_open) {
        cpu.cycle();
        var e: sdl.SDL_Event = undefined;

        while(sdl.SDL_PollEvent(&e) > 0) {
            switch(e.type) {
                sdl.SDL_QUIT => {
                    keep_open = false;
                },
                else => {}
            }
        }

        _ = sdl.SDL_RenderClear(renderer);


        //TODO: Build Texture

        _ = sdl.SDL_RenderCopy(renderer, texture, null, null);
        _ = sdl.SDL_RenderPresent(renderer);

        std.time.sleep(16 * std.time.ns_per_ms);

    }
}
