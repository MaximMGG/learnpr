const std = @import("std");


pub fn fast_sort(T: type, arr: []T) void {
    if (arr.len <= 1) return;
    if (arr.len > 2) {
        if (arr.len % 2 == 0) {
            const left_arr: [arr.len / 2]T = undefined;
            const right_arr: [arr.len / 2]T = undefined;
            @memcpy(&left_arr, arr[0..arr.len / 2]);
            @memcpy(&right_arr, arr[arr.len / 2..arr.len]);
            fast_sort(T, &left_arr);
            fast_sort(T, &right_arr);

            var fin_arr: [arr.len]T = undefined;
            @memcpy(&fin_arr, arr);
            var l_i: usize = 0;
            var r_i: usize = 0;
            var i: usize = 0;
            while(i < fin_arr) : (arr += 1) {
                if (l_i == left_arr.len) {
                    fin_arr[i] = right_arr[r_i];
                    r_i += 1;

                }
            }
        } else {
            const left_arr: [arr.len / 2 + 1]T = undefined;
            const right_arr: [arr.len / 2]T = undefined;
            @memcpy(&left_arr, arr[0..arr.len / 2 + 1]);
            @memcpy(&right_arr, arr[arr.len / 2..arr.len]);
            fast_sort(T, left_arr);
            fast_sort(T, right_arr);
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


pub fn main() !void {

}


