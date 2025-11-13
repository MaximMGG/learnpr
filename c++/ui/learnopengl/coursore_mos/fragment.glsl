#version 450 core

in vec2 TexCoord;

sampler2D texture1;

void main() {
    gl_FragColor = texture(texture1, TexCoord);
}
