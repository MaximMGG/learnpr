package token

import "core:fmt"
import "core:os"
import "core:encoding/json"
import "core:c"
//import "../tokens"

foreign import lib {
    "system:ncurses",
}

WINDOW :: struct {}

@(default_calling_convention="c")
foreign lib {
    initscr :: proc() -> ^WINDOW ---
    raw :: proc() -> c.int ---
    noecho :: proc() -> c.int ---
    echo :: proc() -> c.int ---
    ebreak :: proc() -> c.int ---
    timeout :: proc(delay: c.int) ---
    refresh :: proc() -> c.int ---
    wrefresh :: proc(win: ^WINDOW) -> c.int ---
    clear :: proc() -> c.int ---
    wclear :: proc(win: ^WINDOW) -> c.int ---
    getch :: proc() -> c.int ---
    wgetch :: proc(win: ^WINDOW) -> c.int ---
    printw :: proc(fmt: cstring, agrs: ..any) -> c.int ---
    wprintw :: proc(win: ^WINDOW, fmt: cstring, args: ..any) -> c.int ---
    mvprintw :: proc(y, x: c.int , fmt: cstring, args: ..any) -> c.int ---
    mvwprintw :: proc(win: ^WINDOW, y, x: c.int , fmt: cstring, args: ..any) -> c.int ---
    endwin :: proc() -> c.int ---
}
    

Window :: struct {
    config: json.Value,
//    tokens: [dynamic]token.Token,
}

windowInit :: proc() {
    initscr()
    raw()
    noecho()

    refresh()
}

windowDraw :: proc() {
    clear()
    mvprintw(2, 2, "Hello %s", "world")
    refresh()
}

windowDestroy :: proc() {
    endwin()
}


windowParseConfig :: proc() {
    file, file_err := os.open("./config.json", os.O_RDONLY)
    if file_err != nil {
	fmt.eprintln("Cant open file config.json")
	return
    }
    defer os.close(file)

    stat, stat_err := os.fstat(file)
    defer os.file_info_delete(stat)
    if stat_err != nil {
	fmt.eprintln("Cant take stat from config.json file")
	return
    }
    
    buf := make([]u8, stat.size)
    defer delete(buf)

    os.read(file, buf)

    json_parser := json.make_parser(buf)
    json_object, json_object_err := json.parse_object(&json_parser)
    if json_object_err != nil {
	fmt.eprintln("Cant parse json config.json")
	return
    }
    defer json.destroy_value(json_object)

    tokens := json_object.(json.Object)
    tokens_arr := tokens["tokens"].(json.Array)

    for t in tokens_arr {
	fmt.println(t)
    }
}
