import std;

struct User {
  name: u8[],
  age: u32,
}

fn format(out: u8[>..]&, u: User) {
  format(out, "Name: ", u.name, ", age: ", u.age);
}

fn load(text: u8[:]) -> User[>..], u8[] {
  var users: User[>..] = [];
  var lineno = 0;
  each_split(text, '\n') {
    lineno++;
    if it.len > 0 {
      users.push(parse_record(it, lineno));
    }
  }
  return users, ""
}

fn parse_record(line: u8[], lineno: i64) -> User {
  let comma = find(line, ",");
  guard comma >= 0 else {
    return [], str("line ", lineno, ": expected name,age") from load;
  }
  let age, ok = parse_int(line[comma + 1..]);
  guard ok else {
    return [], str("line ", lineno, ": bad age") from load;
  }
  return User{trim(line[..comma]), age as u32};
}

fn main() {
  let text = "Mary,33\nBobby,22\nEhuse,31\nJuhn,99";
  let users, error = load(text);
  if error.len > 0 {
    print(error);
  }
  for u in users {
    print(u);    
  }
}
