package main


import "base:runtime"
import "core:log"
import "core:fmt"
import os "core:os/os2"
import old_os "core:os"
import "core:testing"


init_logger :: proc() -> log.Logger {
    fd: ^os.File
    fd_err: os.Error
    if os.exists("test.log") {
	fd, fd_err = os.open("test.log", os.O_APPEND | os.O_RDWR)
    } else {
	fd, fd_err = os.open("test.log", os.O_CREATE | os.O_RDWR)
    }
    if fd_err != nil {
	fmt.eprintln("Cant open file test.log")	    
    }
    defer os.close(fd)

    logger := log.create_file_logger(old_os.Handle(os.fd(fd)))
    return logger

}


main :: proc() {
    context.logger = init_logger()
    defer log.destroy_file_logger(context.logger)

    log.error("Test msg")
    log.fatal("Test msg")
    log.debug("Test msg")
    log.info("Test msg")
}

@(test)
dkjfkj :: proc(t: ^testing.T) {
    assert(2 == 2)
}
