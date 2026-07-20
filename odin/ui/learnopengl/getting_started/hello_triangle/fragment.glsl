#version 330 core

out vec4 FragColor;
in vec2 fragCoord;

void main() {
  vec2 resolution = vec2(200.0, 100.0);
  vec2 uv = fragCoord/resolution.xy * 2.0 - 1.0;
  float aspect = resolution.x / resolution.y;
  uv.x *= aspect;


  float distance = distance(vec2(0.0), uv);
  if (distance > 0.0) {
    distance = 1.0;
  }

  FragColor.rgb = vec3(distance);

  // FragColor = vec4(1.0f, 0.5f, 0.2f, 1.0f);
  // FragColor.rg = uv;
}
