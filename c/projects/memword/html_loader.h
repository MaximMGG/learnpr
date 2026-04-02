#ifndef HTML_LOADER_H
#define HTML_LOADER_H
#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <cstdext/core.h>
#include <cstdext/container/list.h>
#include <cstdext/container/map.h>

void initHtml();
void deinitHtml();

str loadIndexHtml(List *modules);
str loadModuleHtml(str module_name, Map *content);
str loadCreateModuleHtml();
str loadCombineModuleHtml();
str loadDeleteModuleHtml();

#endif// HTML_LOADER_H
