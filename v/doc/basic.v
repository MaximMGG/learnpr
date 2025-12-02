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
  array_type()
  println("array_multy")
  array_multy()
  array_methods()
  println("Slice unsafe")
  slice_unsafe()
  println("Slice with negative")
  slice_with_negative()
  println("Array method chaining")
  array_method_chaining()
  println("Array with fixed size")
  array_with_fixed_size()
  println("Maps")
  maps()!
  map_nested()
  println("Map update syntax")
  map_update()
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

  mut arr2 := []int{cap: 1000}
  for i in 0 .. arr2.cap {
    arr2 << i
  }

  println(arr2)

  count := []int{len: 4, init: index}
  mut sqare := []int{len: 6, init: index * index}
  println(count)
  println(sqare)
}

struct Point {
  x int
  y int
}

struct Line {
  p1 Point
  p2 Point
}

type ObjectSumType = Line | Point

fn array_type() {
  mut object_list := []ObjectSumType{}
  object_list << Point{1, 1}
  object_list << Line{p1: Point{3, 3}, p2: Point{4, 4}}

  dump(object_list)
}

fn array_multy() {
  mut a := [][]int{len: 2, init: []int{len: 3}}
  a[0][1] = 7
  println(a)

}

struct User {
  age int
  name string
}

fn array_methods() {
  mut nums := [1, 2, 3, 4, 5, 6]
  copy := nums.filter(it % 2 == 0)
  println(nums)
  println(copy)

  even_arr := nums.filter(fn (x int) bool {
    return x % 2 == 0
  })
  println(even_arr)

  words := ["hello", "world"]
  upper := words.map(it.to_upper())

  println(words)
  println(upper)
  println(nums.any(it > 2))
  println(nums.all(it >= 2))
  println(upper.join(" "))
  nums.sort(a > b)
  println(nums)

  mut users := [User{21, "Bob"}, User{33, "Mickle"}, User{10, "John"}]
  users.sort(a.age < b.age)
  println(users)
  users.sort(a.name > b.name)
  println(users)

  custom_sort_fn := fn (a &User, b &User) int {
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
  println(users)
  println(nums[1..4])
  println(nums[..4])
  println(nums[1..])

  array_1 := [2, 3, 4, 5]
  mut array_2 := [0, 1]
  array_2 << array_1[..3]
  println(array_2)

  mut a := [0, 1, 2, 3, 4, 5]
  mut b := unsafe {a[1..4]}
  b[0] = 7
  println(a)
  b << 9
  println(a)
  println(b)
}


fn slice_unsafe() {
  mut a := []int{len: 5, cap: 6, init: 2}
  mut b := unsafe{a[1..4]}

  a << 3
  b[2] = 13
  a << 4
  b[1] = 3
  println(a)
  println(b)
}

fn slice_with_negative() {
  a := [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  println(a#[-3..])
  println(a#[-20..])
  println(a#[-20..-8])
  println(a#[..-3])
}

fn array_method_chaining() {
  files := ['pip.jpg', '01.bmp', '_v.txt', 'img_02.jpg', 'img_01.JPG']
  filtered := files.filter(it#[-4..].to_lower() == '.jpg').map(it.to_upper())
  println(filtered)
}

fn array_with_fixed_size() {
  mut nums := [3]int{}
  nums[0] = 1
  nums[1] = 7
  nums[2] = 100
  println(nums)
  println(typeof(nums).name)
  nums2 := [1, 2, 3]!
  nums3 := nums2[..]
  println(nums2)
  println(typeof(nums3).name)
}

fn maps()! {
  mut m := map[string]int{}
  m['one'] = 1
  m['two'] = 2
  m['three'] = 3
  println(m['one'])
  println('five' in m)
  for k, v in m {
    println("Key ${k} Val: ${v}")
  }
  m.delete('two')
  println(m)
  m2 := {
    'one': 1
    'two': 2
  }
  println(m2)
  println(typeof(m2).name)
  m3 := {
    'one': 'bad'
    'two': 'doog'
  }
  println(m3)
  println(typeof(m3).name)

  val := m2['three']
  println(val)
  // val2 := m2['three'] or {panic("Value does not find")}
  val2 := m2['three'] or {999}
  println(val2)
  m4 := {
    'abs': "def"
  }
  if v := m4['abs'] {
    println("Value is ${v}")
  }

  arr := [1, 2, 3]
  //large_index := 999
  //v := arr[large_index] or {panic('out of bounds')}

  v := arr[2]!
  println(v)
}

fn map_nested() {
  mut m := map[string]map[string]int{}
  m['greet'] = {
    'hello': 1
  }
}

const base_map = {
  'a': 5
  'b': 7
}

fn map_update() {
  foo := {
    ...base_map
    'b': 123
    'c': 7
  }
  println(foo)

  foo2 := base_map.clone()
  println(foo2)

}
