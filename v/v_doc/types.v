fn main() {
	s := 'hello'
	assert s.len == 5

	arr := s.bytes()
	assert arr.len == 5

	println("${s}, ${arr}")
	s2 := arr.bytestr()
	assert s == s2
}
