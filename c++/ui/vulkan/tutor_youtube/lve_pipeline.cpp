#include "lve_pipeline.hpp"
#include <fstream>
#include <stdio.h>

namespace lve {

  LvePipeline::~LvePipeline() {
    
  }
  
  LvePipeline::LvePipeline(LveDevice& device, const std::string& vertFilepath, const std::string& fragFilepath, const PipelineConfigInfo& confInfo) : lveDevice(device){
    createGraphicsPipeline(vertFilepath, fragFilepath, confInfo);
  }

  std::vector<char> LvePipeline::readFile(const std::string& filepath) {
    std::ifstream file(filepath, std::ios::ate | std::ios::binary);
    if (!file.is_open()) {
      fprintf(stderr, "Failed to open file: %s", filepath.c_str());
      return {};
    }


    size_t fileSize = static_cast<size_t>(file.tellg());
    std::vector<char> buffer(fileSize);

    file.seekg(0);
    file.read(buffer.data(), fileSize);
    file.close();
    return buffer;
    
  }
  void LvePipeline::createGraphicsPipeline(const std::string vertFilepath, const std::string fragFilepath, const PipelineConfigInfo& confInfo) {
    auto vertCode = readFile(vertFilepath);
    auto fragCode = readFile(fragFilepath);

    printf("Vertex Shader Code Size: %ld\n", vertCode.size());
    printf("Fragment Shader Code Size: %ld\n", fragCode.size());
  }

  void LvePipeline::createShaderModule(const std::vector<char> &code, VkShaderModule *shaderModule) {
    VkShaderModuleCreateInfo createInfo{};
    createInfo.sType = VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO;
    createInfo.codeSize = code.size();
    createInfo.pCode = reinterpret_cast<const uint32_t *>(code.data());
    //createInfo.pCode = (const uint32_t *)code.data();
    if (vkCreateShaderModule(lveDevice.device(), &createInfo, NULL, shaderModule) != VK_SUCCESS) {
      fprintf(stderr, "Failed to create VK module\n");
    }
  }

  PipelineConfigInfo LvePipeline::defaultPipelineConfigInfo(uint32_t width, uint32_t height) {
    PipelineConfigInfo confInfo{};

    return confInfo;
  }

}
