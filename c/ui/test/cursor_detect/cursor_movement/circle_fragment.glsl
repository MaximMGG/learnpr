#version 330 core
out vec4 FragColor;

uniform vec2 center;
uniform float r;

void main() {
  vec2 pixel = gl_FragCoord.xy;

  float d = length(pixel - center);
  if (d > r) {
    discard;
  }

  FragColor = vec4(1.0, 0.0, 0.0, 0.5);
}
