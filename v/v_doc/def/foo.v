module def


pub struct User {
pub mut:
  age int
  name string
}


pub fn (mut u User)set_name(name string) {
  u.name = name
}


pub fn func() string {
  return "Hello, from def"
}
