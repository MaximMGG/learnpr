package remexe

import "core:fmt"
import "core:os"
import "core:strings"
import "core:io"
import "core:bufio"

writer: bufio.Writer

print_level :: proc(level: int) {
    for i in 0..<level {
        // fmt.print(" ")
        bufio.writer_write_string(&writer, " ")
    }
}

process_dir :: proc(dir_name: string, level: int) {
    dir, d_err := os.open(dir_name)
    defer os.close(dir)
    if d_err != nil {
        bufio.writer_flush(&writer)
        fmt.eprintln("Can not open dir:", dir_name)
        os.exit(1)
    }
    print_level(level)
    // fmt.println("Check dir:", dir_name)
    bufio.writer_write_string(&writer, "Check dir: ")
    bufio.writer_write_string(&writer, dir_name)
    bufio.writer_write_byte(&writer, '\n')

    fi, fi_err := os.read_dir(dir, -1)
    defer os.file_info_slice_delete(fi)
    if fi_err != nil {
        fmt.eprintln("Can not read dir:", dir_name)
        bufio.writer_flush(&writer)
        os.exit(1)
    }

    for f in fi {
        if f.name[0] == '.' {
            continue
        }
	
        if f.is_dir {
            new_path := strings.concatenate([]string{dir_name, "/", f.name})
            process_dir(new_path, level + 1)
            delete(new_path)
            continue
        } else if (f.mode & os.S_IXUSR) != 0 {
            print_level(level)
            // fmt.println("Remove file:", f.fullpath)
            bufio.writer_write_string(&writer, "Remove file: ")
            bufio.writer_write_string(&writer, f.fullpath)
            bufio.writer_write_byte(&writer, '\n')
            os.remove(f.fullpath)
            continue
        }
    }
}

main :: proc() {
  stdout_stream := os.stream_from_handle(os.stdout)
  stdout_writer := io.to_writer(stdout_stream)
  bufio.writer_init(&writer, stdout_writer)
  defer bufio.writer_destroy(&writer)
  process_dir(".", 0)
  bufio.writer_flush(&writer)
}
