package storage

import "core:slice"
import "core:fmt"
import "core:strconv"


DB_CHECK_MODULE_TABLE_EXISTS : string : "SELECT COUNT(*) FROM pg_tables WHERE schemaname = 'public' AND tablename = 'modules'"
DB_CHECK_DICTIONARY_TABLE_EXISTS : string : "SELECT COUNT(*) FROM pg_tables WHERE schemaname = 'public' AND tablename = 'words'"

DB_CREATE_MODULE_TABLE : string : "CREATE TABLE module (id SIREAL PRIMARY KEY, module_name VARCHAR(64))"
DB_CREATE_WORDS_TABLE : string : "CREATE TABLE words (module_id INT FOREIGN KEY, word VARCHAR(128) NOT NULL, translation VARCHAR(128) NOT NULL);"

DB_CREATE_MODULE : string : "INSERT INTO module (module_name) VALUES ('%s');"
DB_CREATE_MODULE_2 : string : "SELECT module_id FROM module WHERE module_name='%s';"

DB_SELECT_MODULES : string : "SELECT module_name FROM module;"
DB_SELECT_MODULE_ID : string : "SELECT module_id FROM modules WHERE module_name='%s';"
DB_SELECT_MODULE_CONTENT : string : "SELECT (word, translation) FROM words WHERE module_id=%d;"

DB_INSERT_WORD : string : "INSERT INTO words (module_id, word, translation) VALUES (%d, '%s', '%s');"
DB_COMBINE_MODULES : string : "UPDATE words SET module_id=%d WHERE module_id=%d;"
DB_REMOVE_WORD : string : "REMOVE FROM words WHERE word='%s';"




getModules :: proc(db: ^Database) -> ([]string, DatabaseError) {
  res, res_ok := exec_quary_with_result(db, DB_SELECT_MODULES)
  defer clear_result(res)
  if res_ok != nil {
    return []string{}, res_ok
  }

  modules: [dynamic]string
  defer delete(modules)

  for i in 0..<len(res) {
    append(&modules, res[i][0])
  }

  return slice.clone(modules[0:len(res)]), nil
}

getModuleId :: proc(db: ^Database, module_name: string) -> (u32, DatabaseError) {
  quary := fmt.aprintf(DB_SELECT_MODULE_ID, module_name)
  defer delete(quary)
  res, res_ok := exec_quary_with_result(db, quary)
  defer clear_result(res)
  if res_ok != nil {
    return 0, res_ok
  }

  id, _ := strconv.parse_u64(res[0][0])

  return u32(id), nil
}

getModuleContent :: proc(db: ^Database, module_id: u32) -> (map[string]string, DatabaseError) {
  quary := fmt.aprintf(DB_SELECT_MODULE_CONTENT, module_id)
  defer delete(quary)

  res, res_ok := exec_quary_with_result(db, quary)
  if res_ok != nil {
    return nil, res_ok
  }
  defer clear_result(res)

  content: map[string]string

  for i in 0..<len(res) {
    content[res[i][0]] = res[i][1]
  }

  return content, nil
}

addWord :: proc(db: ^Database, id: u32, word: string, trans: string) -> DatabaseError {
  quary := fmt.aprintf(DB_INSERT_WORD, id, word, trans)
  defer delete(quary)
  return exec_quary_without_result(db, quary)
}

combineModules :: proc(db: ^Database, old_id, new_id: u32) -> DatabaseError {
  quary := fmt.aprintf(DB_COMBINE_MODULES, new_id, old_id)
  defer delete(quary)
  return exec_quary_without_result(db, quary)
}

removeWord :: proc(db: ^Database, word: string) -> DatabaseError {
  quary := fmt.aprintf(DB_REMOVE_WORD, word)
  defer delete(quary)
  return exec_quary_without_result(db, quary)
}

createNewModule :: proc(db: ^Database, name: string) -> (id: u32 = 0, err: DatabaseError = nil) {
  quary := fmt.aprintf(DB_CREATE_MODULE, name)
  err = exec_quary_without_result(db, quary)
  if err != nil {
    return
  }
  delete(quary)

  quary = fmt.aprintf(DB_CREATE_MODULE_2, name)
  defer delete(quary)
  res: [][]string
  res, err = exec_quary_with_result(db, quary)
  if err != nil {
    return
  }

  tmp_id, tmp_id_ok := strconv.parse_u64(res[0][0])
  if !tmp_id_ok {
    err = .PARSE_RESULT_ERROR
    return
  }
  id = u32(tmp_id)
  return
}

