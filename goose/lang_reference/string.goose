import std;



fn main() {
  var s: u8[>..] = [];
  s.append("YYaaa ");
  format(s, "Hello ", "world! ", 8 * 8);
  print(s, " [", s.len, " bytes]");


  let line = " key = some value   ";
  let body = trim(line);
  let eq = find(body, "=");
  print("'", trim(body[..eq]), "' -> '", trim(body[eq + 1..]), "'");

  let parts = split("alice,30,paris", ',');
  print(parts.len, " parts: ", parts);


  let cmd = words("  go   west");
  print(cmd.len, " words: ", cmd);
  main2();
}



struct Person {
  name: u8[..16],
  age: i32
}


fn format(out: u8[>..]&, p: Person) {
  format(out, p.name, " (", p.age, ")");
}

fn main2() {
  var people: Person[>..] = [];
  people.push(Person{name: "ada", age: 34});
  people.push(Person{name: "Bob", age: 44});
  var p = Person{name: "", age: 20};
  format(p.name, "Linus");
  people.push(p);
  print(people);

  let who = if people.len > 3 { "a crowd"} else {people[1].name};
  print(who);
}
