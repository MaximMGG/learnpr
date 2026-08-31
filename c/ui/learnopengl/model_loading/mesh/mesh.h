#ifndef MESH_H
#define MESH_H


#include "shader.h"
#include <cglm/cglm.h>
#include <cstdext/container/list.h>
#define MAX_BONE_INFLUENCE 4

typedef struct __attribute__((__aligned__((4)))){
  vec3 position;
  vec3 normal;
  vec2 texCoord;

  vec3 tangent;
  vec3 bitangent;
  i32 boneIDs[MAX_BONE_INFLUENCE];
  f32 weights[MAX_BONE_INFLUENCE];
} MVertex;

typedef struct {
  u32 id;
  str type;
} MTexture;


typedef struct {
  List *vertices; //List<MVertex>
  List *indices;  //u32
  List *textures; //List<MTexture>

  u32 VAO, VBO, EBO;
} Mesh;

Mesh *meshCreate(List *vertices, List *indices, List *textures);
void meshDraw(Mesh *m, Shader *s);




#endif //


