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
  method, content, err := rpc.decodeMessage(transmute([]u8)incomming_message)
  defer {
    delete(method)
    delete(content)
  }
  if err != nil {
    testing.fail_now(t, "Error")
  }
  testing.expectf(t, len(content) == 15, "Expected length: %d, Actual length: %d", 15, len(content))

}
