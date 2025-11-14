package remexe


import "core:fmt"
import "core:os"
import "core:strings"

EXCEPTION : []string : {
    "remexe",
}

EXTENTIONS : []string : {
    "sh"
}

check_exception :: proc(file_name: string) -> bool {
    s := strings.split(file_name, "/")
    defer delete(s)

    for e in EXCEPTION {
	if s[len(s) - 1] == e {
	    return false
	}
    }

    dot_index := strings.index_byte(s[len(s) - 1], '.')
    if dot_index != -1 {
	dot_s := strings.split(s[len(s) - 1], ".")

	for e in EXTENTIONS {
	    if dot_s[1] == e {
		return false
	    }
	}
    }
    
    return true
}


print_level :: proc(level: int) {
    for _ in 0..<level {
	fmt.print("  ")
    }
}

check_dir :: proc(s: string, level: int) {
    dir, err := os.open(s)
    defer os.close(dir)

    if err != os.ERROR_NONE {
        fmt.printf("Could not open dir %s\n", s)
        os.exit(1)
    }
    print_level(level)
    fmt.println("Check dir:", s, "...")
    fin: []os.File_Info

    fin, err = os.read_dir(dir, -1)
    if err != os.ERROR_NONE {
        fmt.printf("Could not read dir %s\n", s)
        os.exit(1)	
    }
    defer os.file_info_slice_delete(fin)

    for fi in fin {
        if fi.is_dir {
            dot_index := strings.index_byte(fi.fullpath, '.')
            if dot_index == -1 {
                check_dir(fi.fullpath, level + 1)
                continue
            }
        } else if (fi.mode & os.S_IXUSR != 0) {
            if check_exception(fi.fullpath) {
                os.remove(fi.fullpath)
                print_level(level)
                fmt.println("Removing:", fi.fullpath)		
            }
        }
    }
}


main :: proc() {
    fmt.println("START REM EXECUTABLE")
    check_dir(".", 0)
    fmt.println("END REM EXECUTABLE")
    
}
