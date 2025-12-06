

struct Foo2 {
	n int @[required]
	s string
	a []int
	pos int = -1
}


struct User3 {
	name string
	age int
	is_registered bool
}

fn register(u User3) User3 {
	return User3{
		...u
		is_registered: true
	}
}

@[params]
struct ButtonConfig {
	text string
	id_disabled bool
	width int = 70
	height int = 20
}

struct Button {
	text string
	width int
	height int
}

fn new_button(c ButtonConfig) &Button {
	return &Button{
		width: c.width
		height: c.height
		text: c.text
	}
}


fn main() {
	f := Foo2{n: 123}
	println(f)
	mut user := User3{
		name: 'abc'
		age: 32
	}
	println("Before registration ${user}")
	user = register(user)
	println(user)

	button := new_button(text: 'Click me', width: 100)
	button2 := new_button()

	assert button.height == 20
	assert button2.height == 20

}
