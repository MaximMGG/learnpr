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

T = {}
T[1] = 1
T[2] = 3
T[10000] = 9
print(#T)
print(T[10000], #T)

T = {"hello", print, 5, 4, {[2] = 88, [3] = 3}}

for k, v in pairs(T) do
    print(k, v)
    if (type(v) == "table") then
        for k, v in pairs(T[k]) do
            print(k, v)
        end
    end
end








