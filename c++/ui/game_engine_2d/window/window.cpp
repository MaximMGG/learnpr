#include "window.hpp"
#include <iostream>



namespace E_WINDOW {
  void Window::CreateNewWindow(u32 flags) {
    m_pWindow = WindowPtr(SDL_CreateWindow(
          m_sTitle.c_str(), m_XPos, m_YPos, m_Width, m_Height, flags));
    // Check to see if the window was created correctly
    if (!m_pWindow) {
      std::string error = SDL_GetError();
      std::cout << "Failed to create the Window: " << error << '\n';
    }
  }

  Window::Window(const std::string title, i32 width, i32 height, i32 xpos, i32 ypos, bool vsync, u32 windowFlags) 
    : m_pWindow{nullptr}, m_GLContext{}, m_sTitle(title), m_Width{width}, m_Height{height}, m_XPos{xpos}, m_YPos(ypos), 
    m_WindowFlags{windowFlags}
  {
    CreateNewWindow(windowFlags);

    //Enable v-sync
    if (vsync) {
      if (!SDL_SetHint(SDL_HINT_RENDER_VSYNC, "1")) {
        std::cout << "Failed to enable VSYNC!\n";
      }
      std::cout << "Window Created Successfull\n";
    }
  }

  Window::~Window() {

  }
  inline void Window::SetWindowName(std::string &name) {
    m_sTitle = name;
    SDL_SetWindowTitle(m_pWindow.get(), name.c_str());

  }
}
