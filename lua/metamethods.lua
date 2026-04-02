local function addTableValues(x, y)
    return x.num + y.num
end

local metatable = {
    __add = addTableValues,
    __sub = function(x, y)
        return x.num - y.num
    end
}

local tbl1 = {num = 40}
local tbl2 = {num = 59}

setmetatable(tbl1, metatable)

local a = tbl1 + tbl2
local b = tbl1 - tbl2

print(a)
print(b)


--[[
    __add = +
    __sub = -
    __mul = *
    __div = /
    __mod = %
    __pow = ^
    __concat = ..
    __len = #
    __eq = ==
    __lt = <
    __le = <=
    __gt = >
    __ge = >=
--]]
