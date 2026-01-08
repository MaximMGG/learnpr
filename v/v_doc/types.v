struct User {
	x int
	y f64
}

fn formatting() {
	x := 123.4567
  print('x:.2\t:')
	println('[${x:.2}]')
	print('x:10\t:')
	println('[${x:10}]')
	print('int(x):-10\t:')
	println('[${int(x):-10}]')
	print('int(x):010\t:')
	println('[${int(x):010}]')
	print('int(x):b\t:')
	println('[${int(x):b}]')
	print('int(x):o\t:')
	println('[${int(x):o}]')
	print('int(x):x\t:')
	println('[${int(x):x}]')

	println('[${10.0000:.2}]')
	println('[${10.0000:.2f}]')
	u := User{
		x: 1
		y: 1.1
	}

	println('${u.x}')
	println('${'abd':3r}')
	println('${'abd':3R}')
}

fn string_operations() {
	name := 'bob'
	bobby := name + 'by'
	println(bobby)
	mut s := 'hello '
	s += 'world'
	println('${s}')

	age := 10
	// println('age = ' + age) -> this is error
	println('age = ${age}') // this is good
}

fn arrays() {
	mut num := [1, 2, 3]
	num << 88
	println(num)
	num << [4, 5, 6]
	println(num)
  arr := []int{len: 5, init: index}

  println("${arr}")
}


fn multy_array() {
  mut a := [][]int{len: 2, init: []int{len: 3}}
  for i in 0 .. a.len {
    for j in 0 .. a[i].len {
      a[i][j] = j * i + i
    }
  }
  println("${a}")

  mut b := [][][]int{len: 2, init: [][]int{len: 3, init: []int{len: 3, init: 0}}}
  mut index := i32(0)

  for mut i in b {
    for mut j in i {
      for mut k in j {
        k = index
        index++
      }
    }
  }
  println("${b}")
}


fn main() {
	s := 'hello'
	assert s.len == 5

	arr := s.bytes()
	assert arr.len == 5

	println('${s}, ${arr}')

	s1 := arr.bytestr()
	s3 := r'hello\nworld'

	assert s == s1
	println('${s3}')

	o := 'age = ${arr.len}'
	println('${o}')
	formatting()
	string_operations()
	arrays()
  println("Multy arrays")
  multy_array()
}
