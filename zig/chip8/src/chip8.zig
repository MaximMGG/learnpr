const std = @import("std");
const c = @cImport({
    @cInclude("stdlib.h");
    @cInclude("time.h");
});


opcode: u16,
memory: [4096]u8,
graphycs: [64 * 32]u8,
registers: [16]u8,
index: u16,
program_counter: u16,

delay_timer: u8,
sound_timer: u8,

stack: [16]u16,
sp: u16,

keys: [16]u8,

const chip8_fontset = [_]u8{
    0xF0, 0x90, 0x90, 0x90, 0xF0, // 0
    0x20, 0x60, 0x20, 0x20, 0x70, // 1
    0xF0, 0x10, 0xF0, 0x80, 0xF0, // 2
    0xF0, 0x10, 0xF0, 0x10, 0xF0, // 3
    0x90, 0x90, 0xF0, 0x10, 0x10, // 4
    0xF0, 0x80, 0xF0, 0x10, 0xF0, // 5
    0xF0, 0x80, 0xF0, 0x90, 0xF0, // 6
    0xF0, 0x10, 0x20, 0x40, 0x40, // 7
    0xF0, 0x90, 0xF0, 0x90, 0xF0, // 8
    0xF0, 0x90, 0xF0, 0x10, 0xF0, // 9
    0xF0, 0x90, 0xF0, 0x90, 0x90, // A
    0xE0, 0x90, 0xE0, 0x90, 0xE0, // B
    0xF0, 0x80, 0x80, 0x80, 0xF0, // C
    0xE0, 0x90, 0x90, 0x90, 0xE0, // D
    0xF0, 0x80, 0xF0, 0x80, 0xF0, // E
    0xF0, 0x80, 0xF0, 0x80, 0x80, // F
};

const Self = @This();

pub fn init(self: *Self) void {
    c.srand(@as(u32, @intCast(c.time(0))));

    self.program_counter = 0x200;
    self.opcode = 0;
    self.index = 0;
    self.sp = 0;
    self.delay_timer = 0;
    self.sound_timer = 0;

    @memset(&self.memory, 0);
    @memset(&self.graphycs, 0);
    @memset(&self.registers, 0);
    @memset(&self.stack, 0);
    @memset(&self.keys, 0);

    for(self.chip8_fontset, 0..) |char, index| {
        self.memory[index] = char;
    }

}

fn increment_pc(self: *Self) void {
    self.program_counter += 2;
}


pub fn cycle(self: *Self) void {
    self.opcode = self.memory[self.program_counter] << 8 | self.memory[self.program_counter + 1];

    //X000
    var first = self.opcode >> 12;

    switch(first) {
        0x0 => {
            if (self.opcode == 0x00E0) {
                @memset(&self.graphycs, 0);
            } else if (self.opcode == 0x00EE) {
                self.sp -= 1;
                self.program_counter = self.stack[self.sp];
            }
            self.increment_pc();
        },
        0x1 => {
            self.program_counter = self.opcode & 0x0FFF;
        },
        0x2 => {
            self.stack[self.sp] = self.program_counter;
            self.sp += 1;
            self.program_counter = self.opcode & 0x0FFF;

        },
        0x3 => {
            const x = (self.opcode & 0x0F00) >> 8;
            if (self.registers[x] == (self.opcode & 0x00FF)) {
                self.increment_pc();
            }
            self.increment_pc();

        },
        0x4 => {
            const x = (self.opcode & 0x0F00) >> 8;
            if (self.registers[x] == (self.opcode & 0x00FF)) {
                self.increment_pc();
            }
            self.increment_pc();

        },
        0x5 => {
            const x = (self.opcode & 0x0F00) >> 8;
            const y = (self.opcode & 0x00F0) >> 4;
            if (self.registers[x] == self.registers[y]) {
                self.increment_pc();
            }
            self.increment_pc();
        },
        0x6 => {
            const x = (self.opcode & 0x0F00) >> 8;
            self.registers[x] = @truncate(self.opcode & 0x00FF);

        },
        0x7 => {
            @setRuntimeSafety(false);
            const x = (self.opcode & 0x0F00) >> 8;
            self.registers[x] += @truncate(self.opcode & 0x00FF);

        },
        0x8 => {
            const x = (self.opcode & 0x0F00) >> 8;
            const y = (self.opcode & 0x00F0) >> 4;
            const m = (self.opcode & 0x000F);

            switch(m) {
                0 => self.registers[x] = self.registers[y],
                1 => self.registers[x] |= self.registers[y],
                2 => self.registers[x] &= self.registers[y],
                3 => self.registers[x] ^= self.registers[y],
            }

            self.increment_pc();
        },
        0x9 => {
            const x = (self.opcode & 0x0F00) >> 8;
            const y = (self.opcode & 0x00F0) >> 4;
            if (self.registers[x] == self.registers[y]) {
                self.increment_pc();
            }
            self.increment_pc();
        },
        else => {}
    }


}

