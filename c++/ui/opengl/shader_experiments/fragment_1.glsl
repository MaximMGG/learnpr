#version 330 core


#define PI 3.14159265259

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

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


float plot(vec2 st, float pct) {
  return smoothstep(pct - 0.02, pct, st.y) - smoothstep(pct, pct + 0.02, st.y);
}


void main() {

  vec2 st = gl_FragCoord.xy / u_resolution;
  //float y = pow(st.x, 5.0); //backgraund color
  //float y = smoothstep(0.1, 0.9, st.x);
  //float y = step(0.5, st.x);
  //float y = fract(abs(sin(st.x / 0.1)));
  //float y = mod(st.x, 0.5);
  //float y = fract(st.x);
  float y = bounce(st.x);
  vec3 color = vec3(y);


  //Plot a line
  float pct = plot(st, y);
  color = (1.0 - pct) * color + pct * vec3(0.0, 1.0, 0.0);
  gl_FragColor = vec4(color, 1.0);
}