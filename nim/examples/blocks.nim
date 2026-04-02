

if true:
  echo "Nim is greate!"

while false:
  echo "This line is never output!"

block:
  echo "This line, on the other hand, alwas output"


block outer:
  for i in 0..2000:
    for j in 0..2000:
      if i + j == 3145:
        echo i, " ", j
        break outer

let b = 3
block:
  let b = "3"


proc square(inSeq: seq[float]): seq[float] = (result = newSeq[float](len(inSeq));
     for i, v in inSeq: (
       result[i] = v*v
     )
)

let f_seq: seq[float] = @[1.1, 2.2, 3.3]


let f2_seq = f_seq.square()


echo repr(f2_seq)
