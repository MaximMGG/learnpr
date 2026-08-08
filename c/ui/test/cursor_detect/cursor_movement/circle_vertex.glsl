#version 330 core
layout (location = 0) in vec2 aPos;

uniform mat4 ortho;
//uniform vec2 resolution;

void main() {
  gl_Position = ortho * vec4(aPos, 0.0, 1.0);
}
