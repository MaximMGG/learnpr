local arr = {}

for i = 0, 1000000, 1 do
    if i % 7 == 0 or i % 10 == 7 then
        arr[i] = "SMAC"
    else
        arr[i] = i
    end
end

for i = 1, #arr, 1 do
    print(arr[i])
end
