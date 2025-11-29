#include <stdio.h>
#include <cstdext/io/json.h>


int main() {

  json_obj *config = json_connection("./config.json");
  json_obj *tokens = json_get_obj(config, "tokens");

  for(i32 i = 0; i < tokens->arr_len; i++) {
    printf("Token: %s\n", tokens->arr[i]->val.str_val);
  }

  json_connection_close(config);
  return 0;
}
