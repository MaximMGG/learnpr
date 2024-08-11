#!/bin/lua

os.execute("ls > .temp")

local f = io.open("temp", "r")
local file

if f ~= nil then
    file = f:lines("all")
end

for n in file do
    print(n)
end

os.execute("rm .temp")
