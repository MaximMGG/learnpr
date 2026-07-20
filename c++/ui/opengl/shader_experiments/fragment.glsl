#version 330 core


out vec4 FragColor;

uniform vec2 aResolution;

void main() {
  //vec2 resolution = vec2(1280.0, 960.0);
  vec2 uv = gl_FragCoord.xy/aResolution.xy * 2.0 - 1.0;
  float aspect = aResolution.x / aResolution.y;
  uv.x *= aspect;

  float distance = 1.0 - length(uv);
  distance = step(0.0, distance);
  FragColor.rgb = vec3(distance) * vec3(0.8, 0.4, 0.5);
  //FragColor = vec4(0.8, 0.4, 0.5, 1.0);
}