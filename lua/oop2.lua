local function Pet(name)
    name = name or "Nothins"
    return {
        name = name,
        status = "Hungry",

        feed = function(self)
            self.status = "Full"
        end
    }
end




local function Dog(name, breed)
    local dog = Pet(name)

    dog.breed = breed
    dog.loyality = 0

    dog.isLoyal = function(self)
        return self.loyality >= 10
    end

    dog.bark = function(self)
        print("Bark")
    end

    dog.feed = function(self)
        if self.status == "Hungry" then
            self.status = "Full"
        else
        end
    end

    dog.print = function(self)
        local p = string.format("Name is %s\nBreed is %s\nLoyality is %d\nStatus is %s\n", self.name, self.breed, self.loyality, self.status)
        print(p)
    end

    return dog
end


local l = Dog("Doggy", "Poodle")
l:print()
