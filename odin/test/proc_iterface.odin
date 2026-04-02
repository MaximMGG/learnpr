package proc_iterface

import "core:fmt"

User :: struct {
  _name: string,
  _age: int,
  name: proc(u: User) -> string,
  age: proc(u: User) -> int,
  set_name: proc(u: ^User, new_name: string),
  set_age: proc(u: ^User, new_age: int),
}

__name :: proc(u: User) -> string {
  return u._name
}

__age :: proc(u: User) -> int {
  return u._age
}

__set_name :: proc(u: ^User, new_name: string) {
  u._name = new_name
}

__set_age :: proc(u: ^User, new_age: int) {
  u._age = new_age
}

create_user :: proc(name: string, age: int) -> User {
  return User{
    _name = name,
    _age = age,
    name = __name,
    age = __age,
    set_name = __set_name,
    set_age = __set_age,
  }
}


main :: proc() {
  u := create_user("Bib", 12)
  fmt.println(u->name())
  u->set_name("Misha")
  fmt.println(u->name())
  u->set_age(38)
  fmt.println("User age:", u->age())

  fmt.println("Size of User:", size_of(u))
}
