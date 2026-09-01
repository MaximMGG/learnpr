#include "model.h"
#include <cstdext/core/string.h>

#include <assimp/cimport.h>
#include <assimp/scene.h>
#include <assimp/postprocess.h>


Mesh *modelProcessMesh(struct aiMesh *mesh, const struct aiScene *scene) {
  List *vertices;
  List *indices;
  List *textures;

  for(u32 i = 0; i < mesh->mNumVertices; i++) {
    MVertex vertex;
    vec3 vector;

    vector[0] = mesh->mVertices[i].x;
    vector[1] = mesh->mVertices[i].y;
    vector[2] = mesh->mVertices[i].z;
    memcpy(vertex.position, vector, sizeof(vector));

    

  }

  return null;
}

void modelProcessNode(Model *m, struct aiNode *node, const struct aiScene *scene) {
  for(u32 i = 0; i < node->mNumMeshes; i++) {
    struct aiMesh *mesh = scene->mMeshes[node->mMeshes[i]];
    listAppend(m->meshes, modelProcessMesh(mesh, scene));
  }

  for(u32 i = 0; i < node->mNumChildren; i++) {
    modelProcessNode(m, node->mChildren[i], scene);
  }
}

void modelLoadModel(Model *m, str path) {
  struct aiImporterDesc importer;
  
  const struct aiScene *scene = aiImportFile(path, aiProcess_Triangulate | aiProcess_GenSmoothNormals | aiProcess_FlipUVs | aiProcess_CalcTangentSpace);
  if (!scene || scene->mFlags & AI_SCENE_FLAGS_INCOMPLETE || !scene->mRootNode) {
    fprintf(stderr, "ERROR::ASSIMP:: %s\n", aiGetErrorString());
    return;
  }
  m->directory = strSubstring(path, 0, strFindLastOf(path, '/'));

  modelProcessNode(m, scene->mRootNode, scene);
}

Model *modelCreate(str path, bool gamma) {
  Model *m = make(Model);
  m->gammaCorrection = gamma;
  modelLoadModel(m, path);
  return m;
}

void modelDraw(Model *m, Shader *s) {
  for(u32 i = 0; i < m->meshes->len; i++) {
    meshDraw(listGet(m->meshes, i), s);
  }
}
