module main

struct Point_m {
	x int
	y int
}

struct Employee {
	type string
	name string
}

struct Foo {
mut:
	x int
}

fn head_struct() {
	fa := Foo{1}
	mut a := fa
	a.x = 2
	assert fa.x == 1
	assert a.x == 2

	mut fc := Foo{1}
	mut c := &fc
	c.x = 2
	assert fc.x == 2
	assert c.x == 2

	println(fc)
	println(c)
}

fn main() {
	mut p := Point_m{
		x: 10
		y: 20
	}
	println(p.x)
	p = Point_m{10, 20}
	assert p.x == 10

	employee := Employee{
		type: 'FTE'
		name: 'john doe'
	}

	println('${employee.type}')

	p2 := &Point_m{10, 10}
	println(p2.x)
	println("Heap struct")
	head_struct()
}


