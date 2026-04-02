const std = @import("std");

pub fn fast_sort(allocator: std.mem.Allocator, arr: []u32) !void {
    if (arr.len <= 1) return;
    if (arr.len > 2) {
        if (arr.len % 2 == 0) {
            const left_arr = try allocator.alloc(u32, arr.len / 2);
            const right_arr = try allocator.alloc(u32, arr.len / 2);
            @memcpy(left_arr, arr[0..(arr.len / 2)]);
            @memcpy(right_arr, arr[(arr.len / 2)..arr.len]);
            try fast_sort(allocator, left_arr);
            try fast_sort(allocator, right_arr);

            var fin_arr = try allocator.alloc(u32, arr.len);
            @memcpy(fin_arr, arr);
            var l_i: usize = 0;
            var r_i: usize = 0;
            var i: usize = 0;
            while(i < fin_arr.len) : (i += 1) {
                if (l_i == left_arr.len) {
                    fin_arr[i] = right_arr[r_i];
                    r_i += 1;
                    continue;
                } 
                if (r_i == right_arr.len) {
                    fin_arr[i] = left_arr[l_i];
                    l_i += 1;
                    continue;
                }
                if (right_arr[r_i] > left_arr[l_i]) {
                    fin_arr[i] = left_arr[l_i];
                    l_i += 1;
                } else {
                    fin_arr[i] = right_arr[r_i];
                    r_i += 1;
                }
            }
            allocator.free(left_arr);
            allocator.free(right_arr);
            @memcpy(arr, fin_arr);
            allocator.free(fin_arr);

        } else {
            const left_arr = try allocator.alloc(u32, arr.len / 2 + 1);
            const right_arr = try allocator.alloc(u32, arr.len / 2);
            @memcpy(left_arr, arr[0..(arr.len / 2 + 1)]);
            @memcpy(right_arr, arr[(arr.len / 2 + 1)..arr.len]);
            try fast_sort(allocator, left_arr);
            try fast_sort(allocator, right_arr);

            var fin_arr = try allocator.alloc(u32, arr.len);
            @memcpy(fin_arr, arr);
            var l_i: usize = 0;
            var r_i: usize = 0;
            var i: usize = 0;
            while(i < fin_arr.len) : (i += 1) {
                if (l_i == left_arr.len) {
                    fin_arr[i] = right_arr[r_i];
                    r_i += 1;
                    continue;
                } 
                if (r_i == right_arr.len) {
                    fin_arr[i] = left_arr[l_i];
                    l_i += 1;
                    continue;
                }
                if (right_arr[r_i] > left_arr[l_i]) {
                    fin_arr[i] = left_arr[l_i];
                    l_i += 1;
                } else {
                    fin_arr[i] = right_arr[r_i];
                    r_i += 1;
                }
            }
            allocator.free(left_arr);
            allocator.free(right_arr);
            @memcpy(arr, fin_arr);
            allocator.free(fin_arr);
        }
    } else {
        if (arr[0] > arr[1]) {
            const tmp = arr[0];
            arr[0] = arr[1];
            arr[1] = tmp;
            return;
        }
    }
}

const count = 1000000;

pub fn main() !void {
    //var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var arena = std.heap.ArenaAllocator.init(std.heap.c_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var arr: [count]u32 = .{0} ** count;
    for(0..count) |i| {
        arr[i] = std.crypto.random.int(u32);
    }

    // for(&arr) |i| {
    //     std.debug.print("{d}\n", .{i});
    // }
    //
    // std.debug.print("========\n", .{});

    std.debug.print("Start\n", .{});
    try fast_sort(allocator, &arr);
    std.debug.print("End\n", .{});

    // for(&arr) |i| {
    //     std.debug.print("{d}\n", .{i});
    // }
}


