#! /bin/lua

if arg[1] == nil then
    print("Do not setup file")
    os.exit(1)
end

if arg[2] ~= nil then

if arg[2] == "-d" then
    os.execute("odin build " .. arg[1] .. ".odin -file -debug")
elseif arg[2] == "-r" then
    os.execute("odin build " .. arg[1] .. ".odin -file && ./" .. arg[1])
elseif arg[2] == "-v" then
    os.execute("odin build " .. arg[1] .. ".odin -file && valgrind ./" .. arg[1])
else
    os.execute("odin build " .. arg[1] .. ".odin -file")
end
else
    os.execute("odin build " .. arg[1] .. ".odin -file")
end
