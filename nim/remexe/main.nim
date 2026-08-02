import std/[dirs, paths, os]



proc printDip(dip_level: int) =
  for i in 0 ..< dip_level:
    stdout.write("  ")


proc remExe(path: Path, dip_level: int) =
  printDip(dip_level)
  echo "Entering ", path, "dir..."

  for i in walkDir(path):
    case i.kind:
    of PathComponent.pcFile:
      echo "This is file: ", i.path
      let fi = getFileInfo(i.path.string)
      if fpUserExec in fi.permissions:
        printDip(dip_level)
        echo "Delete exe: ", i.path
        removeFile(i.path.string)
        printDip(dip_level)
    of PathComponent.pcLinkToFile:
      echo "link: ", i.path
    of pcDir:
      echo "Dir: ", i.path
      let new_path = path / i.path
      remExe(new_path, dip_level + 1)
    of pcLinkToDir:
      echo "Link to dir: ", i.path



remExe(Path("."), 0)
