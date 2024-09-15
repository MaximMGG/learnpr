local file = io.open(".build", "r")

if file ~= nil then
    for i in file:lines() do
        if i == "main.c" then
            print("CABUCHA")
            for j in file:lines() do
                print("->" .. j)
            end
        end
        print(i)
    end
end
