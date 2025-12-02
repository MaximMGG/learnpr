package main
import DB "database"
import "core:fmt"


main :: proc() {
  conn := DB.PQconnectdb("dbname=mydb user=maxim password=maxim")
  defer DB.PQfinish(conn)
  if DB.PQstatus(conn) != DB.CONNECTION_OK {
    fmt.eprintln("Connection bad")
  }

  res := DB.PQexec(conn, "select * from token")
  if DB.PQresultStatus(res) != DB.PGRES_TUPLES_OK {
    fmt.eprintln("PQexe failed:", DB.PQerrorMessage(conn))
    return
  }
  fmt.println("Connected to DB")

  rows := DB.PQntuples(res)

  for i in 0..<rows {
    fmt.println(DB.PQgetvalue(res, i, 0))
    fmt.println(DB.PQgetvalue(res, i, 1))
  }
  DB.PQclear(res)

}
