#version 330 core
out vec4 FragColor;

// in vec3 ourColor;
// in vec2 TexCoord;


//uniform sampler2D texture1;
uniform vec4 u_Color;

void main() {
    // FragColor = texture(texture1, TexCoord);
    FragColor = u_Color;
}
