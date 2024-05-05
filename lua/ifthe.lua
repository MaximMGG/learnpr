
local a = 2


-- if statement with and
if a ~= nil and a > 2 then
    print(true)
else
    print("a is nil")
end

-- if statement with or
if a == nil or a > 1 then
    print(a)
end

local name = "Mickan"

if #name > 3 and name == "Mick" then
    print(name .. "'s lengh if name is " .. #name)
end

if not(#name > 3) and name == "Mic" then
    print(name)
end


if name == "Mic" then
    print("shor name is " .. name)
elseif name == "Mick" then
    print("full name is " .. name)
end


-- like strcmp(name, "Mick") == 0 ? name : strlen(name)
print(name == "Mick" and name or #name)

