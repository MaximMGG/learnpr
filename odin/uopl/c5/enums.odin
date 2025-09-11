package enums


import "core:fmt"


Computer_Type :: enum {
    Laptop = 1,
    Desktop = 2,
    Mainframe = 234,
}

main :: proc() {
    ct: Computer_Type
    ct = .Mainframe

    ct = Computer_Type.Desktop


    switch ct {
    case .Laptop:
	fmt.println("It's laptop")
    case .Desktop:
	fmt.println("It's desktop")
    case .Mainframe:
	fmt.println("Wow, a mainframe, in 2024?")
    }
    fmt.println("#partial switch")

    #partial switch ct {
	case .Laptop:
	fmt.println("Laptop")
    }

    fmt.println(Computer_Type.Desktop)
    fmt.println(Computer_Type.Laptop)
    fmt.println(Computer_Type.Mainframe)


    fmt.println(int(Computer_Type.Desktop))
    fmt.println(int(Computer_Type.Laptop))
    fmt.println(int(Computer_Type.Mainframe))
}

Animal_Type :: enum u8 {
    Cat,
    Rabbit,
}
