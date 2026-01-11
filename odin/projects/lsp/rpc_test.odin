package lsp

import "rpc"
import "core:testing"

encodeingExample :: struct {
  testing: bool
}

@(test)
test_encode :: proc(t: ^testing.T) {
  expected := "Content-Length: 15\r\n\r\n{\"method\":\"hi\"}"
  actual := rpc.encodeMessage(rpc.BaseMessage{method = "hi"})
  defer delete(actual)
  testing.expectf(t, expected == actual, "Expected: %s, Actual: %s", expected,
    actual)
}

@(test)
test_decode :: proc(t: ^testing.T) {
  incomming_message := "Content-Length: 15\r\n\r\n{\"method\":\"hi\"}"
  method, content_length, err := rpc.decodeMessage(transmute([]u8)incomming_message)
  defer delete(method)
  if err != nil {
    testing.fail_now(t, "Error")
  }
  testing.expectf(t, content_length == 15, "Expected length: %d, Actual length: %d", 15, content_length)

}
