local p = os.time({
    year = 2000,
    month = 10,
    day = 3,
    hour = 13,
    min = 20,
    sec = 59
})

-- print(os.time() - p)
-- print(os.difftime(os.time(), p))
-- same
print(os.clock())

os.execute("ls")
os.execute("echo $HOME")

print(os.getenv("HOME"))
os.remove("hello.txt")


local createdir = function(name)
    os.execute("mkdir " .. name)
end


--createdir("Hello")

print("====================================")

local f = assert(io.popen("ls"), "not execute")
local dir = {}

for entry in f:lines() do
    dir[#dir + 1] = entry
end

for i = 1, #dir do
    print(dir[i])

    if (dir[i] == "example.txt") then
        os.remove(dir[i])
    end
end


