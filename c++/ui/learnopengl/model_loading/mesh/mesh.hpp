#ifndef MESH_HPP
#define MESH_HPP
#include "types.hpp"
#include "shader.hpp"

#include <glad/glad.h>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>

#include <vector>
#include <string>


#define MAX_BONE_INFLUENCE 4
struct Vertex {
  glm::vec3 position;
  glm::vec3 normal;
  glm::vec2 TexCoords;
  glm::vec3 Tangent;
  glm::vec3 bitangent;

  i32 boneIDs[MAX_BONE_INFLUENCE];

  f32 weights[MAX_BONE_INFLUENCE];
};

struct Texture {
  u32 id;
  std::string type;
  std::string path;
};

class Mesh {
public:
  std::vector<Vertex> vertices;
  std::vector<u32> indices;
  std::vector<Texture> textures;
  u32 VAO;


  Mesh(std::vector<Vertex> vertices, std::vector<u32> indices, std::vector<Texture> textures) : vertices(vertices), indices(indices), textures(textures) {
    setupMesh();
  }

  void Draw(Shader &s) {
    u32 diffuseNr = 1;
    u32 specularNr = 1;
    u32 normalNr = 1;
    u32 heightNr = 1;

    for(u32 i = 0; i < this->textures.size(); i++) {
      glActiveTexture(GL_TEXTURE0 + i);

      std::string number;
      std::string name = this->textures[i].type;
      if (name == "texture_diffuse") {
        number = std::to_string(diffuseNr++);
      } else if (name == "texture_specular") {
        number = std::to_string(specularNr++);
      } else if (name == "texture_normal") {
        number = std::to_string(normalNr++);
      } else if (name == "texture_height") {
        number = std::to_string(heightNr++);
      }

      glUniform1i(glGetUniformLocation(s.id, (name + number).c_str()), i);
      glBindTexture(GL_TEXTURE_2D, this->textures[i].id);
    }

    glBindVertexArray(this->VAO);
    glDrawElements(GL_TRIANGLES, static_cast<u32>(this->indices.size()), GL_UNSIGNED_INT, 0);
    glBindVertexArray(0);

    glActiveTexture(GL_TEXTURE0);
  }

private:
  u32 VBO, EBO;
  void setupMesh() {
    glGenVertexArrays(1, &this->VAO);
    glGenBuffers(1, &this->VBO);
    glGenBuffers(1, &this->EBO);

    glBindVertexArray(this->VAO);
    glBindBuffer(GL_ARRAY_BUFFER, this->VBO);
    glBufferData(GL_ARRAY_BUFFER, this->vertices.size() * sizeof(Vertex), &this->textures[0], GL_STATIC_DRAW);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, this->EBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, this->indices.size() * sizeof(u32), &this->indices[0], GL_STATIC_DRAW);

    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (void *)0);

    glEnableVertexAttribArray(1);
    glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (void *)offsetof(Vertex, normal));

    glEnableVertexAttribArray(2);
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, sizeof(Vertex), (void *)offsetof(Vertex, TexCoords));

    glEnableVertexAttribArray(3);
    glVertexAttribPointer(3, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (void *)offsetof(Vertex, Tangent));

    glEnableVertexAttribArray(4);
    glVertexAttribPointer(4, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (void *)offsetof(Vertex, bitangent));

    glEnableVertexAttribArray(5);
    glVertexAttribPointer(5, MAX_BONE_INFLUENCE, GL_FLOAT, GL_FALSE, sizeof(Vertex), (void *)offsetof(Vertex, boneIDs));

    glEnableVertexAttribArray(6);
    glVertexAttribPointer(6, MAX_BONE_INFLUENCE, GL_FLOAT, GL_FALSE, sizeof(Vertex), (void *)offsetof(Vertex, weights));
    glBindVertexArray(0);
  }
};



#endif //MESH_HPP
