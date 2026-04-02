const std = @import("std");


const User = struct {
    id: u64,
    age: i64,
    price: f64
};


const USER_STRING = "User: {d} {d} {d}\n";

fn fieldsTupleType(comptime T: type) type {
    const ti = @typeInfo(T).@"struct";
    const fields = ti.fields;

    comptime var types: [fields.len]type = undefined;
    inline for(0.., fields) |i, f| {
        types[i] = f.type;
    }
    
    return std.meta.Tuple(&types);
}

    
fn print_user(comptime T: type, t: anytype) void {
    const ti = @typeInfo(T).@"struct";

    var tup: fieldsTupleType(User) = undefined;

    inline for(0.., ti.fields) |i, f| {
        tup[i] = @field(t, f.name);
    }
    std.debug.print(USER_STRING, tup);
}


pub fn main() void {
    const u = User{.id = 123, .age = 71, .price = 333.111};
    print_user(User, u);
}
