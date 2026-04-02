#include <cglm/cglm.h>
#include <cglm/types-struct.h>


int main() {

    mat4 a = {0};
    glm_mat4_identity(a);

    printf("%.1f %.1f %.1f %.1f\n", a[0][0], a[1][1], a[2][2], a[3][3]);

    return 0;
}
