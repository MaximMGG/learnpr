local file = io.open(".build", "r")

local bin_name = ""
local src = ""
local libs = ""
local flags = ""

if file ~= nil then

    for line in file:lines() do

        if line == "bin_name:" then
            local j = file:read("l")
            bin_name = j
        end
        if line == "src:" then
            for j in file:lines() do
                if j == "" then
                    break
                end
                src = src .. j .. " "
            end
        end
        local lib = "-l"
        if line == "lib:" then
            for j in file:lines() do
                if j == "" then
                    break
                end
                libs = libs .. lib .. j .. " "
            end
        end
        if line == "flags:" then
            for j in file:lines() do
                if j == "" then
                    break
                end
                flags = flags .. j .. " "
            end
        end
    end


    file:close()

end

-- print("bin name: " .. bin_name)
-- print("src: " .. src)
-- print("libs: " .. libs)
-- print("falgs: " .. flags)

local to_exe = "gcc -o " .. bin_name .. " " .. src .. " " .. libs .. " " .. flags
print(to_exe)

os.execute(to_exe)

