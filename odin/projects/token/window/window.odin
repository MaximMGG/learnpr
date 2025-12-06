package window



foreign import ncurses {
  "system:ncurses",
}

WINDOW :: struct {}

@(default_calling_convention = "c")
foreign ncurses {
  initscr :: proc() -> ^WINDOW ---

}
