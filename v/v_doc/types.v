
struct User {
	x int
	y f64
}

struct SuperUser {
  age int
  name string
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

fn multy_array() {
  mut a := [][]int{len: 2, init: []int{len: 3}}
  for i in 0 .. a.len {
    for j in 0 .. a[i].len {
      a[i][j] = j * i + i
    }
  }
  println("${a}")

  mut b := [][][]int{}
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

fn arr_methods() {
  arr := [1, 2, 3, 4, 5, 6, 7]

  arr2 := arr.filter(it % 2 == 0)
  println("before fileter -> ${arr}\nAfter filter -> ${arr2}")


  words := ['hello', 'world']
  upper := words.map(it.to_upper())
  println("Before mapping -> ${words}\nAfter mapping -> ${upper}")
  
  mut for_sort := [12, 3, 5, 9, 3, 1, 8, 4, 5, 6, 1, 2, 9, 78, 4245, 234, 999, 0]
  println("Before sorting -> ${for_sort}")
  for_sort.sort(a < b)
  println("After sorting -> ${for_sort}")

  mut users := [SuperUser{21, 'Bob'}, SuperUser{33, 'Mulkya'}, SuperUser{10, "Ashly"}]
  println("Users ${users}")
  users.sort(a.age < b.age)
  println("Sort by age: ${users}")
  users.sort(a.name > b.name)
  println("Sort by name: ${users}")

  custom_sort_fn := fn (a &SuperUser, b &SuperUser) int {
    if a.name == b.name {
      if a.age < b.age {
        return 1
      }
      if a.age > b.age {
        return -1
      }
      return 0
    }
    if a.name < b.name {
      return -1
    } else if a.name > b.name {
      return 1
    }
    return 0
  }


  users.sort_with_compare(custom_sort_fn)
  println("After custom sort fn -> ${users}")
  
}

fn safe_slice() {
  mut a := [0, 1, 2, 3, 4, 5, 6, 7]

  mut b := a[2..4].clone()
  b[0] = 7
  println(a)
  b << 9
  println(a)
  println(b)

}

fn unsafe_slice() {
  mut a := [0, 1, 2, 3, 4, 5, 6, 7]

  mut b := unsafe { a[2..4]}
  b[0] = 7
  println(a)
  b << 9
  println(a)
  println(b)
}

fn unsafe_slice2() {
  mut a := []int{len: 5, cap: 6, init: 2}
  mut b := unsafe {a[1..4]}

  a << 3
  b[2] = 13

  a << 4

  b[1] = 99
  println(a)
  println(b)

}

fn array_negative() {
  a := []int{len: 10, init: index}
  println(a#[-3..])
  println(a[a.len - 3..])
  println(a#[-10..-8])

}

fn array_chaining() {

  files := ['pippo.jpg', '01.bmp', '_v.txt', 'img_02.jpg', 'img_01.JPG']

  arr := files.filter(it#[-4..].to_lower() == '.jpg').map(it.to_upper())
  println(arr)
}


fn map_simple() {
  pair := {
    'one': 1
    'two': 2
  }

  println(pair)

  val := pair['oijj'] or {123}
  println(val)

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
  println("Array methods")
  arr_methods()
  println("Unsafe slice")
  unsafe_slice()
  println("Safe slice")
  safe_slice()
  println("Unsafe slice 2")
  unsafe_slice2()
  println("Array # negative")
  array_negative()
  println("Array chaining")
  array_chaining()
  println("Map simple")
  map_simple()
}
