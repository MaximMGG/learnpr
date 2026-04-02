import os

pub struct Dimension {
	width int = -1
	height int = -1
}

pub struct Test {
	Dimension
	width int = 100
}

fn test() {
  mut a := 0
	mut b := 1
	println("${a}, ${b}")
	a, b = b, a
	println("${a}, ${b}")

	mut d := Test{}
	println("${d}")
	println("${d.width}, ${d.height}, ${d.Dimension.width}")

}

fn main() {
	println(os.args)
	println(add(123123, 12123))
	println(add(888, 12))

	a, b := foo()
	println('${a}')
	println('${b}')
	c, _ := foo()
	println('${c}')
	name := 'Bob'
	mut age := 20
	large_number := i64(9999999)
	println(name)
	println(age)
	println(large_number)
	age = 12
	println(age)
	num := i32(333)
	println(num)
	println(typeof(num).name)
	println("Run test func")
	test()
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
