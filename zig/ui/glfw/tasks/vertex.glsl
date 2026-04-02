#version 330 core
layout (location = 0) in vec4 aPos;
layout (location = 1) in vec3 aColor;


out vec4 u_Color;
uniform float u_Offset;

void main() {
    gl_Position = vec4(aPos.x + u_Offset, aPos.yzw);
    u_Color = vec4(aColor, 1.0);
}
