-- io.output("hello.txt")
-- io.write("Hello world!")
-- io.close()


-- io.input("hello.txt")
--
-- local f = io.read()
--
-- io.close()
--
-- print(f)


local file = io.open("hello.txt", "a")

if file ~= nil then

    file:write("Hello my name is Bob\n")

    file:write([[<html>
    <head>
    <title>Hello</title>
    </head>]])

    file:close()
end

function assertion(v, msg)
    if v == nil then
        io.stderr:write(msg)
    end
    return v
end


local f = assertion(io.open("loop.lua", "r"), "File does not exist")

local fs = f:read("l")
print(fs)


local exf = io.open("example.txt", "w")
if exf ~= nil then
    exf:write("Hello from example")
    exf:close()
end



