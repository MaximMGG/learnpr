local n1, n2 = 14, 17
print("What is by " .. n1 .. " + " .. n2 .. "?")
local user_answer = io.read()
if (tonumber(user_answer) == n1 + n2) then
    print("Yes, your are right!")
else
    print("Unfortunatly not, right answer is " .. n1 + n2)
end
