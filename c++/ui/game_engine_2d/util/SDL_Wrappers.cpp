#include "SDL_Wrappers.hpp"
#include <iostream>



void E_UTIL::SDL_Destroyer::operator()(SDL_Window *window) const {
  SDL_DestroyWindow(window);
  std::cout << "Destroy SDL WINDOW\n";
}

void E_UTIL::SDL_Destroyer::operator()(SDL_GameController *controller) const {

}

void E_UTIL::SDL_Destroyer::operator()(SDL_Cursor *cursor) const {

}

static Controller make_shared_controller(SDL_GameController *controller) {

  return Controller{};
}

static Cursor make_shared_controller(SDL_Cursor *controller) {


}
