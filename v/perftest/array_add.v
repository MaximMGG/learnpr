module main

fn add_to_arr(mut arr []i32, num i32) {
	arr << num
}

fn main() {
	mut arr := []i32{}

	for i in 0 .. 1_000_000 {
		add_to_arr(mut arr, i32(i))
	}

	mut sum := u64(0)

	for i in arr {
		sum += u64(i)
	}

	println('Sum is: ${sum}')
}
