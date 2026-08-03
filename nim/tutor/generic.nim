import std/math

type BinaryTree*[T] = ref object
  le, ri: BinaryTree[T]
  data: T


proc newNode*[T](data: T): BinaryTree[T] =
  new(result)
  result.data = data


proc add*[T](root: var BinaryTree[T], n: BinaryTree[T]) =
  if root == nil:
    root = n
  else:
    var it = root
    while it != nil:
      var c = cmp(it.data, n.data)
      if c < 0:
        if it.le == nil:
          it.le = n
          return
        it = it.le
      else:
        if it.ri == nil:
          it.ri = n
          return
        it = it.ri
          
proc add*[T](root: var BinaryTree[T], data: T) =
  root.add(newNode(data))

iterator preoder*[T](root: BinaryTree[T]): T =
  var stack: seq[BinaryTree[T]] = @[root]
  while stack.len > 0:
    var n = stack.pop()
    while n != nil:
      yield n.data
      add(stack, n.ri)
      n = n.le



var root: BinaryTree[string]
add(root, newNode("Hello"))
add(root, newNode("World"))

for str in root.preoder():
  stdout.writeLine(str)


echo "Tempalates"

template `!=` (a, b: untyped): untyped =
  not (a == b)

assert(7 != 3)

const debug = true

template log(msg: string) =
  if debug: stdout.writeLine(msg)

var x = 4
log("x has the value: " & $x)

template withFile(f: untyped, filename: string, mode: FileMode, body: untyped) =
  let fn = filename
  var f: File
  if open(f, fn, mode):
    try:
      body
    finally:
      close(f)
  else:
    quit("Cannot open: " & fn)


withFile(txt, "ttempl3.txt", fmWrite):
  txt.writeLine("line 1")
  txt.writeLine("line 2")



template liftScalarProc(fname) =


  proc fname[T](x: openarray[T]): auto =
    var temp: T
    type outType = typeof(fname(temp))
    result = newSeq[outType](x.len)
    for i in 0 ..< x.len:
      result[i] = fname(x[i])


liftScalarProc(sqrt)
echo sqrt(@[4.0, 16.0, 25.0, 36.0])
