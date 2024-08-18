const std = @import("std");
const print = std.debug.print;
const stdio = @cImport(@cInclude("stdio.h"));
const empty = .{};



pub fn main() void {
    const char_1:u8 = 'a';

    print("single character (): {d}\n", .{char_1});
    print("single character (): {c}\n", .{char_1});
    print("single character (): {p}\n", .{&char_1});

    const char_array = [5]u8 {'H', 'e', 'l', 'l', 'o'};
    const char_slice:[]const u8 = "Hello";
    const inferrend_array_slice = char_array[0..1];
    const inferrend_slice = "hello";
    const char_slice2:[]const u8 = char_array[0..3];

    print("Char array: {s}\n", .{char_array});
    print("char_clise: {s}\n", .{char_slice});
    print("inferrend array slice: {s}\n", .{inferrend_array_slice});
    print("inferrend slice: {s}\n", .{inferrend_slice});
    print("char_slice2: {s}\n", .{char_slice2});

    const num: i32 = 1223123;

    _ = stdio.printf("%d\n", num);


    const number: i32 = 10;
    const number_array = [_]i32 {1, 2, 3};
    const number_slice = number_array[0..1];
    print("Print number: {}\n", .{number});
    print("number_array: {},{},{}\n", .{number_array[0], number_array[1], number_array[2]});
    print("num_ar: {any}\n", .{number_slice});


    print("Print number in array\n", empty);

    for (number_array) |snum| {
        if (snum == number_array[number_array.len - 1]) {
            print("{}\n", .{snum});
        } else {
            print("{}, ", .{snum});
        }
    }
    if_statements();

}

fn if_statements() void {
    const num:i32 = 10;
    var formult:bool = false;
    if (num == 10) {
        print("Number is 10\n", empty);
    } else if (num == 20){
        print("Number is 20\n", empty);
    } else {
        print("Number is not 10 or 20\n", empty);
    }

    if (num == 10 and !formult) {
        print("num is 10 and !formult\n", empty);
        formult = true;
    }
}
