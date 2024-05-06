local s = "hello \a"
print(s)
io.write("a\a")
print("\u{3b1} \u{3b2} \u{3b3}")

local html = [[
<html>
<head>
    <title>Hello from image</title>
</head>
<body>
    <a href="http://lua.org">Lua</a>
</body>
</html>
]]

local f = io.open("hello.html", "w")
if f ~= nil then
    f:write(html)
end

io.close(f)


local insert = function(str, pos, i)
    local b = string.sub(str, 0, pos - 1)
    local b2 = string.sub(str, pos, #str)
    return b .. i .. b2
end

print(insert("hello world!", 1, "start: "))
print(insert("hello world!", 7, "middle: "))
print(insert("hello world!", 13, " end:"))

local remove = function(str, start, count)
    local b = string.sub(str, 0, start - 1)

    for i = start, #str, 1 do
        if count > 0 then
            count = count - 1
        else
            b = b .. str:sub(i, i)
        end
    end
    return b
end

print(remove("hello world", 7, 3))
