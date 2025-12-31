package odin_test


import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:c"
import "core:net"
import "core:mem"

import "core:log"


SSL_CTX :: rawptr
SSL :: rawptr
SSL_METHOD :: rawptr
OPENSSL_INIT_LOAD_SSL_STRINGS :: c.uint64_t(0x00200000)
OPENSSL_INIT_LOAD_CRYPTO_STRINGS :: c.uint64_t(0x00000002)

foreign import libssl {"system:ssl", "system:crypto"}

@(default_calling_convention = "c")
foreign libssl {
	OPENSSL_init_ssl :: proc(n: c.uint64_t = 0, p: rawptr = nil) -> c.int ---
	TLS_client_method :: proc() -> SSL_METHOD ---
	SSL_CTX_new :: proc(method: SSL_METHOD) -> SSL_CTX ---
	SSL_new :: proc(ctx: SSL_CTX) -> SSL ---
	SSL_set_fd :: proc(ssl: SSL, fd: i32) -> i32 ---
	SSL_connect :: proc(ssl: SSL) -> i32 ---
	SSL_shutdown :: proc(ssl: SSL) -> i32 ---
	SSL_free :: proc(ssl: SSL) ---
	SSL_CTX_free :: proc(ctx: SSL_CTX) ---
	SSL_write :: proc(ssl: SSL, buf: cstring, blen: int) -> i32 ---
	SSL_read :: proc(ssl: SSL, buf: rawptr, num: int) -> i32 ---
}

SSL_library_init :: #force_inline proc() {
	OPENSSL_init_ssl(0, nil)
}

SSL_load_error_strings :: proc() {
	OPENSSL_init_ssl(OPENSSL_INIT_LOAD_SSL_STRINGS | OPENSSL_INIT_LOAD_CRYPTO_STRINGS, nil)
}

foreign import ncurses {
	"system:ncurses",
}

WINDOW :: struct {}

@(default_calling_convention = "c")
foreign ncurses {
  COLS: c.int
  LINES: c.int
  stdscr: ^WINDOW
  initscr :: proc() -> ^WINDOW ---
  raw :: proc() -> c.int ---
  cbreak :: proc() -> c.int ---
  timeout :: proc(delay: c.int) ---
  noecho :: proc() -> c.int ---
  keypad :: proc(widnow: ^WINDOW, param: c.bool) -> c.int ---
  wrefresh :: proc(win: ^WINDOW) -> c.int ---
  mvwprintw :: proc(windwo: ^WINDOW, y: c.int, x: c.int, fmt: cstring, #c_vararg args: ..any) -> c.int ---
  mvprintw :: proc(y: c.int, x: c.int, fmt: cstring, #c_vararg args: ..any) -> c.int ---
  box :: proc(win: ^WINDOW, verch: c.char, horch: c.char) -> c.int ---
  border :: proc(ls, rc, ts, bs, tl, tr, bl, br: c.char) -> c.int ---
  wborder :: proc(win: ^WINDOW, ls, rc, ts, bs, tl, tr, bl, br: c.char) -> c.int ---
  move :: proc(y, x: c.int) -> c.int ---
  wmove :: proc(win: ^WINDOW, y, x: c.int) -> c.int ---
  addch :: proc(ch: c.char) -> c.int ---
  waddch :: proc(win: ^WINDOW, ch: c.char) -> c.int ---
  mvwaddch :: proc(win: ^WINDOW, y, x: c.int, ch: c.char) -> c.int ---
  mvaddch :: proc(y, x: c.int, ch: c.char) -> c.int ---
  newwin :: proc(nlines, ncols, begin_y, begin_x: c.int) -> ^WINDOW ---
  delwin :: proc(win: ^WINDOW) -> c.int ---
  endwin :: proc() -> c.int ---
  wgetch :: proc(win: ^WINDOW) -> c.int ---
  wclear :: proc(win: ^WINDOW) -> c.int ---
}

clear :: #force_inline proc() -> c.int {
	return wclear(stdscr)
}

refresh :: #force_inline proc() -> c.int {
  return wrefresh(stdscr)
}

getch :: #force_inline proc() -> c.int {
		return wgetch(stdscr)
}

Ticker :: struct {
    id: i32,
    priceChange: f64,
    priceChangePercent: f64,
    weightedAvgPrice: f64,
    openPrice: f64,
    highPrice: f64,
    lowPrice: f64,
    lastPrice: f64,
    volume: f64,
    quoteVolume: f64,
    openTime: i64,
    closeTime: i64,
    firstId: i64,
    lastId: i64,
    count: i64,
}

ticker_create :: proc(s: string, symbol_id: i32) -> ^Ticker {
  when ODIN_DEBUG {
    log.info("Enter ticker_create")
    log.info(s)
  }

  t: ^Ticker = new(Ticker)
  list := strings.split(s, ",")
  defer delete(list)
  for i in 0..<len(list) {
    switch i {
    case 0:
      t.id = symbol_id
    case 1:
      index := strings.index(list[i], "\":\"")
      t.priceChange = strconv.parse_f64(list[i][index + 3:len(list[i]) - 1]) or_else 0
    case 2:
      index := strings.index(list[i], "\":\"")
      t.priceChangePercent = strconv.parse_f64(list[i][index + 3:len(list[i]) - 1]) or_else 0
    case 3:
      index := strings.index(list[i], "\":\"")
      t.weightedAvgPrice = strconv.parse_f64(list[i][index + 3:len(list[i]) - 1]) or_else 0
    case 4:
      index := strings.index(list[i], "\":\"")
      t.openPrice = strconv.parse_f64(list[i][index + 3:len(list[i]) - 1]) or_else 0
    case 5:
      index := strings.index(list[i], "\":\"")
      t.highPrice = strconv.parse_f64(list[i][index + 3:len(list[i]) - 1]) or_else 0
    case 6:
      index := strings.index(list[i], "\":\"")
      t.lowPrice = strconv.parse_f64(list[i][index + 3:len(list[i]) - 1]) or_else 0
    case 7:
      index := strings.index(list[i], "\":\"")
      t.lastPrice = strconv.parse_f64(list[i][index + 3:len(list[i]) - 1]) or_else 0
    case 8:
      index := strings.index(list[i], "\":\"")
      t.volume = strconv.parse_f64(list[i][index + 3:len(list[i]) - 1]) or_else 0
    case 9:
      index := strings.index(list[i], "\":\"")
      t.quoteVolume = strconv.parse_f64(list[i][index + 3:len(list[i]) - 1]) or_else 0
    case 10:
      index := strings.index(list[i], "\":")
      t.openTime = strconv.parse_i64(list[i][index + 2:len(list[i])]) or_else 0
    case 11:
      index := strings.index(list[i], "\":")
      t.closeTime = strconv.parse_i64(list[i][index + 2:len(list[i])]) or_else 0
    case 12:
      index := strings.index(list[i], "\":")
      t.firstId = strconv.parse_i64(list[i][index + 2:len(list[i])]) or_else 0
    case 13:
      index := strings.index(list[i], "\":")
      t.lastId = strconv.parse_i64(list[i][index + 2:len(list[i])]) or_else 0
    case 14:
      index := strings.index(list[i], "\":")
      t.count = strconv.parse_i64(list[i][index + 2:len(list[i]) - 1]) or_else 0
    }
  }
  return t
}

ticker_destroy :: proc(t: ^Ticker) {
  free(t)
}

HOST :: "api.binance.com"
PORT :: "443"

ssl: SSL
ctx: SSL_CTX
socket: i32

ssl_init :: proc() {
  SSL_library_init()
  SSL_load_error_strings()

  conn_str, conn_str_ok := strings.concatenate([]string{HOST, ":", PORT})
  defer delete(conn_str)
  if conn_str_ok != nil {
    fmt.eprintln("Concatenate string error")
    return
  }
  sock, sock_ok := net.dial_tcp_from_hostname_and_port_string(conn_str)
  if sock_ok != nil {
    fmt.eprintln("dial_tcp_from_hostname_and_port_string error")
    return
  }
  socket = i32(sock)

  ctx = SSL_CTX_new(TLS_client_method())
  if ctx == nil {
    fmt.eprintln("SSL_CTX_new error")
    net.close(net.TCP_Socket(socket))
    return
  }
  ssl = SSL_new(ctx)
  if ssl == nil {
    fmt.eprintln("SSL_new error")
    SSL_CTX_free(ctx)
    net.close(net.TCP_Socket(socket))
    return
  }

  SSL_set_fd(ssl, socket)
  if SSL_connect(ssl) <= 0 {
    fmt.eprintln("SSL_connect error")
    SSL_free(ssl)
    SSL_CTX_free(ctx)
    net.close(net.TCP_Socket(socket))
    return
  }
}

ssl_deinit :: proc() {
  SSL_shutdown(ssl)
  SSL_free(ssl)
  SSL_CTX_free(ctx)
  net.close(net.TCP_Socket(socket))
}

DRAW_HEADER: cstring : "%-20s %-20s %-20s %-20s"
DRAW_FMT: cstring : "%-20s %-20lf %-20lf %-20s"

ncurses_init :: proc() {
  initscr()
  raw()
  noecho()
  keypad(stdscr, true)
  timeout(50)
  refresh()
}

ncurses_deinit :: proc() {
  endwin()
}


main :: proc() {

  when ODIN_DEBUG {
    tracking_allocator: mem.Tracking_Allocator
    mem.tracking_allocator_init(&tracking_allocator, context.allocator)
    context.allocator = mem.tracking_allocator(&tracking_allocator)
    defer mem.tracking_allocator_destroy(&tracking_allocator)
  }

  ssl_init()
  defer ssl_deinit()

  ncurses_init()
  defer ncurses_deinit()

  request := "GET /api/v3/ticker?symbol=BTCUSDT HTTP/1.1\r\nHost: api.binance.com\r\nConnection: keep-alive\r\n\r\n"
  response := [4096]u8{0..<4096 = 0}

  ch: c.int = 0

  for ch != 'q' {
    clear()
    write_bytes := SSL_write(ssl, cstring(raw_data(request)), len(request))
    if write_bytes <= 0 {
      fmt.eprintln("SSL_write error")
      return
    }

    read_bytes := SSL_read(ssl, &response[0], 4096)
    fmt.println("Read:", read_bytes, "bytes")

    pattern := strings.index(transmute(string)response[:read_bytes], "\r\n\r\n")
    if pattern == -1 {
      fmt.eprintln("Dont find pattern \\r\\n\\r\\n")
      break
    }

    t := ticker_create(transmute(string)response[pattern + 4:read_bytes], 1)
    defer ticker_destroy(t)

    i: c.int = 1
    j: c.int = 1

    mvprintw(i, j, DRAW_HEADER, cstring("SYMBOL"), cstring("PRICE"), cstring("VOLUME"), cstring("TEST"))
    i += 1
    mvprintw(i, j, DRAW_FMT, cstring("BTCUSDT"), t.lastPrice, t.volume, cstring("-test-"))

    refresh()
    ch = getch()
  }

  when ODIN_DEBUG {
    for _, leak in tracking_allocator.allocation_map {
      fmt.printf("%v leaked %m\n", leak.location, leak.size)
    }
  }

}
