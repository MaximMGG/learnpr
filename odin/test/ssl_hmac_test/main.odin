package ssl_hmac_test


import "core:c"
import "core:fmt"
import "core:time"
import "core:strings"
import "core:os"
import "core:sys/posix"


foreign import ssl {
  "system:ssl", "system:crypto",
}

EVP_MD :: struct {}


foreign ssl {
  HMAC :: proc(evp_md: ^EVP_MD, key: rawptr, key_len: c.int, data: ^u8, data_len: c.size_t, md: ^u8, md_len: ^c.int) -> ^u8 ---
  EVP_sha256 :: proc() -> ^EVP_MD ---
}

EVP_MAX_MD_SIZE :: 64


REQUEST_ORDER_BODY :: "symbol=%s&side=%s&type=%s&timestamp=%d&quantity=%.2f"
secret_key: string




load_key :: proc() {
  user := posix.getenv("USER")

  secret_path := fmt.aprintf("/home/%s/.config/trade_helper_conf/.secret_key", user)

  key, key_ok := os.read_entire_file(secret_path, context.allocator)
  defer delete(key)

  if key_ok != nil {
    fmt.eprintln("read key error")
    os.exit(1)
  }

  secret_key = strings.clone(strings.trim(transmute(string)key, "\r\n "))
}


encode_body :: proc(body: string) -> string {
  encode_body: [EVP_MAX_MD_SIZE]u8
  encode_body_len: i32

  body := transmute([]u8)body

  HMAC(EVP_sha256(), raw_data(secret_key), c.int(len(secret_key)), &body[0], len(body), &encode_body[0], &encode_body_len)

  signature: [EVP_MAX_MD_SIZE * 2 + 1]u8

  for i in 0..<encode_body_len {
    fmt.bprintf(signature[i * 2:], "%02x", encode_body[i])
  }

  signature[encode_body_len * 2] = u8(0)

  return strings.clone(transmute(string)signature[:encode_body_len * 2])
}

get_time :: proc() -> i64 {
  time_now := time.now()
  return time_now._nsec / 1_000_000
}


construct_body :: proc(symbol: string, side: string, type: string, quantity: f32) -> string {
  time_now := i64(1790417572798)
  body := fmt.aprintf(REQUEST_ORDER_BODY, symbol, side, type, time_now, quantity)
  defer delete(body)
  signature := encode_body(body)
  defer delete(signature)

  request_body := fmt.aprintf("%s&signature=%s", body, signature)

  return request_body
}




main :: proc() {
  load_key()
  request_body := construct_body("IOTXUSDT", "BUY", "MARKET", 2300.00)
  fmt.println("Secret:", secret_key)
  fmt.println(request_body)
  defer delete(request_body)

  delete(secret_key)
}


