const std = @import("std");
const expect = std.testing.expect;

test "while loop continue wxpression" {
    var i: usize = 0;
    while (i < 10) : (i += 1) {}
    try expect(i == 10);
}

test "while loop continue wxpression, more complicated" {
    var i: usize = 1;
    var j: usize = 1;
    while (i * j < 2000) : ({
        i *= 2;
        j *= 3;
    }) {
        const my_ij = i * j;
        try expect(my_ij < 2000);
    }
}

test "while else" {
    try expect(rangeHasNumber(0, 10, 5));
    try expect(!rangeHasNumber(0, 10, 15));
}

fn rangeHasNumber(begin: usize, end: usize, number: usize) bool {
    var i = begin;
    return while (i < end) : (i += 1) {
        if (i == number) {
            break true;
        }
    } else {
        return false;
    };
}

test "nested break" {
    outer: while (true) {
        while (true) {
            break :outer;
        }
    }
}

test "nested continue" {
    var i: usize = 0;
    outer: while (i < 10) : (i += 10) {
        while (true) {
            continue :outer;
        }
    }
}

test "while null capture" {
    var sum1: u32 = 0;
    numbers_left = 3;
    while (evetuallyNullSequence()) |value| {
        sum1 += value;
    } else {
        try expect(sum1 == 3);
    }

    var sum2: u32 = 0;
    numbers_left = 3;
    while (evetuallyNullSequence()) |value| {
        sum2 += value;
    } else {
        try expect(sum2 == 3);
    }
    var i: u32 = 0;
    var sum3: u32 = 0;
    numbers_left = 3;
    while (evetuallyNullSequence()) |value| : (i += 1) {
        sum3 += value;
    }
    try expect(i == 3);
}

var numbers_left: u32 = undefined;

fn evetuallyNullSequence() ?u32 {
    return if (numbers_left == 0) null else blk: {
        numbers_left -= 1;
        break :blk numbers_left;
    };
}
