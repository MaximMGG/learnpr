local f = io.open("e.bmp", "r")
local file_content
if f ~= nil then
    file_content = f:read("a")
end

print(tonumber(file_content))

io.close(f)
