#! /bin/lua

local src = { "main.c" }

local s = ""

for i = 1, #src do
    s = s .. src[i] .. " "
end

if arg[1] == "-d" then
    os.execute("gcc -o prog " .. s .. "-lglfw -lGL -lGLEW -g && ./prog")
elseif arg[1] == "-v" then
    os.execute("gcc -o prog " .. s .. "-lglfw -lGL -lGLEW && valgrind ./prog")
else
    os.execute("gcc -o prog " .. s .. "-lglfw -lGL -lGLEW && ./prog")
end
