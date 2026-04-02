const std = @import("std");
const c = @cImport({
    @cInclude("netdb.h");
    @cInclude("sys/socket.h");
    @cInclude("sys/types.h");
    @cInclude("unistd.h");
});

const api_fmt = "192.168.0.{d}";
const port_fmt = "{d}";


fn inc_host_port(ip: *u8, port: *u16) bool {
    if (ip.* == 255) {
        ip.* = 0;
        if (port.* != 0xffff) {
            port.* += 1;
        } else {
            return false;
        }
    } else {
        if (port.* != 0xffff) {
            port.* += 1;
        } else {
            ip.* += 1;
            port.* = 0;
        }
    }
    return true;
}

pub fn main() !void {
    // var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    // const allocator = gpa.allocator();
    var port: u16 = 0;
    var host_name_buf: [128]u8 = .{0} ** 128;
    var port_name_buf: [16]u8 = .{0} ** 16;
    var ip: u8 = 1;

    while(true) {

        @memset(&host_name_buf, 0);
        @memset(&port_name_buf, 0);

        var hints: c.struct_addrinfo = std.mem.zeroInit(c.struct_addrinfo, .{
            .ai_family = c.AF_INET,
            .ai_socktype = c.SOCK_STREAM,
            .ai_flags = c.AI_PASSIVE
        });
        var res: ?*c.struct_addrinfo = null;
        const host_name = try std.fmt.bufPrint(&host_name_buf, api_fmt, .{ip});
        const host_port = try std.fmt.bufPrint(&port_name_buf, port_fmt, .{port});

        defer c.freeaddrinfo(res);
        std.debug.print("Check: {s}, port: {s}\n", .{host_name, host_port});

        if (c.getaddrinfo(host_name.ptr, host_port.ptr, &hints, &res) != 0) {
            if (inc_host_port(&ip, &port)) {
                continue;
            } else {
                break;
            }
        }

        const sockfd = c.socket(res.?.ai_family, res.?.ai_socktype, res.?.ai_protocol);
        defer _ = c.close(sockfd);
        if (sockfd < 0) {
            if (inc_host_port(&ip, &port)) {
                continue;
            } else {
                break;
            }
        }
        if (c.connect(sockfd, res.?.ai_addr, res.?.ai_addrlen) != 0) {
            if (inc_host_port(&ip, &port)) {
                continue;
            } else {
                break;
            }
        }
        std.debug.print("Connect to: {s}:{s}\n", .{host_name, host_port});

        const msg = "GET / HTTP/1.1\r\n\r\n";
        var buf: [1024]u8 = .{0} ** 1024;

        _ = c.send(sockfd, @ptrCast(msg), @intCast(msg.len), @as(c_int, 0));
        _ = c.recv(sockfd, @ptrCast(&buf), @intCast(buf.len), @as(c_int, 0));
        
        std.debug.print("Host: {s}, port: {s}\n{s}\n", .{host_name, host_port, buf});
        if (!inc_host_port(&ip, &port)) {
            break;
        }
    }
}
