#version 330 core

out vec4 FragColor;

uniform float inside;

void main() {
  FragColor = vec4(inside, 0.5, 0.1, 1.0);
}
