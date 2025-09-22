package strings_example


import "core:fmt"
import "core:strings"
import "core:unicode/utf8"
import vmem "core:mem/virtual"


main :: proc() {
    //one()
    //two()
    //three()
    //four()
    five()
}


one :: proc() {
    my_string := "Hello world!"


    copy_string := strings.clone(my_string)
    defer delete(copy_string)

    fmt.printfln("%s address %p, raw_data %p", my_string, &my_string, raw_data(my_string))
    fmt.printfln("%s address %p, raw_data %p", copy_string, &copy_string, raw_data(copy_string))

    for c in my_string {
	fmt.print(c)
    }
    fmt.println()

    string_slice := my_string[:]

    str := "小猫咪"

    for c, i in str {
	fmt.println(i, c)
    }

    for c, i in str {
	from_start := str[:i]
	fmt.println(from_start)
    }

    fmt.println("----")
    
    for c, i in str {
	from_start := str[:i + utf8.rune_size(c)]
	fmt.println(from_start)
    }

    str2 := "g̈"

    for r in str2 {
	fmt.println(r)
    }

    g, c, u, t := utf8.decode_grapheme_clusters(str2)
    defer delete(g)
    fmt.printfln("%v\n%v\n%v\n%v", g, c, u, t)
}


two :: proc() {
    name := "Pontus"
    age := 7
    str := fmt.tprint(name, "is", age)
    delete(str, allocator = context.temp_allocator)
    fmt.println(str)

    str2 := fmt.tprint(name, "is", age, sep = " really ")
    delete(str2, allocator = context.temp_allocator)
    fmt.println(str2)

}

three :: proc() {
    lines := []string{
	"I like",
	"I look for",
	"Where are the",
    }

    b := strings.builder_make()

    for l, i in lines {
	strings.write_string(&b, l)

	if i != len(lines) - 1 {
	    strings.write_string(&b, " cats.\n")
	} else {
	    strings.write_string(&b, " cats?")
	}
    }

    str := strings.to_string(b)
    fmt.println(str)
    strings.builder_destroy(&b)

}

make_some_string :: proc() -> [dynamic]string {
    strs: [dynamic]string

    strs_add :: proc(strs: ^[dynamic]string, s: string) {
	append(strs, strings.clone(s))
    }

    strs_add(&strs, "Hellope!")
    strs_add(&strs, "Hi!")
    strs_add(&strs, "Dynamiclly allocated!")
    strs_add(&strs, "Not constat any more!")
    strs_add(&strs, "Dynamic")
    return strs
}


four :: proc() {
    strs := make_some_string()

    for s in strs {
	delete(s)
    }

    delete(strs)

    fmt.println("Probably got here!")
}


make_some_strings2 :: proc() -> ([dynamic]string, vmem.Arena) {
    arena: vmem.Arena
    strs: [dynamic]string
    arena_allocator := vmem.arena_allocator(&arena)
    append(&strs, "Hellope!")
    append(&strs, "Hi!")
    append(&strs, strings.clone("Dynamiclly allocated", arena_allocator))
    append(&strs, "Constant!")
    append(&strs, strings.clone("Dynamic!", arena_allocator))

    return strs, arena
}

five :: proc() {
    strs, strs_arena := make_some_strings2()

    vmem.arena_destroy(&strs_arena)
    delete(strs)
    fmt.println("Probablly got here2!")
}
