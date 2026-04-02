

local tmp = os.tmpname()

local f = io.open(tmp, "r")

os.execute("echo \"HELLO\n\" >> " .. tmp)
os.execute("pwd >> " .. tmp)

if f ~= nil then
    local c = f:read("a")
    print(c)
end


