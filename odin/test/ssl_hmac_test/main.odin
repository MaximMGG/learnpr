package ssl_hmac_test


import "core:c"
import "core:fmt"
import "core:time"


foreign import ssl {
  "system:ssl", "system:crypto",
}

EVP_MD :: struct {}


foreign ssl {
  HMAC :: proc(evp_md: ^EVP_MD, key: rawptr, key_len: c.int, data: ^u8, data_len: c.size_t, md: ^u8, md_len: ^c.int) -> ^u8 ---
  EVP_sha256 :: proc() -> ^EVP_MD ---
}




REQUEST_ORDER_BODY :: "symbol=%s&side=%s&type=%s&timestamp=%d&quantity=%f"


main :: proc() {

}


