module main

fn increase_key(mut key []u8) bool {
	mut i := key.len - 1
	for {
		if key[i] < `9` {
			key[i] += 1
			break
		} else {
			key[i] = `0`
			i--
			continue
		}
	}
	if key[3] == `1` {
		return false
	}
	return true
}

fn main() {
	mut key := 'Key000000'
	mut val := i32(1)
	mut m := map[string]i32{}

	mut key_buf := key.bytes()
	for increase_key(mut key_buf) {
		m[key] = val
		val++
	}

	mut total := u32(0)
	for k, v in m {
		println('Key -> ${k}, Val -> ${v}')
		total++
	}
	println('Total elements: ${total}')
}
