const std = @import("std");


pub fn fast_sort(allocator: std.mem.Allocator, arr: []u32) !void {
    if (arr.len <= 1) return;
    if (arr.len > 2) {
        var l_arr: []u32 = undefined;
        var r_arr: []u32 = undefined;
        if (arr.len % 2 == 0) {
            const left_arr = try allocator.alloc(u32, arr.len / 2);
            const right_arr = try allocator.alloc(u32, arr.len / 2);
            @memcpy(left_arr, arr[0..(arr.len / 2)]);
            @memcpy(right_arr, arr[(arr.len / 2)..arr.len]);
            try fast_sort(allocator, left_arr);
            try fast_sort(allocator, right_arr);
            l_arr = left_arr;
            r_arr = right_arr;

        } else {
            const left_arr = try allocator.alloc(u32, arr.len / 2 + 1);
            const right_arr = try allocator.alloc(u32, arr.len / 2);
            @memcpy(left_arr, arr[0..(arr.len / 2 + 1)]);
            @memcpy(right_arr, arr[(arr.len / 2)..arr.len]);
            try fast_sort(allocator, left_arr);
            try fast_sort(allocator, right_arr);
            l_arr = left_arr;
            r_arr = right_arr;
        }
        var fin_arr = try allocator.alloc(u32, arr.len);
        @memcpy(fin_arr, arr);
        var l_i: usize = 0;
        var r_i: usize = 0;
        var i: usize = 0;
        while(i < fin_arr.len) : (i += 1) {
            if (l_i == l_arr.len) {
                fin_arr[i] = r_arr[r_i];
                r_i += 1;
            } else if (r_i == r_arr.len) {
                fin_arr[i] = l_arr[l_i];
                l_i += 1;
            }
            if (r_arr[r_i] > l_arr[l_i]) {
                fin_arr[i] = l_arr[l_i];
                l_i += 1;
            } else {
                fin_arr[i] = r_arr[r_i];
                r_i += 1;
            }
        }
        allocator.free(l_arr);
        allocator.free(r_arr);
        allocator.free(fin_arr);
    } else {
        if (arr[0] > arr[1]) {
            const tmp = arr[0];
            arr[0] = arr[1];
            arr[1] = tmp;
            return;
        }
    }
}


pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var arr: [100]u32 = .{0} ** 100;
    for(0..100) |i| {
        arr[i] = std.crypto.random.int(u32);
    }
    try fast_sort(allocator, &arr);

    for(&arr) |i| {
        std.debug.print("{d}", .{i});
    }
}


