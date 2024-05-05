local x = 2
local y = 3


VESION = "1.4.2"


local len = VESION.len(VESION)


print(x + y)

local fu = function(xx, yy)
    return xx + yy
end

--Hello
print(fu(12, 123))



-- multi line string
local disc =
[[HTTP
        GET
        PUT
        START]]

print(disc)


_G.hello = "HEllo"



--print types



print("0-------------------0")


local types = {}

types.number = 100
types.string = "string"
types.boolean = true
types.float = 1.43
types.double = 1232451234.2342
types.long = 19000000000
types.table = {}
types.nill = nil

print(type(types.number)) -- number
print(type(types.string)) -- string
print(type(types.boolean)) -- boolean
print(type(types.float)) -- number
print(type(types.double)) -- number
print(type(types.long)) -- number
print(type(types.table)) -- table
print(type(types.nill)) -- nil




