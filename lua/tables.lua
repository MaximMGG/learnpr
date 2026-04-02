local t = {4, 132, 1, 585, -2, 43, 44}

-- local names = table.pack("Ban", "Nani", "Bob")


-- for i = 1, #names do
--     print(names[i])
-- end

table.sort(t)

for i = 1, #t do
    print(t[i])
end


local s = {"Hello", "i", "am", "Steve"}


print(table.concat(s, " "))

table.insert(s, 2, "world")

print(table.concat(s, " "))

local Print = {
    p_numer = function(l)
        print("Print table", l)
        for i = 1, #l do
            print(l[i])
        end
    end,
    p_string = function(l)
        print("Print string table", l)
        for i = 1, #l do
            print("String -> " .. l[i])
        end
    end
}

Print.p_numer(s)
Print.p_string(s)


