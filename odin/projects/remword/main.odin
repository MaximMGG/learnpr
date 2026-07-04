package remword

import "core:fmt"
import "core:strings"


menu := []string {
  "Create",
  "Select",
  "Delete",
  "Exit"
}


main :: proc() {
  connstr := fmt.aprintf("dbname=mydb user=mhrun password=mhrun")
  defer delete(connstr)
  conn := PQconnectdb(cstring(raw_data(connstr)))
  if PQstatus(conn) != .CONNECTION_OK {
    fmt.eprintln("Can't connect to db")
    return
  }

  query := "SELECT * FROM words;"


  res := PQexec(conn, cstring(raw_data(query)))
  if PQresultStatus(res) != .PGRES_TUPLES_OK {
    fmt.println("PQexec with query", query, "error")
    return
  }

  rows := PQntuples(res)
  cols := PQnfields(res)

  for i in 0..<rows {
    for j in 0..<cols {
      fmt.printf("%s ", PQgetvalue(res, i, j))
    }
    fmt.println()
  }
  PQclear(res)
  PQfinish(conn)


  initscr()
  start_color()
  init_pair(1, COLOR_BLUE, COLOR_BLACK)
  init_pair(2, COLOR_BLACK, COLOR_BLUE)
  noecho()
  cbreak()
  keypad(stdscr, true)
  box(stdscr, 0, 0)
  wrefresh(stdscr)

  c := getch()
  attron(COLOR_PAIR(1))
  mvprintw(10, 10, "%c", byte(c))
  attroff(COLOR_PAIR(1))
  //wrefresh(stdscr)
  refresh()
  c = getch()
  wborder_wrapper(stdscr, ' ')
  c = getch()

  pos: int = 1
  mvprintw(25, 25, "%d", KEY_F(1))
  iner: for int(c) != KEY_F(1) {
    for i in 1..= len(menu) {
      if pos == i {
        attron(COLOR_PAIR(2))
        mvprintw(i32(i), 1, "> %s", menu[i - 1])
        attroff(COLOR_PAIR(2))
      } else {
        attron(COLOR_PAIR(1))
        mvprintw(i32(i), 1, "  %s", menu[i - 1])
        attroff(COLOR_PAIR(1))
      }
    }
    c = getch()
    switch c {
    case i32('j'):
      if pos < len(menu) {
        pos += 1
      }
    case i32('k'):
      if pos > 1 {
        pos -= 1
      }
    case i32('q'):
      break iner
    case 10:
      if pos == 4 {
        break iner
      }
    }

    mvprintw(20, 20, "%d", c)
    refresh()
  }

  endwin()
}
