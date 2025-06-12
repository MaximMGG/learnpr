const std = @import("std");
const c = @cImport(@cInclude("ncurses.h"));


pub fn main() !void {
    _ = c.initscr() orelse return error.InitscrError;

    _ = c.printw("Upper left corner           "); _ = c.addch(@as(u8, c.ACS_ULCORNER)); _ = c.printw("\n"); 
    _ = c.printw("Lower left corner           "); _ = c.addch(@as(u8, c.ACS_LLCORNER)); _ = c.printw("\n");
    _ = c.printw("Lower right corner          "); _ = c.addch(@as(u8, c.ACS_LRCORNER)); _ = c.printw("\n");
    _ = c.printw("Tee pointing right          "); _ = c.addch(@as(u8, c.ACS_LTEE));     _ = c.printw("\n");
    _ = c.printw("Tee pointing left           "); _ = c.addch(@as(u8, c.ACS_RTEE));     _ = c.printw("\n");
    _ = c.printw("Tee pointing up             "); _ = c.addch(@as(u8, c.ACS_BTEE));     _ = c.printw("\n");
    _ = c.printw("Tee pointing down           "); _ = c.addch(@as(u8, c.ACS_TTEE));     _ = c.printw("\n");
    _ = c.printw("Horizontal line             "); _ = c.addch(@as(u8, c.ACS_HLINE));    _ = c.printw("\n");
    _ = c.printw("Vertical line               "); _ = c.addch(@as(u8, c.ACS_VLINE));    _ = c.printw("\n");
    _ = c.printw("Large Plus or cross over    "); _ = c.addch(@as(u8, c.ACS_PLUS));     _ = c.printw("\n");
    _ = c.printw("Scan Line 1                 "); _ = c.addch(@as(u8, c.ACS_S1));       _ = c.printw("\n");
    _ = c.printw("Scan Line 3                 "); _ = c.addch(@as(u8, c.ACS_S3));       _ = c.printw("\n");
    _ = c.printw("Scan Line 7                 "); _ = c.addch(@as(u8, c.ACS_S7));       _ = c.printw("\n");
    _ = c.printw("Scan Line 9                 "); _ = c.addch(@as(u8, c.ACS_S9));       _ = c.printw("\n");
    _ = c.printw("Diamond                     "); _ = c.addch(@as(u8, c.ACS_DIAMOND));  _ = c.printw("\n");
    _ = c.printw("Checker board (stipple)     "); _ = c.addch(@as(u8, c.ACS_CKBOARD));  _ = c.printw("\n");
    _ = c.printw("Degree Symbol               "); _ = c.addch(@as(u8, c.ACS_DEGREE));   _ = c.printw("\n");
    _ = c.printw("Plus/Minus Symbol           "); _ = c.addch(@as(u8, c.ACS_PLMINUS));  _ = c.printw("\n");
    _ = c.printw("Bullet                      "); _ = c.addch(@as(u8, c.ACS_BULLET));   _ = c.printw("\n");
    _ = c.printw("Arrow Pointing Left         "); _ = c.addch(@as(u8, c.ACS_LARROW));   _ = c.printw("\n");
    _ = c.printw("Arrow Pointing Right        "); _ = c.addch(@as(u8, c.ACS_RARROW));   _ = c.printw("\n");
    _ = c.printw("Arrow Pointing Down         "); _ = c.addch(@as(u8, c.ACS_DARROW));   _ = c.printw("\n");
    _ = c.printw("Arrow Pointing Up           "); _ = c.addch(@as(u8, c.ACS_UARROW));   _ = c.printw("\n");
    _ = c.printw("Board of squares            "); _ = c.addch(@as(u8, c.ACS_BOARD));    _ = c.printw("\n");
    _ = c.printw("Lantern Symbol              "); _ = c.addch(@as(u8, c.ACS_LANTERN));  _ = c.printw("\n");
    _ = c.printw("Solid Square Block          "); _ = c.addch(@as(u8, c.ACS_BLOCK));    _ = c.printw("\n");
    _ = c.printw("Less/Equal sign             "); _ = c.addch(@as(u8, c.ACS_LEQUAL));   _ = c.printw("\n");
    _ = c.printw("Greater/Equal sign          "); _ = c.addch(@as(u8, c.ACS_GEQUAL));   _ = c.printw("\n");
    _ = c.printw("Pi                          "); _ = c.addch(@as(u8, c.ACS_PI));       _ = c.printw("\n");
    _ = c.printw("Not equal                   "); _ = c.addch(@as(u8, c.ACS_NEQUAL));   _ = c.printw("\n");
    _ = c.printw("UK pound sign               "); _ = c.addch(@as(u8, c.ACS_STERLING)); _ = c.printw("\n");

    _ = c.refresh();
    _ = c.getch();

    _ = c.endwin();
}
