---@class dog
dog = {
    name = "Bob",
    age = 6,
    friends = {"Jilly", "Billy"}
}


local function Pet(name)
    name = name or "Nothing"
    return {
        name = name,
        status = "hungry",

        feed = function(self)
            self.status = "Full"
        end


    }
end

local cat = Pet()

print(cat.name)
local d = Pet("Maoly")
print(d.name)
print(d.status)
d:feed()
print(d.status)


return dog
