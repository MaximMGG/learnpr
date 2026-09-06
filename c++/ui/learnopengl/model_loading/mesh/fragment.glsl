#version 330 core
out vec4 FragColor;


in vec3 FragPos;
in vec3 Normal;
in vec2 TexCoord;

struct Light {
  vec3 position;

  vec3 ambient;
  vec3 diffuse;
  vec3 specular;
};

uniform sampler2D texture_diffuse1;
uniform sampler2D texture_specular1;
uniform float shininess;
uniform vec3 viewPos;
uniform Light light;
uniform int active_texture;

void main() {
  //ambient
  vec3 ambient = light.ambient * texture(texture_diffuse1, TexCoord).rgb;

  //diffuse
  vec3 norm = normalize(Normal);
  vec3 lightDir = normalize(light.position - FragPos);
  float diff = max(dot(norm, lightDir), 0.0);
  vec3 diffuse = light.diffuse * diff * texture(texture_diffuse1, TexCoord).rgb;

  //specular
  vec3 viewDir = normalize(viewPos - FragPos);
  vec3 reflectDir = reflect(-lightDir, norm);
  float spec = pow(max(dot(viewDir, reflectDir), 0.0), shininess);
  vec3 specular = light.specular * spec * texture(texture_specular1, TexCoord).rgb;

  vec3 res = ambient + diffuse + specular;
  if (active_texture == 1) {
    res *= 3.1;
  }
  FragColor = vec4(res, 1.0);
}
