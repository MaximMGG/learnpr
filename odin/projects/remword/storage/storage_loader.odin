package storage

import "core:slice"
import "core:fmt"
import "core:strconv"


DB_CHECK_MODULE_TABLE_EXISTS : string : "SELECT COUNT(*) FROM pg_tables WHERE schemaname = 'public' AND tablename = 'modules'"
DB_CHECK_DICTIONARY_TABLE_EXISTS : string : "SELECT COUNT(*) FROM pg_tables WHERE schemaname = 'public' AND tablename = 'words'"
DB_CREATE_MODULE_TABLE : string : "CREATE TABLE module (id SIREAL PRIMARY KEY, module_name VARCHAR(64))"
DB_CREATE_WORDS_TABLE : string : "CREATE TABLE words (module_id INT FOREIGN KEY, word VARCHAR(128) NOT NULL, translation VARCHAR(128) NOT NULL);"
DB_SELECT_MODULES : string : "SELECT module_name FROM module;"
DB_SELECT_MODULE_ID : string : "SELECT module_id FROM modules WHERE module_name='%s';"




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
