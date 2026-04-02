#shader vertex
#version 450 core
layout (location = 0) in vec4 uPos;

void main() {
    gl_Position = uPos;
}

#shader fragment
#version 450 core
layout (location = 0) out vec4 color;

uniform vec4 u_Color;

void main() {
    color = u_Color;
}
