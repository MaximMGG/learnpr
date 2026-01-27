#include <cstdext/build.h>


void build(Args *args) {
  Exe *e = buildCreateExe(heap_allocator, "gen", "main.c");
  buildExeAddSrcDir(e, ".");
  buildExeLinkSyslib(e, "cext");
  buildExeCompile(e);
  if (buildIsArg(args, "run")) {
	buildExeRun(e);
  }
  buildExeCleanup(e);
}
