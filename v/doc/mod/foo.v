module main
import abs

pub fn foo1() string {
	return 'This is string from foo1 module mod'
}

fn main() {
	println(foo1())
	println(abs.add_m(1, 2))
}
