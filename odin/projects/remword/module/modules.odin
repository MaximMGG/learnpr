package module

import DB "../storage"
import "core:fmt"
import "core:log"
import "core:strconv"

Module :: struct {
  id: u32,
  name: string,
  content: map[string]string,
}

create :: proc(name: string, db: ^DB.Database) -> ^Module {
  m := new(Module)

  quary := fmt.aprintf("INSERT INTO modules (name) VALUES('%s');", name)
  DB.exec_quary_without_result(db, quary)
  delete(quary)
  quary = fmt.aprintf("SELECT FROM modules WHERE name='%s';", name)
  defer delete(quary)
  res, res_err := DB.exec_quary_with_result(db, quary)
  defer DB.clear_result(res)
  if res_err != nil {
    log.error("exec_quary_with_result while try to create new module:", name)
    free(m)
    return nil
  }

  m.name = name;
  val, val_ok := strconv.parse_u64(res[0][0])
  if !val_ok {
    log.error("parse_u64 faield module:", name)
    free(m)
    return nil
  }

  m.id = u32(val)

  return m;
}



load :: proc(id: u32, name: string, db: ^DB.Database) -> ^Module {
  m := new(Module)
  m.id = id
  m.name = name


  quary := fmt.aprintf("SELECT (word, translation) FROM words WHERE module_id=%d", id)
  defer delete(quary)

  res, res_err := DB.exec_quary_with_result(db, quary)

  if res_err != nil {
    log.error("exec_quary_with_result failed, id:", id)
    free(m)
    return nil
  }

  for i in 0..<len(res) {
    m.content[res[i][0]] = res[i][1]
  }

  DB.clear_result(res)

  return m
}

destroy :: proc(m: ^Module) {
  delete(m.content)
  free(m)
}

addWord :: proc(m: ^Module, db: ^DB.Database, word: string, translation: string) {
  m.content[word] = translation   

  quary := fmt.aprintf("INSERT INFO words (module_id, word, translation) VALUES(%d, '%s', '%s');", m.id, word, translation) 
  defer delete(quary)
  DB.exec_quary_without_result(db, quary)
}

removeWord :: proc(m: ^Module, db: ^DB.Database, word: string) {
  quary := fmt.aprintf("REMOVE FROM words WHERE word='%s' AND module_id=%d", word, m.id)
  DB.exec_quary_without_result(db, quary)
  delete_key(&m.content, word)
}

combineModules :: proc(a: ^Module, b: ^Module, db: ^DB.Database) {
  quary := fmt.aprintf("UPDATE words SET module_id=%d WHERE module_id=%d", a.id, b.id)
  DB.exec_quary_without_result(db, quary)
  delete(quary)

  for key, val in b.content {
    a.content[key] = val
  }
}

