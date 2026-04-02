#ifndef SDL_WRAPPERS_HPP
#define SDL_WRAPPERS_HPP
#include <SDL2/SDL.h>
#include <memory>


namespace E_UTIL {
  struct SDL_Destroyer {
    void operator()(SDL_Window *window) const;
    void operator()(SDL_GameController *controller) const;
    void operator()(SDL_Cursor *cursor) const;

  };
}

typedef std::shared_ptr<SDL_GameController> Controller;
static Controller make_shared_controller(SDL_GameController *controller);

typedef std::shared_ptr<SDL_Cursor> Cursor;
static Cursor make_shared_controller(SDL_Cursor *controller);


typedef std::unique_ptr<SDL_Window, E_UTIL::SDL_Destroyer> WindowPtr;


#endif
