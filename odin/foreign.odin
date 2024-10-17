package foreign_odin

foreign import kernel32 "system:kernel32.lib"

@(default_calling_convention = "std")
foreign kernel32 {
    ExitProcess :: proc "stdcall" (eixt_code: u32) ---
}

foreign lib {
    x: i32
}
