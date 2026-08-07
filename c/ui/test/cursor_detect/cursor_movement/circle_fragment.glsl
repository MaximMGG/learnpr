#version 330 core

out vec4 FragColor;

uniform float WIDTH;
uniform float HEIGHT;

//uniform vec3 Color;

void main() {
  vec2 resolution = vec2(WIDTH, HEIGHT);
  vec2 uv = gl.FragCoord.xy / resolution * 2.0 - 1.0;
  float aspect = resolution.x / resolution.y;
  uv.x * aspect;

  float distance = 1.0 - length(uv);
  distance = step(0.0, distance);
  FragColor.rgb = vec3(distance);
  //FragColor.rgb *= color;
}
