#include "module.h"

u32 moduleGetModuleId(Database *db, str module_name) {
  str quary = strCreateFmt("SELECT module_id FROM module WHERE module_name='%s'", module_name);
  QuaryRes qr = databaseExecQuaryWithRes(db, quary);
  dealloc(quary);

  u32 module_id = (u32)atol(qr.tuples[0][0]);
  databaseClearQuaryRes(&qr);
  return module_id;
}

Module *moduleLoad(Database *db, str module_name) {
  Module *m = make(Module);
  m->content = mapCreate(STR, STR, null, null);
  m->name = strCopy(module_name);
  u32 module_id = moduleGetModuleId(db, module_name);
  m->id = module_id;
  str quary = strCreateFmt("SELECT words FROM words WHERE module_id=%d;", module_id);
  QuaryRes res = databaseExecQuaryWithRes(db, quary);
  dealloc(quary);

  for(i32 i = 0; i < res.rows; i++) {
    str key = strCopy(res.tuples[i][0]);
    str val = strCopy(res.tuples[i][1]);
    mapPut(m->content, key, val);
  }

  databaseClearQuaryRes(&res);

  return m;
}

void moduleFree(Module *module) {
  dealloc(module->name);

  Iterator *it = mapIterator(module->content);

  while(mapItNext(it)) {
	dealloc(it->key);
	dealloc(it->val);
  }
  mapItDestroy(it);
  mapDestroy(module->content);
  dealloc(module);
}

void moduleAddWord(Module *module, Database *db, str word, str translation) {
  str key = strCopy(word);
  str val = strCopy(translation);
  mapPut(module->content, key, val);

  str quary = strCreateFmt("INSERT INTO words (module_id, word, translation) VALUES(%d, '%s', '%s');", module->id, key, val);
  databaseExecQuaryWithoutRes(db, quary);
  dealloc(quary);
}

void moduleRemoveWord(Module *module, Database *db, str word) {
  mapRemove(module->content, word);

  str quary = strCreateFmt("REMOVE FROM words WHERE word='%s' AND module_id=%d;", word, module->id);
  databaseExecQuaryWithoutRes(db, quary);
  dealloc(quary);
}

void moduleCombine(Module *a, Module *b, Database *db) {
  Iterator *it = mapIterator(b->content);
  while(mapItNext(it)) {
    mapPut(a->content, strCopy(it->key), strCopy(it->val));
  }

  str quary = strCreateFmt("UPDATE words SET module_id=%d WHERE module_id=%d", a->id, b->id);
  databaseExecQuaryWithoutRes(db, quary);
  dealloc(quary);
  quary = strCreateFmt("REMOVE FROM modules WHERE id=%d", b->id);
  databaseExecQuaryWithoutRes(db, quary);
  dealloc(quary);
  mapItDestroy(it);
}

