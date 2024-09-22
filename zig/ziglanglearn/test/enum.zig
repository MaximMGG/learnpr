const enums = enum(c_int) { one, two, three };

extern "c" fn foo(e: enums) void;

pub fn main() !void {
    const s: enums = enums.one;
    foo(s);
}
