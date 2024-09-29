#! /bin/lua

local file = io.open(".build", "r")

local help_info = [[
build init - for initialization .build file
]]

local build_config = [[
bin_name:
       
src:

lib:

falgs:
]]

if arg[1] == "init" then
    local f = io.open(".build", "w");
    if f ~= nil then
        f:write(build_config)
        f:close()
    end
    print("Build initialized");
    os.exit(0)
end

if arg[1] == "--help" then
    print(help_info)
    os.exit(0)
end

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

if src == "" then
    print("Do not find any src's files");
    os.exit(0)
end


local to_exe = "gcc -o " .. bin_name .. " " .. src .. " " .. libs .. " " .. flags
print(to_exe)

os.execute(to_exe)

