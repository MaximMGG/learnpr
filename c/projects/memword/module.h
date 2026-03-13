#ifndef MODULE_H
#define MODULE_H
#include <cstdext/core.h>
#include <cstdext/container/map.h>
#include "database.h"

typedef struct {
  str name;
  u32 id;
  Map *content;
  Allocator *allocator;
} Module;

Module *moduleLoad(Allocator *allocator, Database *db, u32 module_id, str module_name);
void moduleFree(Module *module);
void moduleAddWord(Module *module, Database *db, str word, str translation);
void moduleRemoveWord(Module *module, Database *db, str word);
void moduleCombine(Module *a, Module *b, Database *db);

#endif
