package rpc

import "core:encoding/json"
import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:bufio"

rpc_error :: enum {
  Did_not_find_separator,
  Cant_parse_int,
  Cant_unmarshal_content
}

cut :: proc(msg: string, sub: string) -> ([]u8, []u8, u32) {
  index := strings.index(msg, sub)
  if index == -1 {
    return []u8{}, []u8{}, 0
  }
  first := strings.clone(msg[0:index])
  second := strings.clone(msg[index + len(sub):])
  return transmute([]u8)first, transmute([]u8)second, u32(index)
}


encodeMessage :: proc(msg: any) -> string {
  content, err := json.marshal(msg)
  defer delete(content)
  if err != nil {
    panic("Error")
  }

  return fmt.aprintf("Content-Length: %d\r\n\r\n%s", len(content), content)
}

BaseMessage :: struct {
  method: string,
}

decodeMessage :: proc(msg: []u8) -> (string, []u8, rpc_error) {
  header, content, found := cut(transmute(string)msg, "\r\n\r\n")
  if found == 0 {
    return "", []u8{}, rpc_error.Did_not_find_separator
  }
  defer {
    delete(header)
  }
  content_length_bytes := header[len("Content-Length: "):]
  content_length, err := strconv.parse_int(transmute(string)content_length_bytes, 10)
  if !err {
    return "", []u8{}, rpc_error.Cant_parse_int
  }

  base_message: BaseMessage
  defer delete(base_message.method)
  unmarshal_err := json.unmarshal(content[:content_length], &base_message)
  if unmarshal_err != nil {
    return "", []u8{}, rpc_error.Cant_unmarshal_content
  }

  return strings.clone(base_message.method), content[0:content_length], nil
}

split :: proc(data: []u8, _: bool) -> (advance: int, token: []u8, err: bufio.Scanner_Error, final_token: bool) {
  header, content, found := cut(transmute(string)data, "\r\n\r\n")
  if found == 0 {
    return 0, nil, bufio.Scanner_Extra_Error.Negative_Advance, false
  }
  defer {
    delete(header)
  }
  content_length_bytes := header[len("Content-Length: "):]
  content_length, content_length_err := strconv.parse_int(transmute(string)content_length_bytes, 10)
  if !content_length_err {
    return 0, nil, bufio.Scanner_Extra_Error.Negative_Advance, false
  }
  if (len(content) < content_length) {
    return 0, nil, nil, false

  }

  total_length := len(header) + 4 + content_length

  return total_length, content[0:total_length], nil, false
}
