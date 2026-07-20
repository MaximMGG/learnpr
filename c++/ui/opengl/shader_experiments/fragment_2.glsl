#version 330 core

#define PI 3.14159265259

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


vec3 colorA = vec3(0.149, 0.141, 0.912);
vec3 colorB = vec3(1.00, 0.833, 0.224);


float bounce(float x) {
  float n1 = 7.5625;
  float d1 = 2.75;

  if (x < 1 / d1) {
    return n1 * x * x;
  } else if (x < 2 / d1) {
    return n1 * (x -= 1.5 / d1) * x + 0.75;
  } else if (x < 2.5 / d1) {
    return n1 * (x -= 2.25 / d1) * x + 0.9375;
  } else {
    return n1 * (x -= 2.625 / d1) * x + 0.984375;
  }
}

void main() {
  vec2 st = gl_FragCoord.xy / u_resolution; 
  vec3 color = vec3(0.0);
  //float pct = abs(sin(u_time));

  color = mix(colorA, colorB, 0.2);
  //float x = st.x < 0.5 ? (1 - sqrt(1 - pow(2 * st.x, 2))) / 2 : (sqrt(1 - pow(-2 * st.x + 2, 2)) + 1) / 2;
  float x = bounce(st.x);
  gl_FragColor = vec4(x, color.xy, 1.0);
  
}