#include <stdio.h>
#include "token.h"
#include "window.h"
#include <cstdext/io/logger.h>

void initLogger() {
  log_set_opt(DEF_OPTION, LOG_TYPE_FILE, "./tokens.log");
}

int main() {
  initLogger();
  log(INFO, "Initialize token application");
  Window *w = windowCreate();

  windowParseConfig(w);
  timeout(50);
 
  i32 ch;
  while(true) {
    ch = getch();
    if (ch == 'q') {
      log(INFO, "Quit from main cycle");
      break;
    }
    if (ch == 'i') {
      log(INFO, "Open input window");
      timeout(500000);
      str new_token = windowGetInput(w);
      if (new_token != null) {
        windowAddToken(w, new_token);
        json_add_to_arr(json_get_obj(w->config, "tokens"), json_create_str(null, new_token));
        dealloc(new_token);
      }
      timeout(50);
    }
    windowRequest(w);
    windowDraw(w);
  }
  log(INFO, "Shutdown token application");

  // struct tm startTime = {
  //   .tm_year = 2025 - 1900, .tm_mon = 10, .tm_mday = 25, .tm_hour = 20, .tm_min = 30
  // };
  // struct tm endTime = {
  //   .tm_year = 2025 - 1900, .tm_mon = 10, .tm_mday = 27, .tm_hour = 20, .tm_min = 30
  // };
  //
  // tokenLoadHystricalData(t, &startTime, &endTime);

  // for(i32 i = 0; i < t->tickerHystorical->len; i++) {
  //   TickerHystorical *tmp = list_get(t->tickerHystorical, i);
  //   str s = tickerHystoricalToString(tmp);
  //   printf("%d - %s\n", i, s);
  //   dealloc(s);
  // }

  windowDestroy(w);
  return 0;
}
