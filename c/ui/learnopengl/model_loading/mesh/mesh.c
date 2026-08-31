#include "mesh.h"



void setupMesh(Mesh *m) {
  glGenVertexArrays(1, &m->VAO);
  glGenBuffers(1, &m->VBO);
  glGenBuffers(1, &m->EBO);

  glBindVertexArray(m->VAO);
  glBindBuffer(GL_ARRAY_BUFFER, m->VBO);

  glBufferData(GL_ARRAY_BUFFER, m->vertices->len * sizeof(MVertex), &m->vertices[0], GL_STATIC_DRAW);
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, m->EBO);
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, m->indices->len * sizeof(u32), &m->indices[0], GL_STATIC_DRAW);

  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, sizeof(MVertex), (void *)0);

  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, sizeof(MVertex), (void *)offsetof(MVertex, normal));

  glEnableVertexAttribArray(2);
  glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, sizeof(MVertex), (void *)offsetof(MVertex, texCoord));

  glEnableVertexAttribArray(3);
  glVertexAttribPointer(3, 3, GL_FLOAT, GL_FALSE, sizeof(MVertex), (void *)offsetof(MVertex, tangent));

  glEnableVertexAttribArray(4);
  glVertexAttribPointer(4, 3, GL_FLOAT, GL_FALSE, sizeof(MVertex), (void *)offsetof(MVertex, bitangent));

  glEnableVertexAttribArray(5);
  glVertexAttribIPointer(5, MAX_BONE_INFLUENCE, GL_INT, sizeof(MVertex), (void *)offsetof(MVertex, boneIDs));

  glEnableVertexAttribArray(6);
  glVertexAttribPointer(6, MAX_BONE_INFLUENCE, GL_FLOAT, GL_FALSE, sizeof(MVertex), (void *)offsetof(MVertex, weights));
  glBindVertexArray(0);
}

Mesh *meshCreate(List *vertices, List *indices, List *textures) {
  Mesh *m = make(Mesh);
  m->vertices = vertices;
  m->indices = indices;
  m->textures = textures;
  setupMesh(m);
  return m;
}

void meshDraw(Mesh *m, Shader *s) {
  u32 diffuse_nr = 1;
  u32 specular_nr = 1;
  u32 normal_nr = 1;
  u32 height_nr = 1;
  for(u32 i = 0; i < m->textures->len; i++) {
    glActiveTexture(GL_TEXTURE0 + i);
    str num;
    MTexture *tmp = listGet(m->textures, i);
    str name = tmp->type;
    if (streql(name, "texture_diffuse")) {
      num = strCreateFmt("%s%d", name, diffuse_nr++);
    } else if (streql(name, "texture_specular")) {
      num = strCreateFmt("%s%d", name, specular_nr++);
    } else if (streql(name, "texture_normal")) {
      num = strCreateFmt("%s%d", name, normal_nr++);
    } else if (streql(name, "texture_height")) {
      num = strCreateFmt("%s%d", name, height_nr++);
    }

    i32 loc = glGetUniformLocation(s->id, num);
    glUniform1i(loc, i);
    glBindTexture(GL_TEXTURE_2D, tmp->id);
    DEALLOC(num);
  }

  glBindVertexArray(m->VAO);
  glDrawElements(GL_TRIANGLES, m->indices->len, GL_UNSIGNED_INT, 0);
  glBindVertexArray(0);

  glActiveTexture(GL_TEXTURE0);
}
