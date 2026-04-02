package game

import "core:fmt"
import SDL "vendor:sdl2"
import SDL_Image "vendor:sdl2/image"


WINDOW_FALGS :: SDL.WINDOW_SHOWN
RENDER_FALGS :: SDL.RENDERER_ACCELERATED
TARGET_DELTA_TIME :: f64(1000) / f64(60)
WINDOW_WIDTH :: 1600
WINDOW_HEIGHT :: 960
PLAYER_SPEED : f64 : 500
//LASER
LASER_SPEED : f64 : 700
NUM_OF_LASERS :: 100
LASER_COOLDOWN_TIMER : f64 : 50

Game :: struct {
    perf_frequency:   f64,
    renderer:         ^SDL.Renderer,

    //player
    player:           Entity,
    player_tex:       ^SDL.Texture,
    
    //laser:            Entity,
    lasers:           [NUM_OF_LASERS]Entity,
    laser_tex:        ^SDL.Texture,
    laser_cooldown:   f64,

    left:             bool,
    right:            bool,
    up:               bool,
    down:             bool,
    fire:             bool,
}


Entity :: struct {
    dest: SDL.Rect,
    health: int ,
}

game := Game{}

main :: proc() {
    assert(SDL.Init(SDL.INIT_VIDEO) == 0, SDL.GetErrorString())
    assert(SDL_Image.Init(SDL_Image.INIT_PNG) != nil, SDL.GetErrorString())
    defer SDL.Quit()

    window := SDL.CreateWindow(
	"Odin Space Shooter",
	SDL.WINDOWPOS_CENTERED,
	SDL.WINDOWPOS_CENTERED,
	WINDOW_WIDTH,
	WINDOW_HEIGHT,
	WINDOW_FALGS)

    assert(window != nil, SDL.GetErrorString())
    defer SDL.DestroyWindow(window)

    game.renderer = SDL.CreateRenderer(window, -1, RENDER_FALGS)
    assert(game.renderer != nil, SDL.GetErrorString())
    defer SDL.DestroyRenderer(game.renderer)


    create_entityes()
    
    game.perf_frequency = f64(SDL.GetPerformanceFrequency())
    start: f64
    end: f64

    event: SDL.Event
    state: [^]u8

    game_loop: for {
	start = get_time()

	state = SDL.GetKeyboardState(nil)
	game.left = state[SDL.Scancode.A] > 0
	game.right = state[SDL.Scancode.D] > 0
	game.up = state[SDL.Scancode.W] > 0
	game.down = state[SDL.Scancode.S] > 0
	game.fire = state[SDL.Scancode.SPACE] > 0

	if SDL.PollEvent(&event) {
	    if event.type == SDL.EventType.QUIT {
		break game_loop
	    }

	    if event.type == SDL.EventType.KEYDOWN {
		#partial switch event.key.keysym.scancode {
		    case .ESCAPE:
		        break game_loop


		}
	    }
	}

	delta_motion := get_delta_motion(PLAYER_SPEED)
	
	if game.left {
	    move_player(-delta_motion, 0)
	}
	if game.right {
	    move_player(delta_motion, 0)
	}
	if game.up {
	    move_player(0, -delta_motion)
	}
	if game.down {
	    move_player(0, delta_motion)
	}
	

	SDL.RenderCopy(game.renderer, game.player_tex, nil, &game.player.dest)

	if game.fire && !(game.laser_cooldown > 0) {
	    reload : for &laser in game.lasers {
		if laser.dest.x > WINDOW_WIDTH {
		    laser.dest.x = game.player.dest.x + 30
		    laser.dest.y = game.player.dest.y

		    game.laser_cooldown = LASER_COOLDOWN_TIMER

		    break reload
		}
	    }
	}

	for &laser in game.lasers {
	    if laser.dest.x < WINDOW_WIDTH {
		laser.dest.x += i32(get_delta_motion(LASER_SPEED))
		SDL.RenderCopy(game.renderer, game.laser_tex, nil, &laser.dest)
	    }
	}
	
	game.laser_cooldown -= get_delta_motion(LASER_SPEED)

	end = get_time()

	for end - start < TARGET_DELTA_TIME {
	    end = get_time()
	}

	fmt.println("FPS : ", 1000 / (end - start))

	SDL.RenderPresent(game.renderer)

	SDL.SetRenderDrawColor(game.renderer, 0, 0, 0, 100)

	SDL.RenderClear(game.renderer)
    }
}

get_time :: proc() -> f64 {
    return f64(SDL.GetPerformanceCounter()) * 1000 / game.perf_frequency
}


move_player :: proc(x, y: f64) {
    game.player.dest.x = clamp(game.player.dest.x + i32(x), 0, WINDOW_WIDTH - game.player.dest.w)
    game.player.dest.y = clamp(game.player.dest.y + i32(y), 0, WINDOW_HEIGHT - game.player.dest.h)
}

create_entityes :: proc() {
        player_texture := SDL_Image.LoadTexture(game.renderer, "player.png")
    assert(player_texture != nil, SDL.GetErrorString())

    destination := SDL.Rect{x = 20, y = WINDOW_HEIGHT / 2}
    SDL.QueryTexture(player_texture, nil, nil, &destination.w, &destination.h)

    destination.w /= 10
    destination.h /= 10
    
    game.player_tex = player_texture
    
    game.player = Entity {
	dest = destination,
	health = 10,
    }

    laser_texture := SDL_Image.LoadTexture(game.renderer, "bullet_red_2.png")
    assert(laser_texture != nil, SDL.GetErrorString())


    laser_w: i32
    laser_h: i32
    
    SDL.QueryTexture(laser_texture, nil, nil, &laser_w, &laser_h)
    game.laser_tex = laser_texture

    for index in 0..<NUM_OF_LASERS {
	d := SDL.Rect{
	    x = WINDOW_WIDTH + 20,
	    y = 0,
	    w = laser_w / 3,
	    h = laser_h / 3,
	}
	
	game.lasers[index] = Entity {
	     dest = d,
	    health = 0,
	}	
    }

}

get_delta_motion :: proc(speed: f64) -> f64 {
    return speed * (TARGET_DELTA_TIME / 1000)
}
