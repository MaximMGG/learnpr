package json_fapi_klines_test


import "core:fmt"
import "core:encoding/json"

Result :: struct {
  v1: f64,
  v2, v3, v4, v5, v6: string,
  v7: f64,
  v8: string,
  v9, v10, v11: string
}


main :: proc() {
  result := "[[1790276400000,\"84437.50\",\"84622.30\",\"84235.30\",\"84367.90\",\"4685.383\",1790279999999,\"395582115.21360\",122298,\"2027.197\",\"171147934.71000\",\"0\"],[1790280000000,\"84367.90\",\"84398.90\",\"84261.70\",\"84268.40\",\"563.629\",1790283599999,\"47532221.20040\",15553,\"259.085\",\"21851641.36180\",\"0\"]]"

  res, res_err := json.parse(transmute([]byte)result)
  defer json.destroy_value(res)


  lines := res.(json.Array)

  for line in lines {
    value := line.(json.Array)
    for i in 0..<len(value) {
      if i == 0 || i == 6{
        v := cast(i64)value[i].(json.Float)
        fmt.println(v)
      } else {
        fmt.println(value[i])
      }
    }
  }


  r: [2]Result

  json.unmarshal(transmute([]byte)result, &r)

  fmt.println(r[0])
}



