module main






fn increase_key(mut key string) bool {
  i := key.len - 1;
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
  mut key := "Key000000"
  mut val := i32(1)
  mut m := map[string]int{}

  for increase_key(key) {
    m[key] = val
    val++
  }

  total := u32(0)
  for k, v in m {
    println("Key -> ${k}, Val -> ${v}")
    total++
  }
  println("Total elements: ${total}")
}
