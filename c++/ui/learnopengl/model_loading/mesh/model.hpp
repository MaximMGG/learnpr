#ifndef MY_MODEL_HPP
#define MY_MODEL_HPP

#include "mesh.hpp"
#include <stb_image.h>
#include <assimp/Importer.hpp>
#include <assimp/scene.h>
#include <assimp/postprocess.h>


#include <string>
#include <fstream>
#include <sstream>
#include <iostream>
#include <map>
#include <vector>

u32 TextureFromFile(const char *path, const std::string &directory, bool gamme = false);


class Model {
public:
  std::vector<Texture> textures_loaded;
  std::vector<Mesh> meshes;
  std::string directory;
  bool gammaCorrection;


  Model(std::string const &path, bool gamma = false) : gammaCorrection(gamma) {
    loadModel(path);
  }

  void draw(Shader &shader) {
    for(u32 i = 0; i < this->meshes.size(); i++) {
      meshes[i].Draw(shader);
    }
  }

private:
  void loadModel(std::string const &path) {
    Assimp::Importer importer;
    const aiScene *scene = importer.ReadFile(path, aiProcess_Triangulate | aiProcess_GenSmoothNormals | aiProcess_FlipUVs | aiProcess_CalcTangentSpace);

    if (!scene || scene->mFlags & AI_SCENE_FLAGS_INCOMPLETE || !scene->mRootNode) {
      std::cout << "ERROR::ASSIMP:: " << importer.GetErrorString() << '\n';
      return;
    }
    this->directory = path.substr(0, path.find_last_of('/'));
    //TODO(maxim) finish that

  }
};



#endif
