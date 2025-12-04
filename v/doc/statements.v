
struct My_User {
  name string
}


fn main() {
  arr := [My_User{'John'}]
  u_name := if v := arr[0] {
    v.name
  } else {
    "Unnamed"
  }
  println(u_name)

	println("Args")
	args()
	println("if unwraped")
	if_unwraped()
	println("Type checks")
	type_checks()
	struct_fields_check()
	println("Match os example")
	match_example()
	println("in examples")
	in_examples()
}


fn args() {
	n := arguments().len
	x := if n > 2 {
		dump(arguments())
		42
	} else {
		println("Something else")
		100
	}
	dump(x)
}

struct User2 {
	name string
}


fn if_unwraped() {
	arr := [User2{"John"}]

	u_name := if v := arr[0] {
		v.name
	} else {
		"Unnamed"
	}
	println(u_name)
}

struct Abc {
	val string
}

struct Xyz {
	foo string
}

type Alphabet = Abc | Xyz

fn type_checks() {
	x := Alphabet(Abc{"test"})

	if x is Abc {
		println(x)
	}

	if x !is Abc {
		println("Not Abc")
	}

	match x {
		Abc {
			dump(x)
		}
		Xyz {
			dump(x)
		}
	}
}

struct MyStruct1 {
	x int
}

struct MyStruct2 {
	y string
}

type MySumType = MyStruct1 | MyStruct2

struct Aaa {
	bar MySumType
}

fn struct_fields_check() {
	x := Aaa{
		bar: MyStruct1{123}
	}
	if x.bar is MyStruct1 {
		println(x.bar)
	} else if x.bar is MyStruct2 {
		new_var := x.bar as MyStruct2
		println(new_var)
	}

	println("Match")

	match x.bar {
		MyStruct1 {
			println(x.bar)
		}
		MyStruct2 {
			x.bar
		}
	}
}


const start = 1
const end = 10


fn match_example() {
	os := "linux"
	print("V is running on ")
	match os {
		"drawin" { println("macOs.")}
		"linux" { println("Linux.")}
		else {
			println(os)
		}
	}

	number := 2
	s := match number {
		1 {'one'}
		2 {'two'}
		else {'many'}
	}
	println(s)

	// match true {
	// 	2 > 4 {println("if")}
	// 	3 == 4 {println("else if")}
	// 	2 == 2 {println("else if 2")}
	// 	else {println("else") }
	// }
	println(is_red_or_blue(.red))
	println(is_red_or_blue(.green))

	c := `v`
	typ := match c {
		`0`...`9` {'digit'}
		`A`...`Z` {'uppercase'}
		`a`...`z` {'lowercase'}
		else {'other'}
	}

	println(typ)

	a := Animal(Veasel{})

	match a {
		Dog{println("Bay")}
		Cat{println("Meow")}
		Veasel{println("Vrrrrr-eee")}
	}

	i := 2
	num := match i {
		start...end {
			1000
		}
		else {
			0
		}
	}
	println(num)

	// for q in 0..1000 {
	// 	match q {
	// 		0...100 {
	// 			println("Near 100")
	// 		}
	// 		101...1000 {
	// 			println("Upper 1000")
	// 		}
	// 		else {
	// 			println("else")
	// 		}
	// 	}
	// }
}

struct Dog{}
struct Cat{}
struct Veasel {}
type Animal = Dog | Cat | Veasel

enum Color {
	red blue green
}


fn is_red_or_blue(c Color) bool {
	return match c {
		.red, .blue {true}
		.green {false}
	}
}


fn in_examples() {
	nums := [1, 2, 3]
	println(1 in nums)
	println(5 !in nums)

	m := {
		'one': 1
		'two': 2
	}

	println('one' in m)
	println('tree' in m)

	parser := Parser{token: .minus}

	if parser.token in [.plus, .minus, .div, .mult] {
		println("${parser.token} in Token")

	}
}

enum Token {
	plus minus div mult
}

struct Parser{
	token Token
}




