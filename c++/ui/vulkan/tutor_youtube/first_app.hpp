#ifndef FIRST_APP_HPP
#define FIRST_APP_HPP
#include "lve_window.hpp"
#include "lve_pipeline.hpp"
#include "lve_device.hpp"

namespace lve {
  class FirstApp {
  public:
    void run();
    FirstApp() = default;
    ~FirstApp() = default;


  private:
    static constexpr int WIDTH = 800;
    static constexpr int HEIGHT = 600;
    LveWindow lveWindow{WIDTH, HEIGHT , "Hello vulkan!"};
    LveDevice lveDevice{lveWindow};
    LvePipeline lvePipeline{lveDevice, "shaders/simple_shader.vert.svp", "shaders/simple_shader.frag.svp", LvePipeline::defaultPipelineConfigInfo(WIDTH, HEIGHT)};
    
  };
}



#endif //FIRST_APP_HPP
