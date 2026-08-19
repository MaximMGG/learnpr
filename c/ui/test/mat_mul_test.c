#include <stdio.h>
#include <cglm/cglm.h>


int main() {

  mat4 a = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16};
  mat4 b = {17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32};

  mat4 res;

  glm_mat4_mul(a, b, res);

  for(int i = 0; i < 4; i++) {
    for(int j = 0; j < 4; j++) {
      printf("[%d] - %f\n", i + j, res[i][j]);
    }
  }



  return 0;
}
