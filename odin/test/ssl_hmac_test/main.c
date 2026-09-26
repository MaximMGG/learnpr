#include <openssl/hmac.h>
#include <cstdext/core.h>
#include <stdio.h>
#include <string.h>
#include <sys/time.h>
#include <cstdext/io/reader.h>



#define TRADER_REQUEST_ORDER_BODY "symbol=%s&side=%s&type=%s&timestamp=%lld&quantity=%.2f"


#define TRADER_KEY_SECRET_PATH "/home/%s/.config/trade_helper_conf/.secret_key"


str secret_key = null;

void load_keys() {
  str user = getenv("USER");

  str secret_path = strCreateFmt(TRADER_KEY_SECRET_PATH, user);

  secret_key = readEntyreFile(secret_path);
  secret_key[strlen(secret_key) - 1] = '\0';
  DEALLOC(secret_path);
}

static str traderEncodeBody(str body) {
  u8 encode_body[EVP_MAX_MD_SIZE];
  u32 encode_body_len = 0;

  HMAC(EVP_sha256(), secret_key, strlen(secret_key), cast(u8 *, body), strlen(body), encode_body, &encode_body_len);

  i8 signature[EVP_MAX_MD_SIZE * 2 + 1];
  for(u32 i = 0; i < encode_body_len; i++) {
    sprintf(&signature[i * 2], "%02x", encode_body[i]);
  }

  signature[encode_body_len * 2] = '\0';

  return strCopy(signature);
}


static i64 get_time() {
  struct timeval tv;
  gettimeofday(&tv, null);
  return (tv.tv_sec * 1000 + tv.tv_usec / 1000) - 1400; //TODO(Maxim) wrong shit, need to fix it later
}


str construct_body(str symbol, str side, str type, f32 quantity) {
  i64 time_now = 1790417572798;
  str body = strCreateFmt(TRADER_REQUEST_ORDER_BODY, symbol, side, type, time_now, quantity);

  str signature = traderEncodeBody(body);

  str request = strCreateFmt("%s&signatyre=%s", body, signature);
  DEALLOC(body);
  DEALLOC(signature);


  return request;
}


int main() {

  load_keys();

  str request = construct_body("IOTXUSDT", "BUY", "MARKET", 2300.00);
  printf("Secret: %s\n", secret_key);
  printf("%s\n", request);
  DEALLOC(request);
  DEALLOC(secret_key);
  return 0;
}
