#include <X11/Xlib.h>



int main() {

    Display *display = XOpenDisplay("Hello Diplay");
    Window window = XCreateSimpleWindow(display, 
            DefaultRootWindow(display), 50, 50, 250, 250, 1, BlackPixel(display, 0), WhitePixel(display, 0));
    XMapWindow(display, window);
    XSelectInput(display, window, );

    return 0;
}
