package main


import "../rpc"
import "core:fmt"
import "core:bufio"
import "core:io"
import "core:os"

main :: proc() {
  fmt.println("Hi")

  stdin_stream := os.stream_from_handle(os.stdin)
  stdin_reader := io.to_reader(stdin_stream)
  stdin_scanner: bufio.Scanner

  // Split_Proc :: proc(data: []byte, at_eof: bool) -> (advance: int, token: []byte, err: Scanner_Error, final_token: bool)
  scanner := bufio.scanner_init(&stdin_scanner, stdin_reader)
  defer bufio.scanner_destroy(scanner)
  scanner.split = rpc.split

  for bufio.scanner_scan(scanner) {
    msg := scanner.token
    handle_message(msg)
  }
}


handle_message :: proc(msg: any) {
  fmt.println(msg)

}

  // Split_Proc :: proc(data: []byte, at_eof: bool) -> (advance: int, token: []byte, err: Scanner_Error, final_token: bool)

