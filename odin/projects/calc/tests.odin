package calc


import "core:testing"



@(test)
tokenize_test :: proc(t: ^testing.T) {
    user_input := "2 + 3 * (1 - 7)"
    tokens, tokens_ok := tokenize(transmute([]u8)user_input)
    defer delete(tokens)

    testing.expect_value(t, f64(2), tokens[0].val)




}



//(2 + 3 - (4 * 1 + (1 + 1)))

//(3 + 3) + (1 + 8 - (3 + 3))

@(test)
answer_test_1 :: proc(t: ^testing.T) {
    expression := "(2 + 3 - (4 * 1 + (1 + 1)))" // -1
    expression_tokens, tokens_ok := tokenize(transmute([]u8)expression)
    testing.expect(t, tokens_ok == .None, "Tokens not .None")
    answer, answer_ok := process_calculation(&expression_tokens)
    testing.expect(t, answer_ok == .None, "Answer is not ok")
    testing.expect_value(t, answer, f64(-1))
    delete(expression_tokens)
}

@(test)
answer_test_2 :: proc(t: ^testing.T) {
    expression := "(3 + 3) + (1 + 8 - (3 + 3))" // 9
    expression_tokens, tokens_ok := tokenize(transmute([]u8)expression)
    testing.expect(t, tokens_ok == .None, "Tokens not .None")
    answer, answer_ok := process_calculation(&expression_tokens)
    testing.expect(t, answer_ok == .None, "Answer is not ok")
    testing.expect_value(t, answer, f64(9))
    delete(expression_tokens)
}
