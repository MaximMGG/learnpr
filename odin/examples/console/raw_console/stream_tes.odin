package stream_test


import "core:io"
import "core:fmt"
import "core:os"
import "core:bufio"

main :: proc() {
    handle, _ := os.open("raw_posix.odin", os.O_RDONLY)
    stream := os.stream_from_handle(handle)
    fi, _ := os.fstat(handle)
    buf := make_slice([]u8, fi.size)
    defer io.destroy(stream)
    
    reader := io.to_reader(stream)
    io.read_full(reader, buf[:])

    fmt.printf("%s\n", buf)
    
    delete(buf)
    os.close(handle)

    stdin := os.stream_from_handle(os.stdin)
    defer {
	io.destroy(stdin)
    }
    f, _ := os.open("test.txt", os.O_CREATE | os.O_WRONLY, os.S_IWUSR | os.S_IRUSR)
    defer os.close(f)

    f_stream := os.stream_from_handle(f)
    f_writer, _ := io.to_writer_at(f_stream)
    defer io.destroy(f_stream)
    
    
    io.copy_n(f_writer, stdin, 32)
}
