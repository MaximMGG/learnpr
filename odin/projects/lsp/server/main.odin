package main


import "../rpc"
import "core:log"
import "core:fmt"
import "core:bufio"
import "core:io"
import "core:os"
import "base:runtime"

main :: proc() {
  context.logger = get_logger("/home/maxim/learnpr/odin/projects/lsp/lsp.log")
  log.info("I, started")

  stdin_stream := os.stream_from_handle(os.stdin)
  stdin_reader := io.to_reader(stdin_stream)
  stdin_scanner: bufio.Scanner

  // Split_Proc :: proc(data: []byte, at_eof: bool) -> (advance: int, token: []byte, err: Scanner_Error, final_token: bool)
  scanner := bufio.scanner_init(&stdin_scanner, stdin_reader)
  defer bufio.scanner_destroy(scanner)
  scanner.split = rpc.split

  for bufio.scanner_scan(scanner) {
    msg := scanner.token
    handle_message(transmute(string)msg)
  }
}


handle_message :: proc(msg: any) {
  log.info(msg)
}


get_logger :: proc(file_name: string) -> runtime.Logger {
  file, file_ok := os.open(file_name, os.O_CREATE | os.O_TRUNC | os.O_RDWR, 0o666)
  if file_ok != nil {
    fmt.eprintln("Cant create file:", file_name)
  }
  logger := log.create_file_logger(file, ident = "educationlsp")
  return logger
}


