#include <X11/Xlib.h>
#include <stdio.h>
#include <stdlib.h>


static Display *disp;
static int src;
static Window win;

#define POSY 500
#define POSX 500
#define WIDTH 720
#define HEIGHT 480
#define BORDER 15

int main() {

    Window sipleWin;
    XEvent ev;

    disp = XOpenDisplay(NULL);
    if (!disp) {
        printf("Cant open display");
        exit(1);
    }
    src = DefaultScreen(disp);
    win = RootWindow(disp, src);
    
    sipleWin = XCreateSimpleWindow(disp, win, POSX, POSY, WIDTH, HEIGHT, BORDER, BlackPixel(disp, src), WhitePixel(disp, src));
    XMapWindow(disp, sipleWin);

    while(XNextEvent(disp, &ev) == 0) {

    }

    XUnmapWindow(disp, sipleWin);
    XDestroyWindow(disp, sipleWin);
    XCloseDisplay(disp);
    

    return 0;
}
