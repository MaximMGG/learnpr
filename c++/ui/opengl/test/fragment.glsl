#version 330 core

uniform vec2 aResolution;

void main() {
     vec2 uv = gl_FragCoord.xy / aResolution * 2.0 - 1.0;
     


     gl_FragColor = vec4(0.5, 0.3, 0.3, 1.0);
}