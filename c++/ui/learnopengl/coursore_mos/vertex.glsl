#version 450 core
layout (location = 0) vec4 aPos;
layout (location = 1) vec2 aTexCoord;

out vec2 TexCoord;

uniform mat4 projection;
uniform mat4 view;
uniform mat4 model;

void main() {
    gl_Position = projection * view * model * aPos;
    TexCoord = aTexCoord;
}

