#include <cglm/cglm.h>
#include <stdio.h>


int main() {

  vec4 a = {6.3, 6.3, 6.3, 6.3};
  vec4 b = {2.0, 2.0, 2.0, 2.0};

  float res = glm_vec4_distance(a, b);
  printf("Distance is: %f\n", res);

  glm_vec4_inv(a);
  printf("%f %f %f %f\n", a[0], a[1], a[2], a[3]);

  vec3 c = {2.0, 2.0, 2.0};

  glm_normalize(c);
  printf("Normalize: %f %f %f\n", c[0], c[1], c[2]);




  return 0;
}
