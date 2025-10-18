#include <cstdext/build.h>


int main() {
    exe *e = build_create_exe("app", ".", BUILD_ENTYRE_DIR);
    build_exe_set_c_standard_gcc(e, GCC_C_23);
    build_exe_link_syslib(e, "GL");
    build_exe_link_syslib(e, "glfw");
    build_exe_link_syslib(e, "cext");
    build_exe_link_syslib(e, "GLEW");
    build_exe_link_syslib(e, "spng");
    build_exe_link_syslib(e, "c");
    build_exe_compile(e);
    build_exe_execute(e);
    build_exe_cleanup(e);
    return 0;
}
