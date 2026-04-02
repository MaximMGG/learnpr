const std = @import("std");


const Value = struct {
    id: i64,
    price: f64,
    time: u64,
};

    
const value1 = [_][]const u8{"7", "123141.82828", "1212121288888"};


fn select_struct(comptime T: type) !T {
    var tmp: T = undefined;
    const ti = @typeInfo(T).@"struct";

    inline for(0.., ti.fields) |i, field| {
        switch(field.type) {
            u64 => {
                @field(tmp, field.name) = try std.fmt.parseInt(u64, value1[i], 10);
            },
            i64 => {
                @field(tmp, field.name) = try std.fmt.parseInt(i64, value1[i], 10);
            },
            f64 => {
                @field(tmp, field.name) = try std.fmt.parseFloat(f64, value1[i]);
            },
            else => {}
        }
    }
    return tmp;
}

test "struct access test" {
    const v = try select_struct(Value);
    std.debug.print("{any}\n", .{v});
}
