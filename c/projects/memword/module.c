#include "module.h"

Module *moduleLoad(Allocator *allocator, Database *db, u32 module_id, str module_name) {
  Module *m = MAKE(allocator, Module);
  m->allocator = allocator;
  m->content = mapCreate(allocator, STR, STR, null, null);
  m->name = strCopy(allocator, module_name);

  str quary = strCreateFmt(allocator, "SELECT words FROM words WHERE module_id=%d;", module_id);
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
      "INSERT INTO words (module_id, word, translation) VALUES(%d, '%s', '%s');", module->id, key, val);
  databaseExecQuaryWithoutRes(db, quary);
  DEALLOC(module->allocator, quary);
}

void moduleRemoveWord(Module *module, Database *db, str word) {
  mapRemove(module->content, word);

  str quary = strCreateFmt(module->allocator, "REMOVE FROM words WHERE word='%s' AND module_id=%d;", word, module->id);
  databaseExecQuaryWithoutRes(db, quary);
  DEALLOC(module->allocator, quary);
}

void moduleCombine(Module *a, Module *b, Database *db) {
  Iterator *it = mapIterator(b->content);
  while(mapItNext(it)) {
    mapPut(a->content, strCopy(a->allocator, it->key), strCopy(a->allocator, it->val));
  }

  str quary = strCreateFmt(a->allocator, "REMOVE FROM words WHERE module_id=%d", b->id);
  databaseExecQuaryWithoutRes(db, quary);
  DEALLOC(a->allocator, quary);
  quary = strCreateFmt(a->allocator, "REMOVE FROM modules WHERE id=%d", b->id);
  databaseExecQuaryWithoutRes(db, quary);
  DEALLOC(a->allocator, quary);
  mapItDestroy(it);
}
