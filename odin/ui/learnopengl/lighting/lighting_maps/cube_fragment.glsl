#version 330 core

out vec4 FragColor;

in vec3 FragPos;
in vec3 Normal;
in vec2 TexCoord;

struct Matrial {
  sampler2D diffuse;
  sampler2D specular;
  sampler2D emission;
  float shininess;
};

struct Light {
  vec3 position;
  vec3 ambient;
  vec3 diffuse;
  vec3 specular;
};

uniform vec3 viewPos;
uniform Matrial material;
uniform Light light;

void main() {
  vec3 ambient = light.ambient * texture(material.diffuse, TexCoord).rgb;
  // vec3 ambient = vec3(0.8, 0.1, 0.5) * texture(material.diffuse, TexCoord).rgb;

  vec3 norm = normalize(Normal);
  vec3 lightDir = normalize(light.position - FragPos);
  float diff = max(dot(norm, lightDir), 0.0);
  vec3 diffuse = light.diffuse * diff * texture(material.diffuse, TexCoord).rgb;
  // vec3 diffuse = vec3(0.2, 0.3, 0.8) * diff * texture(material.diffuse, TexCoord).rgb;

  vec3 viewDir = normalize(viewPos - FragPos);
  vec3 reflectDir = reflect(-lightDir, norm);
  float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
  vec3 specular = light.specular * spec * texture(material.specular, TexCoord).rgb;

  vec3 emission = texture(material.emission, TexCoord).rgb;

  vec3 result = ambient + diffuse + specular + emission;
  FragColor = vec4(result, 1.0);
}

