package time2


import "core:time"
import "core:fmt"
import "core:os"
import "core:log"
import "core:io"

logfile :: proc(h: ^os.Handle, level: log.Level, text: string, location := #caller_location) {
    log.file_logger_proc(h, level, text, {.Level, .Date, .Time, .Line, .Procedure}, location)
}



main :: proc() {

    f, err := os.open("test.log", os.O_RDWR | os.O_CREATE | os.O_APPEND, os.S_IRUSR | os.S_IWUSR)
    defer os.close(f)
    if err != nil {
        fmt.println("Cant open test.log")
        os.exit(1)
    }

    // log.file_logger_proc(&f, .Info, "Just Info log example", {.Time})
    // log.file_logger_proc(&f, .Warning, "Just Warning log example", {.Time})
    // log.file_logger_proc(&f, .Debug, "Just Debug log example", {.Time})
    // log.file_logger_proc(&f, .Fatal, "Just Fatal log example", {})

    logfile(&f, .Debug, "Test Debug info")
    logfile(&f, .Warning, "Test Warning info")

    buf: [512]u8

    t: time.Time = time.now()
    res := time.to_string_hms(t, buf[:])

    fmt.println(res)

    test(&f)
}


test :: proc(f: ^os.Handle) {
    logfile(f, .Fatal, "Fatal from another procedure")
}
