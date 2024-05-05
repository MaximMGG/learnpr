-- _G. this is global scope

local f_e = function(x, y)
    return x + 2, y + 54
end



local _, b = f_e(1, 2) -- if we do not need to use one of return variables from function

print(b)


print(f_e(23, 34))

local function count()
    local c = 0
    return function()
        c = c + 1
        return c
    end
end

local f_c = count()

print(f_c())
print(f_c())
print(f_c())
print(f_c())
print(f_c())


local file = [[#include <stdio.h>

int main() {
    printf("Hello world\n");
    return 0;
}]]


local f_func = [[
void print_s(char *s) {
    printf("%s\n", s);
}]]

local f = io.open("test.c", "a")
if f ~= nil then
    -- f:write(f_func)
end
io.close(f)


-- io.open("example.txt", "w"):write("Hello")


print("================================")

local function print_t(...)
    for k, v in pairs({...}) do
        print(k, type(v) == "table" and "table" or v)
    end
end


print_t(1, 5, 2, 5, 1, 2)

print_t("Hello", 1, "by", "no", {1, 5})


