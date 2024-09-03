const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    const ts = Timestamp{ .unix = 169989923 };
    print("{d}\n", .{ts.seconds()});
}

const TimestampType = enum {
    unix,
    datatime,
};

const Timestamp = union(TimestampType) {
    unix: i64,
    datatime: DateTime,

    const DateTime = struct { year: u16, month: u8, day: u8, hour: u8, minute: u8, second: u8 };

    fn seconds(self: Timestamp) u16 {
        switch (self) {
            .datatime => |dt| return dt.second,
            .unix => |ts| {
                const seconds_since_midnight: i64 = @rem(ts, 86400);
                return @intCast(@rem(seconds_since_midnight, 60));
            },
        }
    }
};
