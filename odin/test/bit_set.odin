package bit_set_test


import "core:fmt"

flag :: enum {
  WHITE, BLUE, GREEN, RED, BLACK, YELLOW
}



main :: proc() {
  a: bit_set[flag]
  fmt.println("Empty:",a)

  a += {.GREEN}
  fmt.println("With green:", a)

  a += {.BLACK}
  fmt.println("After add black:", a)


  a -= {.RED}
  fmt.println("After menus RED:", a)

  a -= {.BLACK}
  fmt.println("After menus black:", a)


  if flag.GREEN in a {
    fmt.println("GREEN is present")
  } else if flag.BLACK in a {
    fmt.println("BLACK is present")
  }

}
