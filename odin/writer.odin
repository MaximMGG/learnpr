package writer

import "core:io"
import "core:bufio"
import "core:os"
import "core:fmt"

main :: proc() {

    s: string = "Hello world!\n"
    stream := os.stream_from_handle(os.stdout)
    writer: bufio.Writer
    bufio.writer_init(&writer, stream)
    defer bufio.writer_destroy(&writer)

    bufio.writer_write_string(&writer, s)
    bufio.writer_flush(&writer)
}
