import std/tables

proc increment_key(s: var string): bool =
  var i = s.len - 1
  while true:
    if s[i] < '9':
      s[i] = chr(ord(s[i]) + 1)
      break
    else:
      s[i] = '0'
      dec i
  if s[3] == '1':
    return false

  return true



proc map_process() =
  var 
    key = "Key000000"
    val: int = 1
    m = initTable[string, int]()
    m2: Table[string, int]

  while increment_key(key):
    m[key] = val
    inc val
  
  var total: int = 0
  for k, v in pairs(m):
    echo "Key -> " & k & ", Val -> " & $v
    inc total
  echo "Total elements: " & $total

map_process()
