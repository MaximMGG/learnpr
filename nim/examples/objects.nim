

type
  Animal* = object
    name*, species*: string
    age: int

proc sleep*(a: var Animal) =
  a.age += 1

proc dead*(a: Animal): bool =
  return a.age > 20


var carl: Animal
carl = Animal(name: "Carl", species: "L. glama", age: 12)

let joe = Animal(name: "Joe", species: "H. sapiens", age: 23)


assert(not carl.dead)

for i in 0..10:
  carl.sleep()

assert(carl.dead)
assert(joe.name == "Joe")

let mittens: ref Animal = new(Animal)

mittens.name = "Mittens"
mittens.species = "P. leo"
mittens.age = 6


echo "all good"
