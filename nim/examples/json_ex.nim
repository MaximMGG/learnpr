import json

let element = "Hydrogen"
let atomicNumber = 1

let jsonObject = %* {"element": element, "atomicNumber": atomicNumber}

echo $jsonObject


let jsonObject2 = """{"name": "Sky", "age": 32}"""
let jsonArray = """[7, 8, 9]"""

let parsedJson = parseJson(jsonObject2)
let arrayJson = parseJson(jsonArray)
let name = parsedJson["name"].getStr()
let age = parsedJson["age"].getInt()

echo name
echo age
echo arrayJson[0]


type
  Element = object
    name: string
    atomicNumber: int


let jsonObject3 = parseJson("""{"name": "Carbon", "atomicNumber": 6}""")

let element_e = to(jsonObject3, Element)

echo element_e.name
echo element_e.atomicNumber
