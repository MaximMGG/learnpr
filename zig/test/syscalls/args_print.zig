const c = @cImport({
    @cInclude("stdio.h");
    @cInclude("stdlib.h");
    @cInclude("time.h");
    @cInclude("sys/stat.h");
});

fn print_space(repeats: c_int) void {
    for (0..@intCast(repeats)) |i| {
        _ = c.printf("%lu - Hello world ", i);
    }
}

fn print_new_line(repeats: c_int) void {
    for (0..@intCast(repeats)) |i| {
        _ = c.printf("%lu - Hello world\n", i);
    }
}

pub export fn main(argc: c_int, argv: [*]const [*:0]const u8) c_int {
    if (argc != 2) {
        _ = c.printf("Usage: %s <integer>\n", argv[0]);
        return 1;
    }

    const repeats: c_int = c.atoi(argv[1]);

    var space_time: c.clock_t = c.clock();
    print_space(repeats);
    space_time = c.clock() - space_time;
    const space_time_taken: f64 = @as(f64, @floatFromInt(space_time)) / c.CLOCKS_PER_SEC;

    var new_line_time: c.clock_t = c.clock() - space_time;
    print_new_line(repeats);
    new_line_time = c.clock() - new_line_time;
    const new_line_time_taken: f64 = @as(f64, @floatFromInt(new_line_time)) / c.CLOCKS_PER_SEC;
    _ = c.printf("\nSpace time: \t%lf sec \nNew Line time: \t%lf sec\n", space_time_taken, new_line_time_taken);

    _ = c.fflush(c.stdout);
    return 0;
}
