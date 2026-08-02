
var
  x*, y: int

proc `*` *(a, b: seq[int]): seq[int]=
  newSeq(result, len(a))

  for i in 0 ..< len(a): result[i] = a[i] * b[i]


when isMainModule:
  assert(@[1, 2, 3] * @[1, 2, 3] == @[1, 4, 9])
