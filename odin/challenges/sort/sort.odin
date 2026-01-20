package sort


import "core:fmt"
import "core:strings"
import "core:slice"
import "core:os"
import "core:io"
import "core:bufio"
import pq "core:container/priority_queue"


less :: proc(a, b: string) -> bool {
  res := strings.compare(a, b)
  if res < 0 {
    return true
  }
  return false
}

swap :: proc(arr: []string, a, b: int) {
  slice.swap(arr, a, b)
}


put_in_queue :: proc(queue: ^pq.Priority_Queue(string), reader: ^bufio.Reader) {
  for {
    if s, err := bufio.reader_read_string(reader, '\n'); err == nil {
      pq.push(queue, s)
    } else {
      break
    }
  }
}

main :: proc() {
  args := os.args
  if len(args) < 2 {
    fmt.eprintln("Usage sort [flag?] [file]")
    return
  }

  file, file_err := os.open(args[1])
  if file_err != nil {
    fmt.eprintf("open file %s err: %v\n", args[1], file_err)
    return
  }
  defer os.close(file)
  file_stream := os.stream_from_handle(file)
  file_reader := io.to_reader(file_stream)
  reader: bufio.Reader
  bufio.reader_init(&reader, file_reader)

  queue: pq.Priority_Queue(string)
  pq.init(&queue, less, swap)
  defer pq.destroy(&queue)

  put_in_queue(&queue, &reader)

  for pq.len(queue) > 0 {
    s := pq.pop(&queue)
    defer delete(s)
    fmt.print(s)
  }
}
