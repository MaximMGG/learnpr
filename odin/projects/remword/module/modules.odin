package module

import DB "../storage"
import "core:log"

Module :: struct {
  id: u32,
  name: string,
  content: map[string]string,
}

create :: proc(name: string, db: ^DB.Database) -> ^Module {
  m := new(Module)

  m.name = name;
  id, id_ok := DB.createNewModule(db, name)

  if id_ok != nil {
    log.error("Create new module error from DB")
    free(m)
    return nil
  }
  m.id = id
  return m;
}

load :: proc(id: u32, name: string, db: ^DB.Database) -> ^Module {
  m := new(Module)
  m.id = id
  m.name = name

  ok: DB.DatabaseError

  m.content, ok = DB.getModuleContent(db, id)
  if ok != nil {
    log.error("Load module content from DB error")
    free(m)
    return nil
  }

  return m
}

destroy :: proc(m: ^Module) {
  delete(m.content)
  free(m)
}

addWord :: proc(m: ^Module, db: ^DB.Database, word: string, translation: string) {
  m.content[word] = translation   
  ok := DB.addWord(db, m.id, word, translation)
  if ok != nil {
    log.error("Cant add word, DB problem")
  }
}

removeWord :: proc(m: ^Module, db: ^DB.Database, word: string) {
  DB.removeWord(db, word)
}

combineModules :: proc(a: ^Module, b: ^Module, db: ^DB.Database) {
  DB.combineModules(db, b.id, a.id)

  for key, val in b.content {
    a.content[key] = val
  }
}

