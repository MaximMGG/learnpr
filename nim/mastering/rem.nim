import system, os, posix

iterator readdirIt(dir: ptr posix.DIR): ptr posix.Dirent =
    var d = dir.readdir()
    while d != nil:
        yield d
        d = dir.readdir()


proc strFromArray(arr: array[0..255, cchar]): string =
    result = ""
    for c in arr:
        if ord(c) == 0:
            return
        else:
            result.add(c)

proc printTab(level: int) =
    for i in 0..<level:
        write(stdout, "  ")

proc checkDir(d_name: string, level: int) =
    var dir = posix.opendir(d_name)
    printTab(level)
    echo "Check dir: ", d_name

    for d in readdirIt(dir):
        if d.d_type == DT_DIR:
            if d.d_name[0] == '.': continue
            else:
                var name = strFromArray(d.d_name)
                checkDir(d_name & "/" & name, level + 1)
                continue
        if d.d_type == DT_REG:
            var name = strFromArray(d.d_name)
            var full_path: string  = d_name & "/" & name
            var a_stat: posix.Stat
            discard posix.stat(cstring(full_path), a_stat)
            if (a_stat.st_mode and uint32(posix.S_IXUSR)) > 0:
                printTab(level)
                echo "Delete executable: ", full_path
                os.removeFile(full_path)
    discard dir.closedir()

checkDir(".", 0)

