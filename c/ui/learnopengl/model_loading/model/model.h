#ifndef MODEL_H
#define MODEL_H


#include <cstdext/core.h>
#include "mesh.h"

u32 textureFromFile(str path, str directory, bool gamma);

typedef struct {

  List *textures_loade; //List<MTexture>
  List *meshes;  //List<Mesh>
  str directory;
  bool gammaCorrection;

} Model;

Model *modelCreate(str path, bool gamma);
void modelDraw(Model *m, Shader *s);




#endif//MODEL_H
