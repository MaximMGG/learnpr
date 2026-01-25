#include <cstdext/build.h>

void build(Args args) {
  Exe *e = buildCreateExe(heap_allocator, "cube", "main.c");
  buildExeAddSrc(e, "main.c");
  buildExeLinkLocallib(e, "../lib/", "util");
  buildExeLinkSyslib(e, "GL", "GLEW", "glfw", "cext", "m");
  buildExeCompile(e);
}
