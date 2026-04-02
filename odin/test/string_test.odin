package string_test

import "core:strings"
import "core:fmt"

TEST_STRING :: "\"symbol\":\"BTCUSDT\""
MULTI_STRING : string : `
CREATE TABLE token (
  id Numeric
  price Numeric
)
`

main :: proc() {
  test := string(TEST_STRING)

  index := strings.index(test, "\":\"")
  a := strings.clone(test[index + 3:len(TEST_STRING) - 1])
  fmt.println(a)

  fmt.println(MULTI_STRING)
}
