package abit_field

import "base:intrinsics"
import "core:fmt"

Keycard :: enum {
    Red,
    Green,
    Blue,
    Yellow,
}

main :: proc() {
    //keycards: bit_set[Keycard]
    keycards: bit_set[Keycard; u8]
    
    keycards += {.Red, .Blue}

    fmt.println(keycards)

    keycards -= {.Red}
    keycards += {.Yellow, .Green}

    fmt.println(.Red not_in keycards)

    numbers: bit_set[0..=5] = {1, 4, 5}
    numbers += {3}

    fmt.println(1 in numbers)


    letters := bit_set['a'..='z']{'r', 'q'}

    letters += {'a', 'b'}

    fmt.println('w' in letters)
    two()
}


Packet_Type :: enum {
    Handshake,
    Message,
    Desconnect,
}

Network_Packet_Header :: bit_field i32 {
    type: Packet_Type  | 8,
    receiver_id: uint  | 8,
    payload_size: uint | 16,
}

two :: proc() {
    h := Network_Packet_Header {
	type = .Message,
	receiver_id = 4,
	payload_size = 1200,
    }

    size := h.payload_size

    fmt.println(h)

    fmt.println("Size of size:", size_of(size))
    fmt.println("Size of payload_size:", size_of(h.payload_size))
    fmt.println("Size of Hetwork_Packet_Header:", size_of(h))

    a: i32 = i32(h)

    fmt.println(a)

    fmt.println(a >> 16)
    fmt.println(u8(a >> 8))
    fmt.println(u8(a))

    print_bit(a)
    fmt.printfln("%32b", a)

//    print_bit(h.type)
    print_bit(h.receiver_id)
    print_bit(h.payload_size)
}

print_bit :: proc(i: $T, loc := #caller_location) where intrinsics.type_is_numeric(T) {
    i := i
    bits_count := uint(size_of(T) * 8 - 1)
    mask := uint(0b0001)

    for b in 0..<size_of(T) * 8 {
	if (mask & uint((i >> bits_count))) == 1 {
	    fmt.print('1')	    
	} else {
	    fmt.print('0')
	}
	bits_count -= 1
    }
    fmt.print('\n')
}
