import std/[dirs, paths, os, strutils]

type Writer = ref object
  fd: File
  buf: array[4096, char]
  index: int

proc flush(w: var Writer) =
  discard w.fd.writeChars(w.buf, 0, w.index)

proc append(w: var Writer, s: string) =
  if w.index + s.len >= 4096:
    w.flush()
    zeroMem(addr w.buf[0], 4096)
    w.index = 0
    
  w.buf[w.index..(w.index + s.len - 1)] = s[0..^1]
  w.index += s.len

proc printDip(w: var Writer, dip_level: int) =
  for i in 0 ..< dip_level:
    w.append("  ")

proc remExe(w: var Writer, path: Path, dip_level: int) =
  printDip(w, dip_level)
  w.append("Entering '" & path.string & "' -> \n")

  for i in walkDir(path, true):
    if i.path.string[0] == '.': continue
    let full_path = path.string & "/" & i.path.string
    case i.kind:
    of PathComponent.pcFile:
      let fi = getFileInfo(full_path)
      if fpUserExec in fi.permissions:
        if not i.path.string.endsWith(".sh"):
          printDip(w, dip_level)
          w.append("\x1b[31mDelete exe: " & full_path & "\x1b[0m\n")
          removeFile(full_path)
          printDip(w, dip_level)
    of pcDir:
      remExe(w, Path(full_path), dip_level + 1)
    else:
      echo ""

var w = Writer(fd: stdout)
remExe(w, Path("."), 0)
w.flush
