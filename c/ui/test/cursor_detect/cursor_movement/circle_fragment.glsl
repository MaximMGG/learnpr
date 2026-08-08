#version 330 core
out vec4 FragColor;

uniform vec2 circle_position;
uniform float r;

void main() {
  // vec2 uv = gl_FragCoord.xy;
  // vec2 center = circle_position;
  //
  // vec4 background_color = vec4(0.2, 0.3, 0.3, 1.0);
  //
  // float d = length(center - uv) - r;
  // float t = clamp(d, 0.0, 1.0);
  // vec4 circle_color = vec4(1.0, 0.0, 0.0, 1.0 - t);
  //
  // FragColor = mix(background_color, circle_color, circle_color.a);

  vec2 uv = gl_FragCoord.xy;
  vec2 center = circle_position;
  if (((uv.x - circle_position.x) < r) && ((uv.y - circle_position.y) < r)) {
    float d = length(center - uv) - r;
    float t = clamp(d, 0.0, 1.0);
    if (d < r) {
      FragColor = vec4(1.0, 0.0, 0.0, 1.0 - t);
    }
  } else {
    discard;
  }
}
