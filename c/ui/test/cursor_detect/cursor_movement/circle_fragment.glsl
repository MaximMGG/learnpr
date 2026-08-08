#version 330 core
out vec4 FragColor;

uniform vec2 circle_position;
uniform float r;

void main() {
  vec2 pixel = gl_FragCoord.xy;
  float distance = length(pixel - circle_position);
  if (distance > r) {
    discard;
  }

  FragColor = vec4(1.0, 0.5, 0.5, 1.0);
}
