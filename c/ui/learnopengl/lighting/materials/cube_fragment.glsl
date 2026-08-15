#version 330 core

struct Materials {
  vec3 ambient;
  vec3 diffuse;
  vec3 specular;
  float shininess;
};

uniform Materials materials;
uniform vec3 lightColor;

void main() {
  vec3 ambient = 
}
