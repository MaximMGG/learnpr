

type Animal = ref object of RootObj
  name: string
  age: int
  
method vocalize(self: Animal): string {.base.} = "..."
method ageHumanYrs(self: Animal): int {.base.} = self.age

type Dog = ref object of Animal
method vocalize(self: Dog): string = "woof"
method ageHumanYrs(self: Dog): int = self.age * 7

type Cat = ref object of Animal
method vocalize(self: Cat): string = "meow"


var animals: seq[Animal] = @[]

animals.add(Dog(name: "Sparky", age: 10))
animals.add(Cat(name: "Mitten", age: 10))

for a in animals:
  echo a.vocalize()
  echo a.ageHumanYrs()


echo(animals[0] of Dog)
echo(animals[0] of Cat)
echo(animals[0] of Animal)
