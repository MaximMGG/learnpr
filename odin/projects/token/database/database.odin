package database

import "core:log"
import qe "quary_engine"

connect :: proc(dbname: string, user_name: string, user_password: string) -> ^qe.Database {
  db, db_ok := qe.engine_connect(dbname, user_name, user_password)
  if !db_ok {

  }
  log.info("Connect to DB")
  return db
}
