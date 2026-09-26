package profit_calc


import "core:fmt"
import "core:math"

main :: proc() {
  margin := 20.0
  pos_size := 10.0

  real_money := pos_size / margin

  enter_price := 0.0003654
  close_price := 0.0003620

  quantity := math.floor(pos_size / enter_price)


  enter_money := quantity * enter_price
  close_money := quantity * close_price

  diff := close_money - enter_money
  real_diff := real_money + diff

  profit := ((real_diff * 100.0) / real_money) - 100.0

  fmt.println("Close - enter:", close_money - enter_money)
  fmt.printf("Profit: %.2f%%\n", profit)

}
