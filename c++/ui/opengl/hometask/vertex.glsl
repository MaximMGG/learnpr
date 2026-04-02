#version 450 core
layout (location = 0) in vec4 u_Pos;

void main() {
    gl_Position = u_Pos;
};
