package remword

import "core:fmt"
import "core:log"


import MODULE "module"
import STORAGE "storage"
import NET "net"

main :: proc() {
  db, db_err := STORAGE.connect("mydb", "maxim", "maxim")
  defer STORAGE.disconnect(&db)
  if db_err != nil {
    log.error("Connect to DB error")
    return
  }

  modules: []string
  modules, db_err = STORAGE.getModules(&db)
  defer delete(modules)
  if db_err != nil {
    log.error("Cant load modules")
  }

  net_conn, net_err := NET.init(modules)
  NET.shutdown(&net_conn)

  NET.waitNewConnection(&net_conn)

}
