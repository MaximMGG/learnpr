local arr = {1, 2, 3, 4, 5, 6, "Hello"}

for i = 1, 10, 1 do
    print(i)
end

-- print all table
for i = arr[1], #arr, 1 do
    print(arr[i])
end

-- iteration be 1
for i = 1, #arr do
    print(arr[i])
end


--print(arr[1])

local p = 10

while p > 0 do
    print(p)
    p = p - 1
end


print("---")

repeat
    print(p)
    p = p + 1
until p > 10
