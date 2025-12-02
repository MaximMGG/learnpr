
struct My_User {
  name string
}

struct Abs {
  zoo string
}

struct Zus {
  foo string
}

type Alphabet = Abs | Zus

fn main() {
  arr := [My_User{'John'}]
  u_name := if v := arr[0] {
    v.name
  } else {
    "Unnamed"
  }
  println(u_name)

  x := Alphabet(Abs{"abc"})

  if x is Abs {
    println(x)
  }
  if x !is Abs {
    println("Not Abs")
  }

  match x {
    Abs {
      println(x)
    }
    Zus {
      println(x)
    }
  }

}
