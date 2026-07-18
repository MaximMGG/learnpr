#ifndef APP_H
#define APP_H
#include "v_window.h"

#define WIDTH 800
#define HEIGHT 600


typedef struct {
  VWindow *v_window;

} App;

App defaultApp();
void run(App *app);


#endif // APP_H
