package calc


import "core:testing"



@(test)
tokenize_test :: proc(t: ^testing.T) {
    user_input := "2 + 3 * (1 - 7)"
    tokens, tokens_ok := tokenize(transmute([]u8)user_input)
    defer delete(tokens)

    testing.expect_value(t, f64(2), tokens[0].val)




}
