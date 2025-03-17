const c = @cImport({
    @cInclude("stdio.h");
    @cInclude("stdlib.h");
    @cInclude("unistd.h");
});

fn bye() callconv(.c) void {
    _ = c.printf("\nBye!\n");
}

pub fn main() u8 {
    _ = c.atexit(bye);

    _ = c.printf("hello from main");

    c._exit(@as(c_int, 0));
    return 0;
}
