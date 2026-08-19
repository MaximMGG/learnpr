#include <stdio.h>
#include <cglm/cglm.h>


int main() {

  mat4 a = {{1, 5, 9, 13}, 
            {2, 6, 10, 14}, 
            {3, 7, 11, 15}, 
            {4, 8, 12, 16}};
  mat4 res;
  glm_perspective(glm_rad(40.0), 1280.0 / 720.0, 0.1, 100.0, res);

  mat4 mul;
  glm_mat4_mul(a, res, mul);

  for(int i = 0; i < 4; i++) {
    for(int j = 0; j < 4; j++) {
      printf("[%d] -> %f\n", i * j + j, mul[i][j]);
    }
  }


  return 0;
}
