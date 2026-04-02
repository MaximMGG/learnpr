

type
  ThreeStringAddress = array[3, string]

let names: ThreeStringAddress = ["Jasmine", "Kriszitina", "Kristof"]
let addresses = ThreeStringAddress(["101 Betburweg", "66 Bellion Drive", "194 Learderweg"])

echo names
echo addresses


proc zip[I, T](a, b: array[I, T]): array[I, tuple[a, b: T]] =
  for i in low(a)..high(a):
    result[i] = (a[i], b[i])


let nameAndAddresses = names.zip(addresses)

echo nameAndAddresses


type
  PartsOfSpeech {.pure.} = enum
    Pronoun, Verb, Article, Adjective, Noun, Adverb


let partOfSpeechExamples: array[PartsOfSpeech, string] = [
  "he", "reads", "the", "green", "book", "slowly"
]

echo partOfSpeechExamples



type
  Vector[I: static[int]] = array[1..I, int]


type
  Matrix[W, H: static[int]] = array[0..W - 1, array[0..H - 1, int]]


proc `+`[W, H](a, b: Matrix[W, H]): Matrix[W, H] =
  for i in 0..high(a):
    for j in 0..high(a[0]):
      result[i][j] = a[i][j] + b[i][j]

  
let vec1: Vector[3] = [1, 2, 3]

let mat1: Matrix[2, 2] = [[1, 1], [2, 2]]
let mat2: Matrix[2, 2] = [[3, 3], [4, 4]]

echo vec1
echo mat1

let mat3 = mat1 + mat2

echo mat3
