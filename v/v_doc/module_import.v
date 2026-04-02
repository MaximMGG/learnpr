module main

import def
import os { input, user_os }

fn main() {
	name := input('Enter your name: ')
	println('Hello ${name}')
	u_os := user_os()
	println('Your OS is: ${u_os}')

	mut u := def.User{
		age:  1
		name: 'Odymol'
	}
	u.set_name('Misha')
	s := def.func()
	println(s)
	println(u)
}
