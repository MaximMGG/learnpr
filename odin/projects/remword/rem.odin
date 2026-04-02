package remword

import "core:fmt"
import "core:log"


import MODULE "module"
import STORAGE "storage"
import NET "net"

main :: proc() {

  db, db_err := STORAGE.init("mydb", "maxim", "maxim")
  defer STORAGE.disconnect(&db)
  if db_err != nil {
    fmt.println("Connect to db error:", db_err)
    return
  }

  db_module, db_module_err := STORAGE.getModules(&db)
  defer delete(db_module)
  if db_module_err != nil {
    fmt.println("Select module from DB error:", db_module_err)
    return
  }

  fmt.println(db_module)

  n, n_err := NET.init(db_module)
  defer NET.shutdown(&n)
  if n_err != nil {
    fmt.eprintln("Inet connection error:", n_err)
    return
  }

  for {
    NET.waitNewConnection(&n)
  }

  for s in db_module {
    delete(s)
  }
}
