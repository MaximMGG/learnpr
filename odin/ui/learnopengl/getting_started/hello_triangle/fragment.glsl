#version 330 core

out vec4 FragColor;

void main() {
  vec2 resolution = vec2(640.0, 480.0);
  vec2 uv = gl_FragCoord.xy/resolution.xy * 2.0 - 1.0;
  float aspect = resolution.x / resolution.y;
  uv.x *= aspect;

  float distance = 1.0 - length(uv);
  distance = step(0.0, distance);
  FragColor.rgb = vec3(distance);

  // FragColor = vec4(1.0f, 0.5f, 0.2f, 1.0f);
  // FragColor.rg = uv;
}
