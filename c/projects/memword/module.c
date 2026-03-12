#include "module.h"

Module *moduleLoad(Allocator *allocator, Database *db, str module_name) {
  Module *m = MAKE(allocator, Module);
  m->allocator = allocator;
  m->content = mapCreate(allocator, STR, STR, null, null);
  m->name = strCopy(allocator, module_name);

  str quary = strCreateFmt(allocator, "SELECT * FROM %s;", module_name);
  QuaryRes res = databaseExecQuaryWithRes(db, quary);
  DEALLOC(allocator, quary);

  for(i32 i = 0; i < res.rows; i++) {
    str key = strCopy(allocator, res.tuples[i][0]);
    str val = strCopy(allocator, res.tuples[i][1]);
    mapPut(m->content, key, val);
  }

  databaseClearQuaryRes(allocator, &res);

  return m;
}

void moduleFree(Module *module) {
  DEALLOC(module->allocator, module->name);
  mapDestroy(module->content);
  DEALLOC(module->allocator, module);
}

void moduleAddWord(Module *module, Database *db, str word, str translation) {
  str key = strCopy(module->allocator, word);
  str val = strCopy(module->allocator, translation);
  mapPut(module->content, key, val);

  str quary = strCreateFmt(module->allocator, 
      "INSERT INTO %s(word, translation) VALUES('%s', '%s');", module->name, key, val);
  databaseExecQuaryWithoutRes(db, quary);
  DEALLOC(module->allocator, quary);
}

void moduleRemoveWord(Module *module, Database *db, str word) {
  mapRemove(module->content, word);

  str quary = strCreateFmt(module->allocator, "REMOVE FROM %s WHERE word='%s';", module->name, word);
  databaseExecQuaryWithoutRes(db, quary);
  DEALLOC(module->allocator, quary);
}

void moduleCombine(Module *a, Module *b, Database *db) {
  Iterator *it = mapIterator(b->content);
  while(mapItNext(it)) {
    mapPut(a->content, strCopy(a->allocator, it->key), strCopy(a->allocator, it->val));
  }
  mapItDestroy(it);
}
