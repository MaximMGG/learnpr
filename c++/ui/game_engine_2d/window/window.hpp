#ifndef WINDOW_HPP
#define WINDOW_HPP
#include "../util/types.hpp"
#include "../util/SDL_Wrappers.hpp"
#include <string>

namespace E_WINDOW {
  class Window {
  private:
    WindowPtr m_pWindow;
    SDL_GLContext m_GLContext;
    std::string m_sTitle;
    i32 m_Width, m_Height, m_XPos, m_YPos;
    u32 m_WindowFlags;

    void CreateNewWindow(u32 flags);


  public:


    Window() : Window("default window", 640, 480, SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, true, 0){}

    Window(const std::string title, i32 width, i32 height, i32 xpos, i32 ypos, bool vsync = true, 
        u32 windowFlags = (SDL_WINDOW_OPENGL | SDL_WINDOW_RESIZABLE | SDL_WINDOW_MOUSE_CAPTURE));
    ~Window();

    inline void SetGLContext(SDL_GLContext gl_context) {m_GLContext = gl_context;}
    inline WindowPtr& GetWindow() {return m_pWindow;}
    inline SDL_GLContext& GetGLContext() {return m_GLContext;}
    inline const std::string& GetWindowName() const {return m_sTitle;}
    inline const i32 GetXPos() {return m_XPos;}
    inline const i32 GetYPos() {return m_YPos;}
    inline void SetXPos(i32 xpos) {m_XPos = xpos;}
    inline void SetYPos(i32 ypos) {m_YPos = ypos;}
    inline void SetWindowName(std::string &name);
    inline const i32 GetWidth() {return m_Width;}
    inline const i32 GetHeight() {return m_Height;}

  };

}


#endif
