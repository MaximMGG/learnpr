const std = @import("std");
const print = std.debug.print;

pub fn main() void {

    convert_unsigned_and_signed1();
    _ = convert_to_u8(12);
}

fn convert_unsigned_and_signed1() void {
    const num1:i8 = 10;
    const num2:u8 = num1;
    const num3:i8 = num2;

    print("num1: {}\n", .{num1});
    print("num2: {}\n", .{num2});
    print("num3: {}\n", .{num3});

    // const unum:u8 = 233;
    // const inum:i8 = unum;
    // print("unum: {}\n", .{unum});
    // print("inum: {}\n", .{inum});
}

fn value_fits_in_u8(value: i8) bool {
    const MAX_U8:u8 = std.math.maxInt(u8);
    if (value <= MAX_U8) {
        if (value >= 0)
            return true;
    }
    return false;
}


fn convert_to_u8(input:i8) u8 {
    if (value_fits_in_u8(input)) {
        const res:u8 = @intCast(input);
        return res;
    }
    return 0;
}
