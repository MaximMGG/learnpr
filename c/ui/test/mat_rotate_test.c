#include <stdio.h>
#include <cglm/cglm.h>



int main() {
  mat4 a;
  a[0][0] = 2;
  a[0][1] = 4;
  a[0][2] = 6;
  a[0][3] = 8;
  a[1][0] = 10;
  a[1][1] = 12;
  a[1][2] = 14;
  a[1][3] = 16;
  a[2][0] = 18;
  a[2][1] = 20;
  a[2][2] = 22;
  a[2][3] = 24;
  a[3][0] = 26;
  a[3][1] = 28;
  a[3][2] = 30;
  a[3][3] = 32;


  mat4 s = GLM_MAT4_IDENTITY_INIT;

  glm_rotate(s, glm_rad(45.0), (vec3){1.0, 0.5, 0.8});

  // mat4 res;
  // glm_mat4_mul(s, a, res);


  for(int i = 0; i < 4; i++) {
    for(int j = 0; j < 4; j++) {
      printf("%f\n", s[i][j]);
    }
  }


  return 0;
}
