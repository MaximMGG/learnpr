import os


fn main() {
  file_name := "basic.v"
  mut file := os.open(file_name)!
  //defer {file.close()}
  file.seek(0, .start)!

  mut total := u64(0)
  mut buf := []u8{len: 4096, cap: 4096}
  mut iteration := 50

  for {
    
    for {
      n := file.read(mut buf) or {break}
      total += u64(n)
      println("Read ${n}bytes: \n${buf.bytestr()}")
    }

    file.seek(0, .start)!
    iteration -= 1
    if iteration == 0 {break}
  }
  

  println("Total read ${total} bytes")

}
