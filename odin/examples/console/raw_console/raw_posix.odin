#+build !windows
package main

import psx "core:sys/posix"

@(private="file")
orig_mode: psx.termios

_enable_raw_mode :: proc() {
    res := psx.tcgetattr(psx.STDIN_FILENO, &orig_mode)
    assert(res == .OK)

    psx.atexit(disable_raw_mode)

    raw := orig_mode
    raw.c_lflag -= {.ECHO, .ICANON}
    res = psx.tcsetattr(psx.STDIN_FILENO, .TCSANOW, &raw)
    assert(res == .OK)
}

_disable_raw_mode :: proc "c" () {
    psx.tcsetattr(psx.STDIN_FILENO, .TCSANOW, &orig_mode)
}

_set_utf8_termintal :: proc() {}


