#version 330 core


out vec4 FragColor;

uniform vec2 aResolution;
uniform vec2 aMouse;
uniform float aTime;

void main() {

  vec2 uv = gl_FragCoord.xy/aResolution.xy * 2.0 - 1.0;
  float aspect = aResolution.x / aResolution.y;
  uv.x *= aspect;

  //thickness = 1.0;
  float fade = 0.005;
  float thickness = aMouse.x / aResolution.x + fade;

  float distance = 1.0 - length(uv);
  vec3 col = vec3(smoothstep(0.0, fade, distance));
  col *= vec3(smoothstep(thickness + fade, thickness, distance));
  FragColor.rgb = col;
  FragColor.rgb *= vec3(abs(cos(aTime)), cos(aTime), 0.5);
}