const std = @import("std");
const print = std.debug.print;

const User = struct {
    allocator: std.mem.Allocator,
    id: usize,
    email: []u8,

    fn init(allocator: std.mem.Allocator, id: usize, email: []const u8) !User {
        return .{
            .allocator = allocator,
            .id = id,
            .email = try allocator.dupe(u8, email),
        };
    }

    fn deinit(self: *User) void {
        self.allocator.free(self.email);
    }
};

const UserData = struct {
    map: std.AutoHashMap(usize, User),

    fn init(allocator: std.mem.Allocator) UserData {
        return .{ .map = std.AutoHashMap(usize, User).init(allocator) };
    }

    fn deinit(self: *UserData) void {
        self.map.deinit();
    }

    fn put(self: *UserData, user: User) !void {
        try self.map.put(user.id, user);
    }

    fn get(self: *UserData, id: usize) ?User {
        return self.map.get(id);
    }

    fn del(self: *UserData, id: usize) ?User {
        return if (self.map.fetchRemove(id)) |kv| kv.value else null;
    }
};

fn test_main(aloc: std.mem.Allocator) !void {
    var users = UserData.init(aloc);
    defer users.deinit();
    var jeff = try User.init(aloc, 1, "jeff@foo.io");
    defer jeff.deinit();
    try users.put(jeff);

    try users.put(jeff);
    var alice = try User.init(aloc, 2, "alice@foo.io");
    defer alice.deinit();
    try users.put(alice);
    var bob = try User.init(aloc, 3, "bob@foo.io");
    defer bob.deinit();
    try users.put(bob);

    if (users.get(jeff.id)) |user| print("got is: {}, email: {s}\n", .{ user.id, user.email });
    if (users.get(alice.id)) |user| print("got is: {}, email: {s}\n", .{ user.id, user.email });
    if (users.get(bob.id)) |user| print("got is: {}, email: {s}\n", .{ user.id, user.email });

    _ = users.del(bob.id);
    if (users.get(bob.id)) |user| print("got id: {}, email: {s}\n", .{ user.id, user.email });

    print("coutn: {}\n", .{users.map.count()});
    print("contains alice? {}\n", .{users.map.contains(alice.id)});

    var entry_iter = users.map.iterator();
    while (entry_iter.next()) |entry| print("id: {}, email: {s}\n", .{ entry.key_ptr.*, entry.value_ptr.email });

    var gopr = try users.map.getOrPut(bob.id);
    _ = &gopr;
    if (!gopr.found_existing) gopr.value_ptr.* = bob;

    print("contains bob? {}\n", .{users.map.contains(bob.id)});
    if (users.get(bob.id)) |user| print("got id: {}, email: {s}\n", .{ user.id, user.email });

    var primes = std.AutoHashMap(usize, void).init(aloc);
    defer primes.deinit();

    try primes.put(4, {});
    try primes.put(7, {});
    try primes.put(7, {});
    try primes.put(5, {});

    print("primes in map: {}\n", .{primes.count()});
    print("primes countein 5: {}\n", .{primes.contains(5)});
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    try test_main(gpa.allocator());
}
