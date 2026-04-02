#version 450 core
layout (location = 0) in vec3 aPos;

uniform mat4 uModel;
uniform mat4 uPorj;

void main() {
    gl_Position = uPorj * uModel * vec4(aPos, 1.0);
}
