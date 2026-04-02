package time_test

import "core:fmt"
import "core:time"
import "core:sys/posix"



time_from_api : i64 : 1771058286401 


main :: proc() {


  time_now: posix.time_t
  cur_time := posix.time(&time_now)
  fmt.println(cur_time)


  _t: posix.time_t = posix.time_t(time_from_api / 1000)
  tm := posix.localtime(&_t)
  fmt.println(tm^)

  t := time.from_nanoseconds(time_from_api * 100)
  h, m, s := time.clock_from_time(t)
  fmt.println(h, m, s)
}
