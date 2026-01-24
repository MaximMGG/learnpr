package user_group_info

import "core:fmt"
import "core:sys/posix"

foreign import c {
  "system:c",
}


spwd :: struct {
  sp_namp: ^i8,
  sp_pwdp: ^i8,

  sp_lstchg: i64,
  sp_min: i64,
  sp_max: i64,
  sp_warn: i64,

  sp_inact: i64,
  sp_expire: i64,
  sp_flag: u64
}

@(default_calling_convention="c")
foreign c {
  getspnam :: proc(name: cstring) -> ^spwd ---
  setspend :: proc() ---
  endspent :: proc() ---
}

main :: proc() {
  // n := posix.getpwnam("maxim")
  // fmt.println(n)
  // uid := posix.getpwuid(1000)
  // fmt.println(uid)

  for res: ^posix.passwd = posix.getpwent(); res != nil; res = posix.getpwent() {
    fmt.println(res)
  }
  posix.endpwent()

  fmt.println("Shadow file")


  n := getspnam("maxim")
  fmt.println(n)

}
