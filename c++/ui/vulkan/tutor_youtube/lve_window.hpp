#ifndef LVE_WINDOW_HPP
#define LVE_WINDOW_HPP

#include <string>
#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>


namespace lve {
  class LveWindow {
  public:
    LveWindow(int width, int height, std::string name);
    ~LveWindow();
    LveWindow(const LveWindow &) = delete;
    LveWindow &operator=(const LveWindow &) = delete;
    
    void initWindow();
    bool shouldClose();
    void createWindowSurface(VkInstance instance, VkSurfaceKHR *surface);
  private:
    const int width;
    const int height;

    std::string name;
    GLFWwindow *window;
  };
}


#endif //LVE_WINDOW_HPP

