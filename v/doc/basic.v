import os

fn main() {
	println('HEllo wolrd')
	println(os.args)
	println(add(123, 1))
	println(sub(33, 123))

	a, b := foo()

	println(a)
	println(b)

	mut c, _ := foo()
	c = 323

	println(c)

	println('Variables')
	variables()

	println('Initialization and mutability')
	initialization()
	println('Struct printing')
	struct_test()

	mut d := i32(1)
	println('${d}')

	hello := 'hello'
	println('String ${hello}, width length ${hello.len}')

	mut arr := hello.bytes()
	arr.sort(|a, b| a > b)
	assert arr.len == 5
	println('${arr.bytestr()}')

	mut file := os.open('./basic.v') or { return }
	file.seek(0, .end)!
	file_size := file.tell()!
	println('File basic.v has size ${file_size}')
	defer { file.close() }

	country := 'Netherlands'
	println(country[0])
	println(rune(country[0]))
	println(country[0].ascii_str())

	// file.seek(0, .start)!
	// mut buf := []u8{}
	// buf.grow_cap(int(file_size))
	// _ := file.read(mut buf)!
	// println(buf.bytestr)

	//	s2 := arr.bytestr()
	println('Format ouput')
	format_out()

  println("Array test")
  arrays_test()
}

fn add(x int, y int) int {
	return x + y
}

fn sub(x int, y int) int {
	return x - y
}

fn foo() (int, int) {
	return 2, 3
}

fn variables() {
	name := 'Bob'
	age := 20
	large_number := i64(9999999999)
	println(name)
	println(age)
	println(large_number)
}

fn initialization() {
	mut a := 0
	mut b := 1
	println('${a}, ${b}')
	a, b = b, a
	println('${a}, ${b}')
}

pub struct Dimension {
	width  int = -1
	height int = -1
}

pub struct Test {
	Dimension
	width int = 100
}

fn struct_test() {
	test := Test{}
	println('${test.width} ${test.height} ${test.Dimension.width}')
}

fn format_out() {
	symbol := 'Symbol'
	price := 'Price'
	volume := 'Volume'
	test := '-Test-'

	println('${symbol:-20} ${price:-20} ${volume:-20} ${test:-20}')

	x := 123.4567
	println('[${x:.2}]')
	println('[${x:10}]')
	println('[${int(x):-10}]')
	println('[${int(x):010}]')
	println('[${int(x):b}]')
	println('[${int(x):o}]')
	println('[${int(x):X}]')
	println('[${symbol:3R}]')

	name := 'Bob'
	bobby := name + 'by'
	println('${bobby}')

	println('${bobby} age is ${int(x).str()}')
}

fn arrays_test() {
  mut arr := [i32(1), 2, 3]
  arr << 4
  arr << [i32(5), 6, 7]
  println("${arr}")
  println(8 in arr)

  mut names := ["Peter", "John", "Mary"]
  names << "Bobby"
  println(names)
  println("billy" in names)
  if "billy" in names {
    println("Billy here")
  } else {
    println("Not here")
  }
}

