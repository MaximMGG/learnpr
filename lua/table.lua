file = {}

local f =io.open("corout.lua", "r")
if f ~= nil then
    -- for i = 1, 10 do
    --     file[i] = f:read("l")
    -- end

    -- for i = 1, #file do
    --     print(file[i])
    -- end

    local s

    while true do
         s = f:read("l")
         if s == nil then
             break
         end
         print(s)
    end
end

f:close()
