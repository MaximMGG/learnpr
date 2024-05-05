local str = "test string"


print(#str) -- length of string
local str_len = #"test string" -- the same
print(str_len)


local x = 234
local y = tostring(x)

print(type(x) .. " and " .. type(y))
print("hello \nworld")


local bchar  = "HELLO"
print(string.lower(bchar))
local f = string.format("%d %s %d", 123, " hello ", 3)
print(f)
local s_to_fine = "Hello my name is Bob my name is Selly"
local s, e = string.find(s_to_fine, "my", 8, false)
local m = string.sub(s_to_fine, s, e)
-- local m = string.sub(s_to_fine, string.find(s_to_fine, "my", 8, true)) the
-- same
print(s, e)
print(m)

print(s_to_fine)
local new_str = string.gsub(s_to_fine, "Bob", "Billy")
print(new_str)



