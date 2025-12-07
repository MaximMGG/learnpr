package main
import DB "database"
import N "window"
import tk "tok"


import "core:fmt"
import "core:c"
import "core:testing"
import "core:log"
import "core:os"

LOGGER_FILE :: "token.log"


init_logger :: proc() {
    fd: os.Handle
    fd_err: os.Error
    if ok, _ := os.access(LOGGER_FILE, os.F_OK); ok {
	fd, fd_err = os.open(LOGGER_FILE, os.O_APPEND | os.O_WRONLY)
	if fd_err != nil {
	    fmt.eprintln("Open log file error: ", fd_err)
	    return
	}
    } else {
	fd, fd_err = os.open(LOGGER_FILE, os.O_CREATE | os.O_RDWR, os.S_IWUSR | os.S_IRUSR)
	if fd_err != nil {
	    fmt.eprintln("Open log file error: ", fd_err)
	    return
	}
    }

    logger := log.create_file_logger(fd, log.Level.Info)
    context.logger.data = logger.data
    context.logger.procedure = logger.procedure
    context.logger.lowest_level = logger.lowest_level
    context.logger.options = logger.options
}

deinit_logger :: proc() {
    data := cast(^log.File_Console_Logger_Data)context.logger.data
    //os.close(data.file_handle)
    log.destroy_file_logger(context.logger)
}

main :: proc() {
    init_logger()
    defer deinit_logger()

    log.info("Test info logging")
    log.warn("Test Warn logging")
    log.error("Test Error logging")
    log.fatal("Test Fatal logging")
    log.debug("Test Debug logging")
    
}

@(test)
ncureses_test :: proc(t: ^testing.T) {
    stdscr := N.initscr()
    N.raw()
    N.noecho()
    N.keypad(stdscr, true)

    ch: c.int
    for ch != 'q' {
	N.clear()
	ch = N.getch()

	N.refresh()
    }
    testing.expect_value(t, int('q'), int(ch))
    N.endwin()    
}
