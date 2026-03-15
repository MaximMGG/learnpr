package remword

import "core:fmt"
import "core:log"


import MODULE "module"
import STORAGE "storage"
import NET "net"

main :: proc() {
  db, db_err := STORAGE.connect("mydb", "maxim", "maxim")
  if db_err != nil {
    log.error("Connect to DB error")
    return
  }

  modules: []string
  modules, db_err = STORAGE.getModules(&db)
  if db_err != nil {
    log.error("Cant load modules")
  }

  net, net_err := NET.init(modules)

  NET.waitNewConnection(&net)

}
