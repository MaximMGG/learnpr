--local c = require("cc").math(1.4, 4)

local r1 = coroutine.create(
    function()
        for i = 1, 10, 1 do
            print("coroutine1: " .. i)
            if i == 5 then
                coroutine.yield()
            end
        end
    end
)


local routine_func = function()
    for i = 1, 10, 1 do
        print("coroutine2: " .. i)
    end
end

local r2 = coroutine.create(routine_func)

coroutine.resume(r1)
coroutine.resume(r2)
print(coroutine.status(r1))

if coroutine.status(r1) == "suspended" then
    coroutine.resume(r1)
end
print(coroutine.status(r1))
print(coroutine.status(r2))

--c.math(1, 4)


