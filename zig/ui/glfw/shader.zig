const std = @import("std");
const AutoHashMap = std.AutoHashMap;
const gl = @cImport(@cInclude("GL/glew.h"));

const ShaderType = enum(usize) {
    VERTEX = 0,
    FRAGMENT = 1,
};

const ShaderProgramSource = struct {
    VertexSource: []u8 = undefined,
    FragmentSource: []u8 = undefined,
};


fn parseShader(filepath: []const u8, allocator: std.mem.Allocator) !ShaderProgramSource {
    var source = [2]std.ArrayList(u8){try std.ArrayList(u8).initCapacity(allocator, 0), try std.ArrayList(u8).initCapacity(allocator, 0)};
    var courceType: ShaderType = .VERTEX;
    var prog: ShaderProgramSource = .{};
    const f = try std.fs.cwd().openFile(filepath, .{.mode = .read_only});
    defer f.close();
    var f_buf: [4096]u8 = undefined;
    var f_reader = f.reader(&f_buf);

    while (f_reader.interface.takeDelimiterExclusive('\n')) |line| {
        if (std.mem.indexOf(u8, line, "#shader")) |_| {
            if (std.mem.indexOf(u8, line, "vertex")) |_| {
                courceType = .VERTEX;
            }
            if (std.mem.indexOf(u8, line, "fragment")) |_| {
                courceType = .FRAGMENT;
            }
        } else {
            try source[@intFromEnum(courceType)].appendSlice(allocator, line);
            try source[@intFromEnum(courceType)].append(allocator, '\n');
        }
    } else |_| {
    }

    prog.VertexSource = try allocator.dupe(u8, source[@intFromEnum(ShaderType.VERTEX)].items);
    prog.FragmentSource = try allocator.dupe(u8, source[@intFromEnum(ShaderType.FRAGMENT)].items);

    source[@intFromEnum(ShaderType.VERTEX)].deinit(allocator);
    source[@intFromEnum(ShaderType.FRAGMENT)].deinit(allocator);

    return prog;
}


fn compileShader(source: []const u8, _type: u32, allocator: std.mem.Allocator) !u32 {
    const id = gl.glCreateShader().?(_type);
    gl.glShaderSource().?(id, 1, @ptrCast(&source), null);
    gl.glCompileShader().?(id);

    var res: c_int = 0;
    gl.glGetShaderiv().?(id, gl.GL_COMPILE_STATUS, &res);
    if (res == gl.GL_FALSE) {
        var length: c_int = 0;
        gl.glGetShaderiv().?(id, gl.GL_INFO_LOG_LENGTH, &length);
        const message: []u8 = try allocator.alloc(u8, @intCast(length));
        gl.glGetShaderInfoLog().?(id, length, &length, message.ptr);
        std.debug.print("Failed to compile {s} shader {s}\n", .{
            if (_type == gl.GL_VERTEX_SHADER) "vertex" else "fragment",
            message
        });
        gl.glDeleteShader().?(id);
        return 0;
    }
    return id;
}

fn createShader(vertexShader: []const u8, fragmentShader: []const u8, allocator: std.mem.Allocator) !u32 {
    const program = gl.glCreateProgram().?();
    std.debug.print("Programm: {d}\n", .{@as(u32, program)});
    const vs: u32 = try compileShader(vertexShader, gl.GL_VERTEX_SHADER, allocator);
    const fs: u32 = try compileShader(fragmentShader, gl.GL_FRAGMENT_SHADER, allocator);

    gl.glAttachShader().?(program, vs);
    gl.glAttachShader().?(program, fs);
    gl.glLinkProgram().?(program);

    gl.glDeleteShader().?(vs);
    gl.glDeleteShader().?(fs);

    return @as(u32, @intCast(program));
}

pub fn create(filepath: []const u8, allocator: std.mem.Allocator) !Shader {
    var s = Shader{.filepath = filepath};
    const prog_source: ShaderProgramSource = try parseShader(filepath, allocator);
    std.debug.print("Vertex Shader:\n{s}\n", .{prog_source.VertexSource});
    std.debug.print("Fragment Shader:\n{s}\n", .{prog_source.FragmentSource});

    defer {
        allocator.free(prog_source.VertexSource);
        allocator.free(prog_source.FragmentSource);
    }

    s.rendererID = try createShader(prog_source.VertexSource, prog_source.FragmentSource, allocator);
    s.uniform_location_catch = std.AutoHashMap([]u8, u32).init(allocator);

    return s;
}

pub const Shader = struct {
    filepath: []const u8,
    rendererID: u32 = 0,
    uniform_location_catch: AutoHashMap([]u8, u32) = undefined,
    allocator: std.mem.Allocator = undefined,

    pub fn destroy(self: *Shader) void {
        gl.glDeleteProgram().?(self.rendererID);
        self.uniform_location_catch.deinit();
    }

    pub fn bind(self: *Shader) void {
        gl.glUseProgram().?(self.rendererID);

    }

    pub fn unbind(self: *Shader) void {
        _ = self;
        gl.glUseProgram().?(0);
    }

    fn getUniformLocation(self: *Shader, name: []const u8) i32 {
        if (self.uniform_location_catch.contains(name)) {
            return self.uniform_location_catch.get(name).?;
        }

        const location: i32 = gl.glGetUniformLocation().?(self.rendererID, name.ptr);
        if (location == -1) {
            std.debug.print("Cant find shader {s} variable {s} location", .{self.filepath, name});
            return -1;
        }

        self.uniform_location_catch.put(name, @as(u32, @intCast(location)));

        return location;
    }

    pub fn setUniform4f(self: *Shader, name: []const u8, v0: f32, v1: f32, v2: f32, v3: f32) void {
        gl.glUniform4f().?(self.getUniformLocation(name), v0, v1, v2, v3);
    }
};
