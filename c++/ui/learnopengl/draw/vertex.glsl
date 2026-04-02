#version 330 core
layout (location = 0) in vec4 uPos;
layout (location = 1) in vec3 uColor;
layout (location = 2) in vec2 uTexCoord;


out vec3 color;
out vec2 texCoord;

void main() {
    gl_Position = uPos;
    color = uColor;
    texCoord = uTexCoord;
}
